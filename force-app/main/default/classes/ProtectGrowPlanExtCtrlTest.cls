/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class ProtectGrowPlanExtCtrlTest{

  
    
    static testMethod void myUnitTest1() {
        
        Account acc= new Account();
        acc.Name='AccName';
        insert acc;
        List<Opportunity> Oppertunties= new List<Opportunity>();
        Opportunity opp= new Opportunity();
        opp.Name='Opp1';
        opp.AccountId=acc.Id;
       
        opp.CloseDate=Date.newInstance(2015,01,01);
        opp.StageName='Qualification';
        opp.ForecastCategoryName='Best Case';
        insert opp;
        
        
        
        Opportunity opp1= new Opportunity();
        opp1.Name='Opp2';
        opp1.AccountId=acc.Id;
        opp1.CloseDate=Date.newInstance(2015,01,01);
        opp1.StageName='In Contracts';
        opp1.ForecastCategoryName='Closed';
        opp1.LeadSource = 'Field Sales';
        opp1.Horizontal_Practice__c = 'IST';
        opp1.SOW_Start_Date__c=Date.newInstance(2014,01,01);
         opp1.SOW_End_Date__c=Date.newInstance(2015,01,01);
        opp1.GDM__c='Sridhar G';
        Oppertunties.add(opp1);
        opp1.LeadSource = 'Field Sales';
        opp1.Gross_Margin__c=70;
        opp1.Staffing_Requirements__c='Staffing Required';
        opp1.PBD__c='Bhupinder K';
        insert opp1;
       
        Opportunity_Stage_Names__c  opportunityStage1=new Opportunity_Stage_Names__c();
        opportunityStage1.Name='Qualification';
        insert opportunityStage1;
        Opportunity_Stage_Names__c  opportunityStage2=new Opportunity_Stage_Names__c();
        opportunityStage2.Name='In Contracts';
        insert opportunityStage2;
        
        
        List<Billing_Details__c> billDetails= new List<Billing_Details__c>();
        Billing_Details__c billDetail= new Billing_Details__c();
        billDetail.Opportunity_Name__c=opp.Id;
        billDetail.Year__c='2015';
        billDetail.Month__c='1';
        billDetail.BILLING_FORECAST__c=232;
        billDetail.BILLING_ACTUAL__c=434;
        billDetails.add(billDetail);
        
        Billing_Details__c billDetailPreYear= new Billing_Details__c();
        billDetailPreYear.Opportunity_Name__c=opp.Id;
        billDetailPreYear.Year__c='2014';
        billDetailPreYear.Month__c='1';
        billDetailPreYear.BILLING_FORECAST__c=232;
        billDetailPreYear.BILLING_ACTUAL__c=434;
        billDetails.add(billDetailPreYear);
        
        Billing_Details__c billDetail1= new Billing_Details__c();
        billDetail1.Opportunity_Name__c=opp.Id;
        billDetail1.Year__c='2015';
        billDetail1.Month__c='4';
        billDetail1.BILLING_FORECAST__c=231;
        billDetail1.BILLING_ACTUAL__c=433;
        billDetails.add(billDetail1);
        
        Billing_Details__c billDetail2= new Billing_Details__c();
        billDetail2.Opportunity_Name__c=opp.Id;
        billDetail2.Year__c='2015';
        billDetail2.Month__c='7';
        billDetail2.BILLING_FORECAST__c=230;
        billDetail2.BILLING_ACTUAL__c=430;
        billDetails.add(billDetail2); 
        
        Billing_Details__c billDetail3= new Billing_Details__c();
        billDetail3.Opportunity_Name__c=opp.Id;
        billDetail3.Year__c='2015';
        billDetail3.Month__c='10';
        billDetail3.BILLING_FORECAST__c=229;
        billDetail3.BILLING_ACTUAL__c=423;  
        billDetails.add(billDetail3);
        
        Billing_Details__c billDetail4= new Billing_Details__c();
        billDetail4.Opportunity_Name__c=opp1.Id;
        billDetail4.Year__c='2015';
        billDetail4.Month__c='1';
        billDetail4.BILLING_FORECAST__c=232;
        billDetail4.BILLING_EXPECTED__c=434;
        billDetails.add(billDetail4);
        
        Billing_Details__c billDetail5= new Billing_Details__c();
        billDetail5.Opportunity_Name__c=opp1.Id;
        billDetail5.Year__c='2015';
        billDetail5.Month__c='4';
        billDetail5.BILLING_FORECAST__c=231;
        billDetail5.BILLING_EXPECTED__c=433;
        billDetails.add(billDetail5);
        
        Billing_Details__c billDetail6= new Billing_Details__c();
        billDetail6.Opportunity_Name__c=opp1.Id;
        billDetail6.Year__c='2015';
        billDetail6.Month__c='7';
        billDetail6.BILLING_FORECAST__c=230;
        billDetail6.BILLING_EXPECTED__c=432;
        billDetails.add(billDetail6);
        
        Billing_Details__c billDetailPreYear1= new Billing_Details__c();
        billDetailPreYear1.Opportunity_Name__c=opp1.Id;
        billDetailPreYear1.Year__c='2014';
        billDetailPreYear1.Month__c='7';
        billDetailPreYear1.BILLING_FORECAST__c=232;
        billDetailPreYear1.BILLING_EXPECTED__c=434;
        billDetails.add(billDetailPreYear1);
        
        Billing_Details__c billDetail7= new Billing_Details__c();
        billDetail7.Opportunity_Name__c=opp1.Id;
        billDetail7.Year__c='2015';
        billDetail7.Month__c='10';
        billDetail7.BILLING_FORECAST__c=229;
        billDetail7.BILLING_EXPECTED__c=438;
        billDetails.add(billDetail7);
        
        insert billDetails;
        
        Protect_Grow_Plan__c pgp = new Protect_Grow_Plan__c();
        pgp.Name = 'test';
        pgp.Financial_Year__c=2015;
        pgp.Customer__c=acc.id;
        insert pgp;
        
        ApexPages.CurrentPage().getparameters().put('id', pgp.Id);
        ApexPages.StandardController sc = new ApexPages.standardController(pgp);
        ProtectGrowPlanExtCtrl rppg = new ProtectGrowPlanExtCtrl(sc);
        rppg.savePGPDDetails();
        System.assertEquals(2,rppg.PGPDetailsWrpr.size());
        ProtectGrowPlanExtCtrl.PGPDetailsWrapper PGPW=rppg.PGPDetailsWrpr.get(0);
        if(PGPW.OppBillWrpr.PrevFYTotal!=null && PGPW.OppBillWrpr.PrevFYTotal!=0){
            System.assertEquals(434, PGPW.OppBillWrpr.Q1);
            System.assertEquals(433, PGPW.OppBillWrpr.Q2);
            System.assertEquals(430, PGPW.OppBillWrpr.Q3);
            System.assertEquals(423, PGPW.OppBillWrpr.Q4);
            System.assertEquals(434, PGPW.OppBillWrpr.PrevFYTotal);
        }
        PGPW=rppg.PGPDetailsWrpr.get(1);
        if(PGPW.OppBillWrpr.PrevFYTotal!=null && PGPW.OppBillWrpr.PrevFYTotal!=0){
        System.assertEquals(434, PGPW.OppBillWrpr.PrevFYTotal);
            System.assertEquals(434, PGPW.OppBillWrpr.Q1);
            System.assertEquals(433, PGPW.OppBillWrpr.Q2);
            System.assertEquals(430, PGPW.OppBillWrpr.Q3);
            System.assertEquals(423, PGPW.OppBillWrpr.Q4);
            System.assertEquals(434, PGPW.OppBillWrpr.PrevFYTotal);
            
            }
        
        
    }
    static testMethod void myUnitTest2() {
       
        
        
        
        Account acc= new Account();
        acc.Name='AccName';
        insert acc;
        
        Protect_Grow_Plan__c pgp = new Protect_Grow_Plan__c();
        pgp.Name = 'test';
        pgp.Financial_Year__c=2015;
        pgp.Customer__c=acc.id;
        insert pgp;
        
        
        List<Opportunity> Oppertunties= new List<Opportunity>();
        Opportunity opp= new Opportunity();
        opp.Name='Opp1';
        opp.AccountId=acc.Id;
       
        opp.CloseDate=Date.newInstance(2015,01,01);
        opp.StageName='Qualification';
        opp.ForecastCategoryName='Best Case';
        insert opp;
       
        Opportunity_Stage_Names__c  opportunityStage1=new Opportunity_Stage_Names__c();
        opportunityStage1.Name='Qualification';
        insert opportunityStage1;
        Opportunity_Stage_Names__c  opportunityStage2=new Opportunity_Stage_Names__c();
        opportunityStage2.Name='In Contracts';
        insert opportunityStage2;
        
        Opportunity opp1= new Opportunity();
        opp1.Name='Opp2';
        opp1.AccountId=acc.Id;
        opp1.CloseDate=Date.newInstance(2015,01,01);
        opp1.StageName='In Contracts';
        opp1.ForecastCategoryName='Closed';
        opp1.LeadSource = 'Field Sales';
        opp1.Horizontal_Practice__c = 'IST';
                opp1.LeadSource = 'Field Sales';
        opp1.SOW_Start_Date__c=Date.newInstance(2014,01,01);
         opp1.SOW_End_Date__c=Date.newInstance(2015,01,01);
        opp1.GDM__c='Sridhar G';
        Oppertunties.add(opp1);
        opp1.Gross_Margin__c=70;
        opp1.Staffing_Requirements__c='Staffing Required';
        opp1.PBD__c='Bhupinder K';
        insert opp1;
        
        List<Billing_Details__c> billDetails= new List<Billing_Details__c>();
        Billing_Details__c billDetail= new Billing_Details__c();
        billDetail.Opportunity_Name__c=opp.Id;
        billDetail.Year__c='2015';
        billDetail.Month__c='1';
        billDetail.BILLING_FORECAST__c=232;
        billDetail.BILLING_ACTUAL__c=434;
        billDetails.add(billDetail);
        
        Billing_Details__c billDetailPreYear= new Billing_Details__c();
        billDetailPreYear.Opportunity_Name__c=opp.Id;
        billDetailPreYear.Year__c='2014';
        billDetailPreYear.Month__c='1';
        billDetailPreYear.BILLING_FORECAST__c=232;
        billDetailPreYear.BILLING_ACTUAL__c=434;
        billDetails.add(billDetailPreYear);
        
        Billing_Details__c billDetail1= new Billing_Details__c();
        billDetail1.Opportunity_Name__c=opp.Id;
        billDetail1.Year__c='2015';
        billDetail1.Month__c='4';
        billDetail1.BILLING_FORECAST__c=231;
        billDetail1.BILLING_ACTUAL__c=433;
        billDetails.add(billDetail1);
        
        Billing_Details__c billDetail2= new Billing_Details__c();
        billDetail2.Opportunity_Name__c=opp.Id;
        billDetail2.Year__c='2015';
        billDetail2.Month__c='7';
        billDetail2.BILLING_FORECAST__c=230;
        billDetail2.BILLING_ACTUAL__c=430;
         billDetails.add(billDetail2); 
        
        Billing_Details__c billDetail3= new Billing_Details__c();
        billDetail3.Opportunity_Name__c=opp.Id;
        billDetail3.Year__c='2015';
        billDetail3.Month__c='10';
        billDetail3.BILLING_FORECAST__c=229;
        billDetail3.BILLING_ACTUAL__c=423;  
        billDetails.add(billDetail3);
        
        Billing_Details__c billDetail4= new Billing_Details__c();
        billDetail4.Opportunity_Name__c=opp1.Id;
        billDetail4.Year__c='2015';
        billDetail4.Month__c='1';
        billDetail4.BILLING_FORECAST__c=232;
        billDetail4.BILLING_EXPECTED__c=434;
        billDetails.add(billDetail4);
        
        Billing_Details__c billDetail5= new Billing_Details__c();
        billDetail5.Opportunity_Name__c=opp1.Id;
        billDetail5.Year__c='2015';
        billDetail5.Month__c='4';
        billDetail5.BILLING_FORECAST__c=231;
        billDetail5.BILLING_EXPECTED__c=433;
        billDetails.add(billDetail5);
        
        Billing_Details__c billDetail6= new Billing_Details__c();
        billDetail6.Opportunity_Name__c=opp1.Id;
        billDetail6.Year__c='2015';
        billDetail6.Month__c='7';
        billDetail6.BILLING_FORECAST__c=230;
        billDetail6.BILLING_EXPECTED__c=432;
        billDetails.add(billDetail6);
        
        Billing_Details__c billDetailPreYear1= new Billing_Details__c();
        billDetailPreYear1.Opportunity_Name__c=opp1.Id;
        billDetailPreYear1.Year__c='2014';
        billDetailPreYear1.Month__c='7';
        billDetailPreYear1.BILLING_FORECAST__c=232;
        billDetailPreYear1.BILLING_EXPECTED__c=434;
        billDetails.add(billDetailPreYear1);
        
        Billing_Details__c billDetail7= new Billing_Details__c();
        billDetail7.Opportunity_Name__c=opp1.Id;
        billDetail7.Year__c='2015';
        billDetail7.Month__c='10';
        billDetail7.BILLING_FORECAST__c=229;
        billDetail7.BILLING_EXPECTED__c=438;
        billDetails.add(billDetail7);
        
        insert billDetails;
        
        
        
        ApexPages.CurrentPage().getparameters().put('id', pgp.Id);
        ApexPages.StandardController sc = new ApexPages.standardController(pgp);
        ProtectGrowPlanExtCtrl rppg = new ProtectGrowPlanExtCtrl(sc);
        rppg.savePGPDDetails();
        System.assertEquals(2,rppg.PGPDetailsWrpr.size());
        ProtectGrowPlanExtCtrl.PGPDetailsWrapper PGPW=rppg.PGPDetailsWrpr.get(0);
        if(PGPW.OppBillWrpr.PrevFYTotal!=null && PGPW.OppBillWrpr.PrevFYTotal!=0){
            System.assertEquals(434, PGPW.OppBillWrpr.Q1);
            System.assertEquals(433, PGPW.OppBillWrpr.Q2);
            System.assertEquals(430, PGPW.OppBillWrpr.Q3);
            System.assertEquals(423, PGPW.OppBillWrpr.Q4);
            System.assertEquals(434, PGPW.OppBillWrpr.PrevFYTotal);
            }
        PGPW=rppg.PGPDetailsWrpr.get(1);
        if(PGPW.OppBillWrpr.PrevFYTotal!=null && PGPW.OppBillWrpr.PrevFYTotal!=0){
        System.assertEquals(434, PGPW.OppBillWrpr.PrevFYTotal);
            System.assertEquals(434, PGPW.OppBillWrpr.Q1);
            System.assertEquals(433, PGPW.OppBillWrpr.Q2);
            System.assertEquals(430, PGPW.OppBillWrpr.Q3);
            System.assertEquals(423, PGPW.OppBillWrpr.Q4);
            System.assertEquals(434, PGPW.OppBillWrpr.PrevFYTotal);
            
            }
        
    }
}