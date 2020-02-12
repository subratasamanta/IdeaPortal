public with sharing  class CaseController {
    @AuraEnabled
    public static void saveContacts(List<Contact> ListContact){
        Insert ListContact;
    }
    
    @AuraEnabled
    public static caseWrapper createCase(String properties){
        Id caseRecTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Customer Portal Case').getRecordTypeId();
        caseWrapper c = (caseWrapper)JSON.deserialize(properties,caseWrapper.class);
        case  c1 =c.caseobj;
        c1.RecordTypeId = caseRecTypeId;
        if(c1.Status.equals('Submitted') ){
            //Fetching the assignment rules on case
            AssignmentRule AR = new AssignmentRule();
            AR = [select id from AssignmentRule where SobjectType = 'Case' AND Name ='Customer Portal Case Assignment' and Active = true limit 1];
            
            //Creating the DMLOptions for "Assign using active assignment rules" checkbox
            Database.DMLOptions dmlOpts = new Database.DMLOptions();
            dmlOpts.assignmentRuleHeader.assignmentRuleId= AR.id;
            
            //Setting the DMLOption on Case instance
            c1.setOptions(dmlOpts);
        }
        insert c1;
        for(Case_Line_Item__c lineItem : c.caseLineItem){
            lineItem.Case__c= c1.Id;
        }
        insert c.caseLineItem;
        return c;
    }
    
    @AuraEnabled
    public static caseWrapper updateCase(String properties){
        caseWrapper c = (caseWrapper)JSON.deserialize(properties,caseWrapper.class);
        case  c1 = c.caseobj;
        if(c1.Status.equals('Submitted') ){
            //Fetching the assignment rules on case
            AssignmentRule AR = new AssignmentRule();
            AR = [select id from AssignmentRule where SobjectType = 'Case' AND Name ='Customer Portal Case Assignment' and Active = true limit 1];
            
            //Creating the DMLOptions for "Assign using active assignment rules" checkbox
            Database.DMLOptions dmlOpts = new Database.DMLOptions();
            dmlOpts.assignmentRuleHeader.assignmentRuleId= AR.id;
            
            //Setting the DMLOption on Case instance
            c1.setOptions(dmlOpts);
        }
        upsert c1;
        
        for(Case_Line_Item__c lineItem : c.caseLineItem){
            lineItem.Case__c= c1.Id;
        }
        upsert c.caseLineItem;
        return c;
    }
    
    @AuraEnabled
    public static caseWrapper getCaseData(String caseId){
        caseWrapper csWrap = new caseWrapper();
        for(Case cse : [SELECT ID,Status,Priority,Subject,Salesforce_Org_Id__c,Comments__c,Description,
                        (SELECT ID,Action__c,Comments__c,Effective_Date__c,Licence_Name__c,Quantity__c FROM Case_Line_Items__r) 
                        FROM Case Where ID = : CaseId]){
            csWrap.caseobj = cse;
            csWrap.caseLineItem = cse.Case_Line_Items__r;
        }
        system.debug('csWrap::'+csWrap);
        return csWrap;
    }
    
    public class caseWrapper{
        @AuraEnabled public case caseobj{get;set;}
        @AuraEnabled public List<Case_Line_Item__c> caseLineItem{get;set;}
    }
}