@isTest
private class listViewControllerCloneTest {
    @isTest static void createProductTeamControllerTest(){
        Test.startTest();
       	Case cs = PortalTestDataFactory.createCase();
        Case_Line_Item__c caseitem= PortalTestDataFactory.createCaseLineitem(cs.ID);
        List<Case_Line_Item__c> csitemList=new List<Case_Line_Item__c>();
        csitemList.add(caseitem);
        
        listViewControllerClone.WrapCaseWithCaseItems wrappercontroller= new listViewControllerClone.WrapCaseWithCaseItems();
        wrappercontroller.objCaseRecord= cs;
        wrappercontroller.isCaseDraft='ABC';
        wrappercontroller.lstCaseLineItems=csitemList;
        
        listViewControllerClone.getWrapCaseWithCaseItems();
        
        listViewControllerClone.fetchCase('Submitted');
        
        Test.stopTest();
    }
}