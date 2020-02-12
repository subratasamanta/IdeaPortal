@isTest 
private class contactTestController {
    static testMethod void createcontact() {
    
     contact__c c = new contact__c();
     c.name = 'test';
     c.last_Name__c= 'test';
     insert c;
    }
}