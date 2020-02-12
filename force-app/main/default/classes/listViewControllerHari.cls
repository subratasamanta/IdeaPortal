public class listViewControllerHari {
	/*apex method to fetch wrapper of list view*/ 
    
    @AuraEnabled
    public static List<Case> getWrapCaseWithCaseItems( ) {
        List<Case> wrpList = new List<Case>();
        /*for(Case cse : [SELECT Id, OwnerId, Subject,Status from Case LIMIT 50000]){
            WrapCaseWithCaseItems WrapCaseWithCaseItemsList = new WrapCaseWithCaseItems();
            WrapCaseWithCaseItemsList.objCaseRecord = cse;  
            WrapCaseWithCaseItemsList.isCaseStatus = cse.Status;
            //WrapCaseWithCaseItemsList.lstCaseLineItems = cse.Case_Line_Items__r;
            wrpList.add(WrapCaseWithCaseItemsList) ;
        }
        system.debug('called in systemdebug'+wrpList.size());*/
        wrpList = [SELECT Id, OwnerId, Subject,Status from Case LIMIT 50000];
        return wrpList;
    } 
    
    public class WrapCaseWithCaseItems{
        @AuraEnabled  public Case objCaseRecord;
        @AuraEnabled  public String isCaseStatus;
        //@AuraEnabled  public List<Case_Line_Item__c> lstCaseLineItems; 
        
    }
    
    @AuraEnabled
    public static List <Case> fetchCase(String caseType) {
        List<Case> caseList = new List<Case>();
        system.debug('called in for check the type'+caseType);
        //Qyery 10 accounts
        if (String.isBlank(caseType) || caseType == 'AllCases'){
            caseList = [SELECT Id, OwnerId, Subject, 
                        Status from Case ];
        }
        else {
            system.debug('called in else loop ');
            caseList = [SELECT Id, OwnerId, Subject, 
                        Status from Case WHERE Status =: caseType];
        }
        system.debug('called inside'+caseList);
        //return list of accounts
        return caseList;
    }
}