/*
* Description: This class is used to create new or edit opportunity records.
* If certain conditions are met while creating or editing a record, a popup window will appear where the user will have to upload file attachment
* and consequently an email with that attachment is sent to some selected users.
* Test class - OpportunityEditExtensionTest
*-------------------------------------------------------------------------------------------------------
*  Author                          Date                               Project         
*  Shiwangi Jha                    2/21/2018                          Tavant Internal Sales 
*-------------------------------------------------------------------------------------------------------
*/
public with sharing class OpportunityEditExtension{
    
    public Boolean displayPopup {get;set;} 
    public transient Map<String, Decimal> probabilityStageNameMap;
    public transient Map<String, String> forecastCategoryNameStageNameMap;
    public transient Map<String, String> productQuotaMap;    
    public List<Attachment> oldAttList{get;set;}
    public  Attachment attachment {
        get{
            if (attachment == null)
                attachment = new Attachment();
            return attachment;
        }
        set;
    }
    
    public  Attachment newAttachment {
        get{
            if (newAttachment == null)
                newAttachment = new Attachment();
            return newAttachment;
        }
        set;
    }
    
    Opportunity opp;
    
    public OpportunityEditExtension(ApexPages.StandardController controller){
        displayPopup = false;
        opp = (Opportunity)controller.getRecord(); 
    }
    
    // This method auto populates Forecast Category and Probability fields whenever Stage is selected.  
    public void changeStageName() {
        if (probabilityStageNameMap == null) {
            probabilityStageNameMap = new Map<String, Decimal>();
            for (OpportunityStage oppStage : [Select MasterLabel, DefaultProbability From OpportunityStage]) {
                probabilityStageNameMap.put(oppStage.MasterLabel, oppStage.DefaultProbability);}
        } 
        if (probabilityStageNameMap != null && probabilityStageNameMap.containsKey(opp.StageName)) {
            opp.Probability = probabilityStageNameMap.get(opp.StageName);
        }        
        if (forecastCategoryNameStageNameMap == null) {
            forecastCategoryNameStageNameMap = new Map<String, String>();
            for (OpportunityStage oppStage : [Select MasterLabel, ForecastCategoryName From OpportunityStage]) {
                forecastCategoryNameStageNameMap.put(oppStage.MasterLabel, oppStage.ForecastCategoryName);}
        } 
        if (forecastCategoryNameStageNameMap != null && forecastCategoryNameStageNameMap.containsKey(opp.StageName)) {
            opp.ForecastCategoryName = forecastCategoryNameStageNameMap.get(opp.StageName);
        }        
    }
    
    // This method auto populates Product Quota when Product Name is selected or changed.
    public void changeProductQuota(){
        
        
        if (productQuotaMap == null) {
            Product_Quota__c prod0 = [Select Id, Name From Product_Quota__c Where Name =: 'Not a Product'];
            Product_Quota__c prod1 = [Select Id, Name From Product_Quota__c Where Name =: 'Others'];
            Product_Quota__c prod2 = [Select Id, Name From Product_Quota__c Where Name =: 'FinCapture'];
            Product_Quota__c prod3 = [Select Id, Name From Product_Quota__c Where Name =: 'FinConnect'];
            Product_Quota__c prod4 = [Select Id, Name From Product_Quota__c Where Name =: 'FinSight'];
            Product_Quota__c prod5 = [Select Id, Name From Product_Quota__c Where Name =: 'FinXperience: Consumer'];
            Product_Quota__c prod6 = [Select Id, Name From Product_Quota__c Where Name =: 'FinXperience: Retail'];            
            Product_Quota__c prod7 = [Select Id, Name From Product_Quota__c Where Name =: 'FinXperience: Broker'];  
            Product_Quota__c prod8 = [Select Id, Name From Product_Quota__c Where Name =: 'FinXperience: Correspondent'];
            Product_Quota__c prod9 = [Select Id, Name From Product_Quota__c Where Name =: 'FinXperience: Servicing'];

            productQuotaMap = new Map<String, String>();
                productQuotaMap.put('Not a Product', String.valueOf(prod0.Id));
                productQuotaMap.put('FinCapture', String.valueOf(prod2.Id));
                productQuotaMap.put('FinConnect', String.valueOf(prod3.Id));
                productQuotaMap.put('FinDigital', String.valueOf(prod1.Id));
                productQuotaMap.put('FinSight', String.valueOf(prod4.Id));
                productQuotaMap.put('FinXperience Consumer', String.valueOf(prod5.Id));
                productQuotaMap.put('FinXperience Retail', String.valueOf(prod6.Id));
                productQuotaMap.put('FinXperience Broker', String.valueOf(prod7.Id));
                productQuotaMap.put('FinXperience Correspondent', String.valueOf(prod8.Id));
                productQuotaMap.put('FinXperience Servicer', String.valueOf(prod9.Id));
                productQuotaMap.put('FinXperience Investor', String.valueOf(prod1.Id));
                productQuotaMap.put('TWOD', String.valueOf(prod1.Id));
                productQuotaMap.put('TMAP', String.valueOf(prod1.Id));
                productQuotaMap.put('TW', String.valueOf(prod1.Id));
        }
        system.debug('productQuotaMap-->'+productQuotaMap);
        if (productQuotaMap != null && productQuotaMap.containsKey(opp.Product_Name__c)) {
            opp.Product_Quota__c = productQuotaMap.get(opp.Product_Name__c);
            system.debug('opp.Product_Quota__c-->'+opp.Product_Quota__c);
        }
        }
    
    // This method auto populates Vertical Practice & Quotas.
    public void changeVerticalPractice(){
        
        Id accId = opp.AccountId;
        if(opp.AccountId != null ){
            Account acc = [select id, name, Vertical_Practice__c From Account Where id =: accId];
            
            
            Vertical_Practice_Quotas__c vp = [Select id, Name From Vertical_Practice_Quotas__c where Name =: acc.Vertical_Practice__c ];
            opp.Vertical_Practice2__c = vp.Id;
            
            system.debug('vp-->'+vp);
        }else {
            opp.Vertical_Practice2__c = null;
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
            
            /* when Stage is 'Signed Contract' and Probability is 100% 
* then a file upload popup window appears
* otherwise the Opportunity is saved without the popup window 	
*/
            oldAttList = [SELECT ParentId,Name,Id,ContentType,BodyLength FROM Attachment WHERE ParentId=:opp.id];
            system.debug('=========oldAttList======='+oldAttList+'======oldAttList Size======'+oldAttList.size());
            if(opp.StageName == 'Signed Contract' && opp.Probability == 100 && (oldAttList.size() < 2) ){            
                displayPopup = true;
                return null;
            }
            else{            
                displayPopup = false;
                try{                
                    upsert opp;                
                } catch(Exception e){
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage())); 
                    return null;
                }
                PageReference p= new Pagereference('/'+opp.id);
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
                upsert opp;                
            } catch(Exception e){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage())); 
                return null;
            }
            
            List<Attachment> attachlist = new List<Attachment>();
            attachment.OwnerId = UserInfo.getUserId();
            attachment.ParentId = opp.Id; // the id of opportunity record to which the file is attached.
            attachment.IsPrivate = false; 
            attachlist.add(attachment);
            
            newAttachment.OwnerId = UserInfo.getUserId();
            newAttachment.ParentId = opp.Id; // the id of opportunity record to which the file is attached.
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
            sendMail(opp.id, attIdList); // sends email with attachment to selected users.
        }
        else{            
            try{                
                upsert opp;                
            } catch(Exception e){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage())); 
                return null;
            }
            
            List<Attachment> attachlist = new List<Attachment>();
            
            if(attachment != null && attachment.name != '' && attachment.name != null){
                
                attachment.OwnerId = UserInfo.getUserId();
                attachment.ParentId = opp.Id; // the id of opportunity record to which the file is attached.
                attachment.IsPrivate = false; 
                attachlist.add(attachment);
                
            }
            
            if(newAttachment != null && newAttachment.name != '' && newAttachment.name != null){
                
                newAttachment.OwnerId = UserInfo.getUserId();
                newAttachment.ParentId = opp.Id; // the id of opportunity record to which the file is attached.
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
            
            sendMail(opp.id, attIdList);
            
            
        }      
        
        PageReference p= new Pagereference('/'+opp.Id);
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