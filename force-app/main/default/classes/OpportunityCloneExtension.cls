/*
* Description: This class is used to clone opportunity records.
* If certain conditions are met while cloning a record, a popup window will appear where the user will have to upload file attachment
* and consequently an email with that attachment is sent to some selected users.
* Test class - OpportunityCloneExtensionTest
*-------------------------------------------------------------------------------------------------------
*  Author                          Date                               Project         
*  Shiwangi Jha                    5/23/2018                          Tavant Internal Sales 
*-------------------------------------------------------------------------------------------------------
*/
public class OpportunityCloneExtension{
    
    public ApexPages.StandardController controller {get;set;}
    public Boolean displayPopup {get;set;}
    public Opportunity opp{get;set;}
    public Opportunity OpportunityCloned {get;set;}
    public transient Map<String, Decimal> probabilityStageNameMap;
    public transient Map<String, String> forecastCategoryNameStageNameMap;
    public List<Attachment> oldAttList{get;set;}
    public  Attachment attachment {
        get{
            if (attachment == null)
                attachment = new Attachment();
            return attachment;
        }
        set;
    }    public  Attachment newAttachment {
        get{
            if (newAttachment == null)
                newAttachment = new Attachment();
            return newAttachment;
        }
        set;
    }
    
    public OpportunityCloneExtension(ApexPages.StandardController controller){
        displayPopup = false;
        this.controller = controller;
        opp = (Opportunity)controller.getRecord();
        opp = [select Id, AccountId, OwnerId, Name, StageName, CloseDate, ForecastCategoryName, Close_Date_Change_Count__c, Probability, Amount, Gross_Margin__c,
               Description, Horizontal_Practice__c, SOW_Start_Date__c, Vertical_Practice2__c, SOW_End_Date__c, Product_Quota__c, Customer_PO_Reference__c, Product_Name__c,
               Related_Opportunity__c, Product_Opportunity_Type__c, LeadSource, PBD__c, CampaignId, GDM__c, Staffing_Requirements__c, CoSalesPerson__c, GDM_Comments__c,
               Staffing_Fulfilled__c, AP_Contact__c, mh_Associated_Blue_Sheet__c, Partner__c from Opportunity where id =: opp.Id];
        
        OpportunityCloned = opp.clone(false,true);
        
        
    }
    
    // This method auto populates Forecast Category and Probability fields whenever Stage is selected.
    public void changeStageName() {
        
        if (probabilityStageNameMap == null) {
            probabilityStageNameMap = new Map<String, Decimal>();
            for (OpportunityStage oppStage : [Select MasterLabel, DefaultProbability From OpportunityStage]) {
                probabilityStageNameMap.put(oppStage.MasterLabel, oppStage.DefaultProbability);}
        } 
        
        if (probabilityStageNameMap != null && probabilityStageNameMap.containsKey(OpportunityCloned.StageName)) {
            OpportunityCloned.Probability = probabilityStageNameMap.get(OpportunityCloned.StageName);
        }  
        
        if (forecastCategoryNameStageNameMap == null) {
            forecastCategoryNameStageNameMap = new Map<String, String>();
            for (OpportunityStage oppStage : [Select MasterLabel, ForecastCategoryName From OpportunityStage]) {
                forecastCategoryNameStageNameMap.put(oppStage.MasterLabel, oppStage.ForecastCategoryName);}
        } 
        if (forecastCategoryNameStageNameMap != null && forecastCategoryNameStageNameMap.containsKey(OpportunityCloned.StageName)) {
            OpportunityCloned.ForecastCategoryName = forecastCategoryNameStageNameMap.get(OpportunityCloned.StageName);
        }        
    }  
    
