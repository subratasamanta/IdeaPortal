@isTest
public class BillingDetailCloneExtensionTest {
    
    static testMethod void insertNewOpportunity() {
        
        Vertical_Practice_Quotas__c vp = new Vertical_Practice_Quotas__c();
        vp.Name = 'Test Vertical';
        insert vp;
        
        Opportunity opp = new Opportunity();
        
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
        
        
        List<Billing_Details__c> bdList = new List<Billing_Details__c>();
        Billing_Details__c bd= new Billing_Details__c(); 
        bd.Opportunity_Name__c = opp.id; 
        bd.Month__c = '2';
        bd.Year__c= '2017';
        bd.BILLING_FORECAST__c = 1000;
        bd.BILLING_EXPECTED__c = 1000;
        bd.BILLING_LIKELY__c= 1000;
        bd.Billing_Expected_Comments__c = 'Ok';
        bd.BILLING_ACTUAL__c = 20000;
        bd.Comments__c= 'Test';
        bd.Actual_Invoice_Date__c= System.today();
        bd.Actual_Invoice_Number__c = '5';
        bd.Locked__c = false;
        bdList.add(bd);
        insert bdList;
        system.debug('---bdList'+bdList);
        Test.StartTest(); 
        if(!bdList.isEmpty()){
             
            
            PageReference pageRef = Page.BillingDetailClonePage; // Add your VF page Name here
            pageRef.getParameters().put('id', String.valueOf(bdList[0].Id));
            Test.setCurrentPage(pageRef);
            
            ApexPages.StandardController sc = new ApexPages.StandardController(bdList[0]);
            BillingDetailCloneExtension testClone = new BillingDetailCloneExtension(sc);
            
            testClone.save(); 
            testClone.cancel();
        }
        Test.StopTest();
        
        
        
    }
    
    
}