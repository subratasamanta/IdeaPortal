@isTest(SeeAllData=false)
public class DailySalesForecastBatchTest{

    public static testMethod void testCase() {

        Account a =new Account(Name='test', Type='Analyst', Account_Source__c ='Alliances', Vertical_Practice__c = 'Consumer Lending');
        insert a; 
        Test.startTest();
            SchedulableContext sc = null;
            DailySalesForecastSchedulabler dsfs = new DailySalesForecastSchedulabler ();
            dsfs.execute(sc);
        Test.stopTest();
               
        
    }

}