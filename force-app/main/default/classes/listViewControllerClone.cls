public class listViewControllerClone {
    
    /*apex method to fetch wrapper of list view   12-APR-2019*/ 
    
    @AuraEnabled
    public static List<WrapCaseWithCaseItems> getWrapCaseWithCaseItems( ) {
        List<WrapCaseWithCaseItems> wrpList = new List<WrapCaseWithCaseItems>();
        for(Case cse : [SELECT Id, OwnerId, Subject,Status,CreatedDate,Owner.Name,
                        (SELECT id,Case__c,Licence_Name__c,Action__c FROM Case_Line_Items__r) from Case where OwnerId=:userinfo.getuserid() LIMIT 50000]){
            WrapCaseWithCaseItems WrapCaseWithCaseItemsList = new WrapCaseWithCaseItems();
            WrapCaseWithCaseItemsList.objCaseRecord = cse;  
            WrapCaseWithCaseItemsList.isCaseDraft = cse.Status;
            WrapCaseWithCaseItemsList.lstCaseLineItems = cse.Case_Line_Items__r;
            wrpList.add(WrapCaseWithCaseItemsList) ;
        }
        return wrpList;
    } 
    
    public class WrapCaseWithCaseItems{
        @AuraEnabled  public Case objCaseRecord;
        @AuraEnabled  public String isCaseDraft;
        @AuraEnabled  public List<Case_Line_Item__c> lstCaseLineItems; 
 
    }
    
    @AuraEnabled
    public static List <Case> fetchCase(String caseType) {
        List<Case> caseList = new List<Case>();
      
        //Query 10 accounts
        if (String.isBlank(caseType) || caseType == 'AllCases'){
            caseList = [SELECT Id, CaseNumber, AccountId, Subject, Owner.Name,OwnerId,
                        Status, CreatedDate from Case where OwnerId=:userinfo.getuserid()];
        }
        else {
            caseList = [SELECT Id, CaseNumber, Subject, AccountId, Owner.Name,OwnerId,
                        Status,CreatedDate from Case WHERE Status =: caseType and OwnerId=:userinfo.getuserid()];
        }
        return caseList;
    }
}