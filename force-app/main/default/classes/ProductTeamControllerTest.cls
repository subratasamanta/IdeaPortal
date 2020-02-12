@isTest
private class ProductTeamControllerTest {
	@isTest static void createProductTeamControllerTest(){
        Contact_Us__c con = PortalTestDataFactory.createContactUS();
		Test.startTest();
        	ProductTeamController.fetchContactDetailList();
        	ProductTeamController.createRecord(con);
        	ProductTeamController.sendMailMethod('TestProduct@tavant.com','TestProduct','TestProduct','TestProduct','TestProduct','TestProduct');
        Test.stopTest();
    }
}