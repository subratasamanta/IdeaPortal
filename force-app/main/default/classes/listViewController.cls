public class listViewController {
    /*apex method to fetch wrapper of list view*/ 
   
    @AuraEnabled
    public static List<WrapCaseWithCaseItems> getWrapCaseWithCaseItems( ) {
        List<WrapCaseWithCaseItems> wrpList = new List<WrapCaseWithCaseItems>();
        for(Case cse : [SELECT Id, OwnerId, Subject,Status,(SELECT id,Case__c,Licence_Name__c,Action__c FROM Case_Line_Items__r) from Case LIMIT 50000]){
                               WrapCaseWithCaseItems WrapCaseWithCaseItemsList = new WrapCaseWithCaseItems();
                               WrapCaseWithCaseItemsList.objCaseRecord = cse;  
            				   WrapCaseWithCaseItemsList.isCaseDraft = cse.Status;
                               WrapCaseWithCaseItemsList.lstCaseLineItems = cse.Case_Line_Items__r;
                               wrpList.add(WrapCaseWithCaseItemsList) ;
                           }
        system.debug('called in systemdebug'+wrpList.size());
        return wrpList;
    } 
    
    public class WrapCaseWithCaseItems{
        @AuraEnabled  public Case objCaseRecord;
        @AuraEnabled  public String isCaseDraft;
        @AuraEnabled  public List<Case_Line_Item__c> lstCaseLineItems; 
       
    }
}