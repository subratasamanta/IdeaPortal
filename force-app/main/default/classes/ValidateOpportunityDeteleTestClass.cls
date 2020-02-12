@isTest 
private class ValidateOpportunityDeteleTestClass{

    static testMethod void TestCaseOne(){
        
        list<PBD_GDM_Emails__c> PBDGDMEmailsList=new   list<PBD_GDM_Emails__c>();

        PBD_GDM_Emails__c PBDRoshan=new PBD_GDM_Emails__c(); 
        PBDRoshan.Name='Roshan';
        PBDRoshan.Email_ID__c='roshan@t.com';
        PBDGDMEmailsList.add(PBDRoshan);

        PBD_GDM_Emails__c PBDMeera=new PBD_GDM_Emails__c(); 
        PBDMeera.Name='Meera';
        PBDMeera.Email_ID__c='meera@t.com';
        PBDGDMEmailsList.add(PBDMeera);

        insert PBDGDMEmailsList;

        
        Account newAcct = new Account();
        newAcct.Name = 'test';
        insert newAcct;
        
        Opportunity newOpp = new Opportunity();
        newOpp.Name = 'Signed Contract';
        newOpp.Probability = 45;
        newOpp.Gross_Margin__c=45;
        newOpp.StageName = 'Prospect';
        newOpp.CloseDate = System.today();
        newOpp.PBD__c='Roshan';
        insert newOpp;
        
        newOpp.GDM__c='Meera';
        Update newOpp;
        
        Billing_Details__c BD = new Billing_Details__c();
        BD.Month__c='1';
        BD.Year__c='2013';
        BD.Opportunity_Name__c=newOpp.Id;
        insert BD;
        
        newOpp.ForecastCategoryName='Closed';
        newOpp.LeadSource = 'Field Sales';
        newOpp.Staffing_Requirements__c='test';
        newOpp.Probability = 100;
        newOpp.SOW_Start_Date__c =  System.Today();
         newOpp.LeadSource = 'Field Sales';
        newOpp.SOW_End_Date__c =  System.Today();
        Update newOpp;
        
        BD.BILLING_EXPECTED__c=100;
        Update BD;
        
        delete newOpp;
     
        
        
    }
}