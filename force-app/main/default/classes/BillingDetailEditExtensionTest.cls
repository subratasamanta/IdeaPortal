@isTest 
public class BillingDetailEditExtensionTest 
{
    static testMethod void testBillingDetails() 
    {
        Vertical_Practice_Quotas__c vp = new Vertical_Practice_Quotas__c();
        vp.Name = 'Test Vertical';
        insert vp;
        
        Opportunity opp = new Opportunity();
        Billing_Details__c b = new Billing_Details__c();
        
        opp.StageName = 'Signed Contract';
        opp.CloseDate = System.today()+5;
        opp.ForecastCategoryName = 'Closed';
        opp.Name = 'Test Opportunity Triggers';
        opp.Product_Name__c = 'Not a Product';
        opp.SOW_Start_Date__c = System.today()-1;
        opp.SOW_End_Date__c = System.today()+6;
        opp.Gross_Margin__c = 60;
        opp.Probability = 90;
        opp.PBD__c = 'Other';
        opp.GDM__c = 'Other';
        opp.LeadSource = 'Alliances';
        opp.Staffing_Requirements__c = 'ok';
        opp.GDM_Comments__c = 'ok';
        opp.Horizontal_Practice__c = 'Digital';
        opp.Vertical_Practice2__c = vp.id;
        insert opp;
        
        b.Opportunity_Name__c = opp.Id; 
        b.Month__c = '2';
        b.Year__c= '2017';
        b.BILLING_FORECAST__c = 1000;
        b.BILLING_EXPECTED__c = 1000;
        b.BILLING_LIKELY__c= 1000;
        b.Billing_Expected_Comments__c = 'Ok';
        b.BILLING_ACTUAL__c = 20000;
        b.Comments__c= 'Test';
        b.Actual_Invoice_Date__c= System.today();
        b.Actual_Invoice_Number__c = '5';
        b.Locked__c = false;
        
        insert b;
        
        Test.StartTest(); 
        PageReference pageRef = Page.BillingDetailEditPage; // Add your VF page Name here
        pageRef.getParameters().put('id', String.valueOf(opp.Id));
        Test.setCurrentPage(pageRef);
        ApexPages.StandardSetController setCon = new ApexPages.StandardSetController(Database.getQueryLocator([Select Id,Name,Opportunity_Name__r.Name, Opportunity_Name__r.Probability, Opportunity_Name__c, Month__c, Year__c,BILLING_FORECAST__c, BILLING_LIKELY__c, BILLING_EXPECTED__c, Billing_Expected_Comments__c, BILLING_ACTUAL__c,Comments__c, Actual_Invoice_Date__c, Actual_Invoice_Number__c, Locked__c From Billing_Details__c where Opportunity_Name__c=:opp.Id]));
        BillingDetailEditExtension billing = new BillingDetailEditExtension(setCon);
        billing.save();
        billing.cancel();
        billing.getBillingDetailsList();
        billing.deleteSelected();
       
        Test.StopTest();
        
        
    }
}