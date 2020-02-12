@isTest
private class CaseControllerTest {
    @isTest static void caseController(){
        Case cs = PortalTestDataFactory.submittedcreateCase();
        cs.Status ='Submitted';
        
        Account acc=PortalTestDataFactory.generateAccount();
        Contact con=PortalTestDataFactory.createContact(acc.id);
        Case_Line_Item__c caseitem= PortalTestDataFactory.createCSLineitem(cs.ID);
        List<Case_Line_Item__c> csitemList=new List<Case_Line_Item__c>();
        csitemList.add(caseitem);
        List<Contact> conlst= new List<Contact>();        
        
        Test.startTest();        
        CaseController.caseWrapper cswrap = new CaseController.caseWrapper();  
        cswrap.caseobj=cs;
        cswrap.caseLineItem=csitemList;
        CaseController.saveContacts(conlst);
        CaseController.createCase(JSON.serialize(cswrap));
        CaseController.updateCase(JSON.serialize(cswrap));
        CaseController.getCaseData(cs.Id);
        
        Test.stopTest();
    }
}