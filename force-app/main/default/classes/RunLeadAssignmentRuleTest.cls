@isTest
public class RunLeadAssignmentRuleTest {
    
    static testMethod void insertNewLead(){
        
        UserRole r = [SELECT Id,DeveloperName,Name FROM UserRole WHERE DeveloperName = 'Support'];
        Profile p = [SELECT Id, name FROM Profile WHERE Name='Sales User (Standard)'];
        
        User u = new User(Alias = 'standt', Email='supportuser111@testorg.com', 
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', UserRoleId = r.Id, ProfileId = p.Id,
                          TimeZoneSidKey='America/Los_Angeles', UserName='supportuser111abc@testorg.com');
        insert u;   
        
        System.runAs(u){
            Lead ld = new Lead();
            ld.FirstName = 'Tom';
            ld.LastName = 'Lee';
            ld.Company = 'TestGoogle';
            ld.Email = 'tom@yahoo.com';
            ld.Status = 'Incorrect Data';
            ld.Teri__c = 'India';
            ld.HVP__c = 'No';
            ld.Practice__c = 'Aftermarket';
            insert ld;
            
            ld.HVP__c = 'Yes';
            update ld;
        }   
    }
}