    // This method saves the Opportunity record.
    public Pagereference save(){   
        
        //Validation rules are checked while saving the record.
        
        Boolean bool = validate(opp);
        system.debug('bool --'+bool);
        if(bool == false){
            return null;
        }else{
            
            /*when Stage is 'Signed Contract' and Probability is 100% 
* then a file upload popup window appears
* otherwise the Opportunity is saved without the popup window 	
*/
            
            if(OpportunityCloned.StageName == 'Signed Contract' && OpportunityCloned.Probability == 100){            
                displayPopup = true;
                return null;
            }
            else{            
                displayPopup = false;
                try{                
                    insert OpportunityCloned;                
                } catch(Exception e){
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage())); 
                    return null;
                }
                PageReference p= new Pagereference('/'+OpportunityCloned.id);
                return p;
            } 
        }       
    }
    
    // This method uploads the attachment via file upload popup window.
    public PageReference upload() {
        
        ID id1 = userinfo.getProfileId();
        String profileName = [select id, Name from profile where id =: id1 LIMIT 1].Name;
        
        if(profileName != 'System Administrator' && profileName != 'Tavant Finance Profile'){
            
            
            if((attachment.body == null && attachment.name == null) || (newAttachment.body == null && newAttachment.name == null)){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please select both SOW file & Deal Sheet.'));
                attachment = null;
                newAttachment = null;
                return null;
            }
            
            
            
            try{                
                insert OpportunityCloned;                
            } catch(Exception e){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage())); 
                return null;
            }
            
            List<Attachment> attachlist = new List<Attachment>();
            attachment.OwnerId = UserInfo.getUserId();
            attachment.ParentId = OpportunityCloned.Id; // the id of opportunity record to which the file is attached.
            attachment.IsPrivate = false; 
            attachlist.add(attachment);
            
            newAttachment.OwnerId = UserInfo.getUserId();
            newAttachment.ParentId = OpportunityCloned.Id; // the id of opportunity record to which the file is attached.
            newAttachment.IsPrivate = false; 
            attachlist.add(newAttachment);
            
            try {  
                insert attachlist;
            } catch (Exception e) {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));
                return null;
            } 
            
            List<ID> attIdList = new List<ID>();
            for(Attachment att: attachlist){
                attIdList.add(att.id);
                
            }
            sendMail(OpportunityCloned.id, attIdList); // sends email with attachment to selected users.
        }
        else{            
            try{                
                insert OpportunityCloned;                
            } catch(Exception e){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage())); 
                return null;
            }
            
            List<Attachment> attachlist = new List<Attachment>();
            
            if(attachment != null && attachment.name != '' && attachment.name != null){
                
                attachment.OwnerId = UserInfo.getUserId();
                attachment.ParentId = OpportunityCloned.Id; // the id of opportunity record to which the file is attached.
                attachment.IsPrivate = false; 
                attachlist.add(attachment);
                
            }
            
            if(newAttachment != null && newAttachment.name != '' && newAttachment.name != null){
                
                newAttachment.OwnerId = UserInfo.getUserId();
                newAttachment.ParentId = OpportunityCloned.Id; // the id of opportunity record to which the file is attached.
                newAttachment.IsPrivate = false; 
                attachlist.add(newAttachment);
                
            }
            
            try { 
                if(!attachlist.isEmpty()){
                    insert attachlist;  
                }  
            } catch(Exception e){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));
                return null;
            }
            
            List<ID> attIdList = new List<ID>();
            
            if(!attachlist.isEmpty()){
                
                for(Attachment att: attachlist){
                    attIdList.add(att.id);    
                } 
            }
            
            sendMail(OpportunityCloned.id, attIdList);
            
            
        }      
        
        PageReference p= new Pagereference('/'+OpportunityCloned.Id);
        return p;
    } 
    
    //This method is used to implement validation rules.
    public Boolean validate(Opportunity opp){
        
        if(opp.ForecastCategoryName == 'Closed' && opp.LeadSource == 'Campaign' && opp.Campaign == null){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, System.Label.Campaign_Lead_Source_Validation_Rule));
            return false;
        }else if(opp.ForecastCategoryName == 'Closed' && opp.SOW_End_Date__c == null){            
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, System.Label.SOW_End_Date_Validation_Rule));            
            return false;
        }else if(opp.ForecastCategoryName == 'Closed' && opp.GDM__c == null){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, System.Label.GDM_Validation_Rule));
            return false;
        }else if(opp.Probability >= 40 && opp.Gross_Margin__c == null){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, System.Label.Gross_Margin_Validation_Rule));
            return false;
        }else if(opp.Amount >= 200000 && opp.StageName == 'Present Solution' && opp.mh_Associated_Blue_Sheet__c == false){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, System.Label.Associated_Blue_Sheet_Validation_Rule));
            return false;
        }else if(opp.ForecastCategoryName == 'Closed' && opp.LeadSource == null){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, System.Label.Lead_Source_Validation_Rule));
            return false;
        }else if(opp.Probability >= 50 && opp.Staffing_Requirements__c == null){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, System.Label.Staffing_Requirements_Validation_Rule));
            return false;
        }else if(opp.ForecastCategoryName == 'Closed' && opp.PBD__c == null){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, System.Label.PBD_Validation_Rule));
            return false;
        }else if(opp.ForecastCategoryName == 'Closed' && opp.SOW_Start_Date__c == null){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, System.Label.SOW_Start_Date_Validation_Rule));
            return false;
        }else if((opp.Product_Name__c == 'FinCapture' || opp.Product_Name__c == 'FinConnect' || opp.Product_Name__c == 'FinDigital' || opp.Product_Name__c == 'FinSight' ||
                  opp.Product_Name__c == 'FinXperience Consumer'|| opp.Product_Name__c == 'FinXperience Retail' || opp.Product_Name__c == 'FinXperience Broker' ||
                  opp.Product_Name__c == 'FinXperience Correspondent' || opp.Product_Name__c == 'FinXperience Servicer' || opp.Product_Name__c == 'FinXperience Investor') &&
                 opp.Product_Quota__c == null){
                     ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, System.Label.Product_Quota_Validation_Rule));
                     return false;
                 }else{
                     return true;
                 }   
    }
    
    public void close() {  
        attachment = null;
        displayPopup = false;          
    }
    
    public Pagereference cancel() {  
        PageReference p = new Pagereference('/'+opp.Id);
        return p; 
    }
    
    // sends email with attachment to selected users.
    @future
    public static void sendMail(Id oppid, List<ID> attIdList){
        
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        
        List<Messaging.EmailFileAttachment> efaList = new List<Messaging.EmailFileAttachment>();
        
        List<Attachment> attList= new List<Attachment>();
        
        attList = [SELECT id, Name, Body FROM Attachment WHERE ParentId =: oppid AND id =:attIdList];
        
        for (Attachment attachItr : attList){ 
            
            Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
            efa.setFileName(attachItr.Name);
            efa.setBody(attachItr.Body);
            efaList.add(efa);
        }
        
        if(!efaList.isEmpty()){
            email.setFileAttachments(efaList);
            
        }
        
        List<User> userList = new List<User>(); // list of users to whom email is sent.
        
        //userList = [SELECT id, Name, Email from User Where Email IN ('shiwangi.jha@tavant.com', 'shahanawaz.akhtar@tavant.com')];
        //userList = [SELECT id, Name, Email from User Where Email IN ('shiwangi.jha@tavant.com', 'gizem.isik@tavant.com')];
        userList = [SELECT id, Name, Email from User Where Email IN ('sudheer.devadiga@tavant.com', 'gizem.isik@tavant.com')];
        
        EmailTemplate templateId = [Select id, DeveloperName from EmailTemplate where DeveloperName = 'Opportunity_Closed_Signed_Contract'];
        
        for(User usr: userList){
            
            email.setWhatId(oppid);
            email.setTemplateId(templateId.id);
            email.setTargetObjectId(usr.id);        
            email.setSaveAsActivity(false);
            
            Messaging.SendEmailResult [] results = Messaging.sendEmail(new Messaging.SingleEmailMessage [] {email}); 
            
        }
    }
    
}