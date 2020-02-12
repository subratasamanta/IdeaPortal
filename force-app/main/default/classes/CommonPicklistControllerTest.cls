@isTest
private class CommonPicklistControllerTest {
    @isTest static void commonPicklist(){
        Idea__c idea= new Idea__c();
	CommonPicklistController.getPicklistvalues('Idea__c','Status__c',true);
    }
}