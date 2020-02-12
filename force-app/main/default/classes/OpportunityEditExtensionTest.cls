@isTest
public class OpportunityEditExtensionTest {
    
    static testMethod void insertNewOpportunity(){
        
        Profile p = [SELECT Id, name FROM Profile WHERE Name='Standard User'];
        
        User u = new User(Alias = 'standt', Email='standarduser321abc@testorg.com', 
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, 
                          TimeZoneSidKey='America/Los_Angeles', UserName='standarduser321abc@testorg.com');
        insert u;
        
        Account acc = new Account(Name='TestAc', Vertical_Practice__c = 'Aftermarket');        
        insert acc;
        Vertical_Practice_Quotas__c vp = new Vertical_Practice_Quotas__c();
        vp.Name = acc.Vertical_Practice__c;
        insert vp;    

        
        List<Product_Quota__c> prList = new List<Product_Quota__c>();
        Product_Quota__c pr0 = new Product_Quota__c(Name = 'Not a Product');
        Product_Quota__c pr1 = new Product_Quota__c(Name = 'Others');
        Product_Quota__c pr2 = new Product_Quota__c(Name = 'FinCapture');
        Product_Quota__c pr3 = new Product_Quota__c(Name = 'FinConnect');
        Product_Quota__c pr4 = new Product_Quota__c(Name = 'FinSight');
        Product_Quota__c pr5 = new Product_Quota__c(Name = 'FinXperience: Consumer');
        Product_Quota__c pr6 = new Product_Quota__c(Name = 'FinXperience: Retail');
        Product_Quota__c pr7 = new Product_Quota__c(Name = 'FinXperience: Broker');
        Product_Quota__c pr8 = new Product_Quota__c(Name = 'FinXperience: Correspondent');
        Product_Quota__c pr9 = new Product_Quota__c(Name = 'FinXperience: Servicing');
        
        prList.add(pr0);
        prList.add(pr1);
        prList.add(pr2);
        prList.add(pr3);
        prList.add(pr4);
        prList.add(pr5);
        prList.add(pr6);
        prList.add(pr7);
        prList.add(pr8);
        prList.add(pr9);
        insert prList;
        
        Opportunity opp = new Opportunity();
        
        opp.StageName = 'Signed Contract';
        opp.CloseDate = System.today()+5;
        opp.ForecastCategoryName = 'Closed';
        opp.Name = 'Test Opportunity Triggers';
        opp.Product_Name__c = 'Not a Product';
        opp.Product_Quota__c = prList[0].id;
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
        
        Test.StartTest();
        PageReference pageRef = Page.OpportunityEditPage;
        pageRef.getParameters().put('id', String.valueOf(opp.Id));
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(opp);
        OpportunityEditExtension testOpp = new OpportunityEditExtension(sc);
        
        
        Attachment attach=new Attachment();   	
        attach.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        attach.parentId=opp.id;
        insert attach;
        
        testOpp.save();
        
        testOpp.changeStageName();
        testOpp.changeProductQuota(); 
        testOpp.changeVerticalPractice();
        testOpp.close();
        
        testOpp.attachment.Name='Unit Test Attachment1.PDF';
        testOpp.attachment.body=bodyBlob;
        
        testOpp.upload();
        
        Test.StopTest();
        
    }
    
    static testMethod void insertNewOpportunity1(){
        
        Profile p = [SELECT Id, name FROM Profile WHERE Name='Standard User'];
        
        User u = new User(Alias = 'standt', Email='standarduser321abc@testorg.com', 
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, 
                          TimeZoneSidKey='America/Los_Angeles', UserName='standarduser321abc@testorg.com');
        insert u;
        
        Vertical_Practice_Quotas__c vp = new Vertical_Practice_Quotas__c();
        vp.Name = 'Test Vertical';
        insert vp;
        
        
        
        Opportunity opp = new Opportunity();
        
        opp.StageName = 'Signed Contract';
        opp.CloseDate = System.today()+5;
        opp.ForecastCategoryName = 'Closed';
        opp.Name = 'Test Opportunity Triggers';
        opp.Product_Name__c = 'FinCapture';
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
        
        Test.StartTest();
        PageReference pageRef = Page.OpportunityEditPage;
        pageRef.getParameters().put('id', String.valueOf(opp.Id));
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(opp);
        OpportunityEditExtension testOpp = new OpportunityEditExtension(sc);
        
        
        Attachment attach=new Attachment();   	
        attach.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        attach.parentId=opp.id;
        insert attach;
        
        testOpp.save();
        
        testOpp.changeStageName();        
        testOpp.close();
        
        testOpp.attachment.Name='Unit Test Attachment1.PDF';
        testOpp.attachment.body=bodyBlob;
        
        testOpp.upload();
        
        Test.StopTest();
        
    }
    
    static testMethod void conditionElse() {
        
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
        
        Test.StartTest();
        PageReference pageRef = Page.OpportunityEditPage; // Add your VF page Name here
        pageRef.getParameters().put('id', String.valueOf(opp.Id));
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc1 = new ApexPages.StandardController(opp);
        OpportunityEditExtension testOpp1 = new OpportunityEditExtension(sc1);
        
        
        Attachment attach=new Attachment();   	
        attach.Name='Unit Test Attachment';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        attach.parentId=opp.id;
        insert attach;
        
        
        testOpp1.attachment.Name='Unit Test Attachment1.txt';
        testOpp1.attachment.body=bodyBlob;
        testOpp1.upload();
        Test.StopTest();
        
    }
    
    static testMethod void conditionSave() {
        
        Vertical_Practice_Quotas__c vp = new Vertical_Practice_Quotas__c();
        vp.Name = 'Test Vertical';
        insert vp;
        
        Opportunity opp = new Opportunity();
        
        opp.StageName = 'Signed Contract';
        opp.Probability = 100;
        
        opp.CloseDate = System.today()+5;
        opp.ForecastCategoryName = 'Closed';
        opp.Name = 'Test Opportunity Triggers';
        opp.Product_Name__c = 'Not a Product';
        opp.SOW_Start_Date__c = System.today()-1;
        opp.SOW_End_Date__c = System.today()+6;
        opp.Gross_Margin__c = 60;
        
        opp.PBD__c = 'Other';
        opp.GDM__c = 'Other';
        opp.LeadSource = 'Alliances';
        opp.Staffing_Requirements__c = 'ok';
        opp.GDM_Comments__c = 'ok';
        opp.Horizontal_Practice__c = 'Digital';
        opp.Vertical_Practice2__c = vp.id;
        
        insert opp;
        
        Test.StartTest();
        PageReference pageRef = Page.OpportunityEditPage; // Add your VF page Name here
        pageRef.getParameters().put('id', String.valueOf(opp.Id));
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc2 = new ApexPages.StandardController(opp);
        OpportunityEditExtension testOpp2 = new OpportunityEditExtension(sc2);
        
        testOpp2.save();
        Test.StopTest();
    }
    
    static testMethod void conditionSaveValidationEndDate(){
        
        Vertical_Practice_Quotas__c vp = new Vertical_Practice_Quotas__c();
        vp.Name = 'Test Vertical';
        insert vp;
        
        Opportunity opp = new Opportunity();
        
        opp.StageName = 'Signed Contract';
        opp.Probability = 100;
        
        opp.CloseDate = System.today()+5;
        opp.ForecastCategoryName = 'Closed';
        opp.Name = 'Test Opportunity Triggers';
        opp.Product_Name__c = 'Not a Product';
        opp.SOW_Start_Date__c = System.today()-1;
        opp.SOW_End_Date__c = null;
        opp.Gross_Margin__c = 60;
        
        opp.PBD__c = 'Other';
        opp.GDM__c = 'Other';
        opp.LeadSource = 'Alliances';
        opp.Staffing_Requirements__c = 'ok';
        opp.GDM_Comments__c = 'ok';
        opp.Horizontal_Practice__c = 'Digital';
        opp.Vertical_Practice2__c = vp.id;
        insert opp;  
        
        Test.StartTest();
        
        PageReference pageRef = Page.OpportunityEditPage; // Add your VF page Name here
        pageRef.getParameters().put('id', String.valueOf(opp.Id));
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(opp);
        OpportunityEditExtension testOpp = new OpportunityEditExtension(sc);
        
        testOpp.save();
        System.assert(ApexPages.hasMessages(ApexPages.SEVERITY.ERROR),'When the opportunity is won and you change forecast category to closed you must provide a SOW end date.');
        
        Test.StopTest();
    }
    
    static testMethod void conditionSaveValidationGDM(){
        
        Vertical_Practice_Quotas__c vp = new Vertical_Practice_Quotas__c();
        vp.Name = 'Test Vertical';
        insert vp;
        
        Opportunity opp = new Opportunity();
        
        opp.StageName = 'Signed Contract';
        opp.Probability = 100;
        
        opp.CloseDate = System.today()+5;
        opp.ForecastCategoryName = 'Closed';
        opp.Name = 'Test Opportunity Triggers';
        opp.Product_Name__c = 'Not a Product';
        opp.SOW_Start_Date__c = System.today()-1;
        opp.SOW_End_Date__c = System.today()+6;
        opp.Gross_Margin__c = 60;
        
        opp.PBD__c = 'Other';
        opp.GDM__c = null;
        opp.LeadSource = 'Alliances';
        opp.Staffing_Requirements__c = 'ok';
        opp.GDM_Comments__c = 'ok';
        opp.Horizontal_Practice__c = 'Digital';
        opp.Vertical_Practice2__c = vp.id;
        insert opp;  
        
        Test.StartTest();
        
        PageReference pageRef = Page.OpportunityEditPage; // Add your VF page Name here
        pageRef.getParameters().put('id', String.valueOf(opp.Id));
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(opp);
        OpportunityEditExtension testOpp = new OpportunityEditExtension(sc);
        
        testOpp.save();
        System.assert(ApexPages.hasMessages(ApexPages.SEVERITY.ERROR),'The GDM must be supplied when Forecast Category is Closed.');
        
        Test.StopTest();
    }
    
    static testMethod void conditionSaveValidationGrossMargin(){
        
        Vertical_Practice_Quotas__c vp = new Vertical_Practice_Quotas__c();
        vp.Name = 'Test Vertical';
        insert vp;
        
        Opportunity opp = new Opportunity();
        
        opp.StageName = 'Signed Contract';
        opp.Probability = 100;
        
        opp.CloseDate = System.today()+5;
        opp.ForecastCategoryName = 'Closed';
        opp.Name = 'Test Opportunity Triggers';
        opp.Product_Name__c = 'Not a Product';
        opp.SOW_Start_Date__c = System.today()-1;
        opp.SOW_End_Date__c = System.today()+6;
        opp.Gross_Margin__c = null;
        
        opp.PBD__c = 'Other';
        opp.GDM__c = 'Other';
        opp.LeadSource = 'Alliances';
        opp.Staffing_Requirements__c = 'ok';
        opp.GDM_Comments__c = 'ok';
        opp.Horizontal_Practice__c = 'Digital';
        opp.Vertical_Practice2__c = vp.id;
        insert opp;  
        
        Test.StartTest();
        
        PageReference pageRef = Page.OpportunityEditPage; // Add your VF page Name here
        pageRef.getParameters().put('id', String.valueOf(opp.Id));
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(opp);
        OpportunityEditExtension testOpp = new OpportunityEditExtension(sc);
        
        testOpp.save();
        System.assert(ApexPages.hasMessages(ApexPages.SEVERITY.ERROR),'Gross Margin must be greater than zero when Probability >= 40%');
        
        Test.StopTest();
    }
    
    static testMethod void conditionSaveValidationAmount(){
        
        Vertical_Practice_Quotas__c vp = new Vertical_Practice_Quotas__c();
        vp.Name = 'Test Vertical';
        insert vp;
        
        Opportunity opp = new Opportunity();
        
        opp.StageName = 'Present Solution';
        opp.Probability = 40;
        opp.Amount = 400000;
        opp.mh_Associated_Blue_Sheet__c = false;        
        opp.CloseDate = System.today()+5;
        opp.ForecastCategoryName = 'Closed';
        opp.Name = 'Test Opportunity Triggers';
        opp.Product_Name__c = 'Not a Product';
        opp.SOW_Start_Date__c = System.today()-1;
        opp.SOW_End_Date__c = System.today()+6;
        opp.Gross_Margin__c = 30;
        
        opp.PBD__c = 'Other';
        opp.GDM__c = 'Other';
        opp.LeadSource = 'Alliances';
        opp.Staffing_Requirements__c = 'ok';
        opp.GDM_Comments__c = 'ok';
        opp.Horizontal_Practice__c = 'Digital';
        opp.Vertical_Practice2__c = vp.id;
        insert opp;  
        
        Test.StartTest();
        
        PageReference pageRef = Page.OpportunityEditPage; // Add your VF page Name here
        pageRef.getParameters().put('id', String.valueOf(opp.Id));
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(opp);
        OpportunityEditExtension testOpp = new OpportunityEditExtension(sc);
        
        testOpp.save();
        System.assert(ApexPages.hasMessages(ApexPages.SEVERITY.ERROR),'Please check Associated Blue Sheet checkbox to save.');
        
        Test.StopTest();
    }
    
    static testMethod void conditionSaveValidationLeadSource(){
        
        Vertical_Practice_Quotas__c vp = new Vertical_Practice_Quotas__c();
        vp.Name = 'Test Vertical';
        insert vp;
        
        Opportunity opp = new Opportunity();
        
        opp.StageName = 'Signed Contract';
        opp.Probability = 100;
        
        opp.CloseDate = System.today()+5;
        opp.ForecastCategoryName = 'Closed';
        opp.Name = 'Test Opportunity Triggers';
        opp.Product_Name__c = 'Not a Product';
        opp.SOW_Start_Date__c = System.today()-1;
        opp.SOW_End_Date__c = System.today()+6;
        opp.Gross_Margin__c = 60;
        
        opp.PBD__c = 'Other';
        opp.GDM__c = 'Other';
        opp.LeadSource = null;
        opp.Staffing_Requirements__c = 'ok';
        opp.GDM_Comments__c = 'ok';
        opp.Horizontal_Practice__c = 'Digital';
        opp.Vertical_Practice2__c = vp.id;
        insert opp;  
        
        Test.StartTest();
        
        PageReference pageRef = Page.OpportunityEditPage; // Add your VF page Name here
        pageRef.getParameters().put('id', String.valueOf(opp.Id));
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(opp);
        OpportunityEditExtension testOpp = new OpportunityEditExtension(sc);
        
        testOpp.save();
        System.assert(ApexPages.hasMessages(ApexPages.SEVERITY.ERROR),'The Lead Source must be supplied when Forecast Category is Closed.');
        
        Test.StopTest();
    }
    
    static testMethod void conditionSaveValidationStaffingRequirements(){
        
        Vertical_Practice_Quotas__c vp = new Vertical_Practice_Quotas__c();
        vp.Name = 'Test Vertical';
        insert vp;
        
        Opportunity opp = new Opportunity();
        
        opp.StageName = 'Signed Contract';
        opp.Probability = 100;
        
        opp.CloseDate = System.today()+5;
        opp.ForecastCategoryName = 'Closed';
        opp.Name = 'Test Opportunity Triggers';
        opp.Product_Name__c = 'Not a Product';
        opp.SOW_Start_Date__c = System.today()-1;
        opp.SOW_End_Date__c = System.today()+6;
        opp.Gross_Margin__c = 60;
        
        opp.PBD__c = 'Other';
        opp.GDM__c = 'Other';
        opp.LeadSource = 'Alliances';
        opp.Staffing_Requirements__c = null;
        opp.GDM_Comments__c = 'ok';
        opp.Horizontal_Practice__c = 'Digital';
        opp.Vertical_Practice2__c = vp.id;
        insert opp;  
        
        Test.StartTest();
        
        PageReference pageRef = Page.OpportunityEditPage; // Add your VF page Name here
        pageRef.getParameters().put('id', String.valueOf(opp.Id));
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(opp);
        OpportunityEditExtension testOpp = new OpportunityEditExtension(sc);
        
        testOpp.save();
        System.assert(ApexPages.hasMessages(ApexPages.SEVERITY.ERROR),'Staffing Requirements is mandatory when the probability becomes 50% or more');
        
        Test.StopTest();
    }
    
    static testMethod void conditionSaveValidationPBD(){
        
        Vertical_Practice_Quotas__c vp = new Vertical_Practice_Quotas__c();
        vp.Name = 'Test Vertical';
        insert vp;
        
        Opportunity opp = new Opportunity();
        
        opp.StageName = 'Signed Contract';
        opp.Probability = 100;
        
        opp.CloseDate = System.today()+5;
        opp.ForecastCategoryName = 'Closed';
        opp.Name = 'Test Opportunity Triggers';
        opp.Product_Name__c = 'Not a Product';
        opp.SOW_Start_Date__c = System.today()-1;
        opp.SOW_End_Date__c = System.today()+6;
        opp.Gross_Margin__c = 60;
        
        opp.PBD__c = null;
        opp.GDM__c = 'Other';
        opp.LeadSource = 'Alliances';
        opp.Staffing_Requirements__c = 'ok';
        opp.GDM_Comments__c = 'ok';
        opp.Horizontal_Practice__c = 'Digital';
        opp.Vertical_Practice2__c = vp.id;
        insert opp;  
        
        Test.StartTest();
        
        PageReference pageRef = Page.OpportunityEditPage; // Add your VF page Name here
        pageRef.getParameters().put('id', String.valueOf(opp.Id));
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(opp);
        OpportunityEditExtension testOpp = new OpportunityEditExtension(sc);
        
        testOpp.save();
        System.assert(ApexPages.hasMessages(ApexPages.SEVERITY.ERROR),'The PBD must be supplied when Forecast Category is Closed.');
        
        Test.StopTest();
    }
    
    static testMethod void conditionSaveValidationStartDate(){
        
        Vertical_Practice_Quotas__c vp = new Vertical_Practice_Quotas__c();
        vp.Name = 'Test Vertical';
        insert vp;
        
        Opportunity opp = new Opportunity();
        
        opp.StageName = 'Signed Contract';
        opp.Probability = 100;
        opp.CloseDate = System.today()+5;
        opp.ForecastCategoryName = 'Closed';
        opp.Name = 'Test Opportunity Triggers';
        opp.Product_Name__c = 'Not a Product';
        opp.SOW_Start_Date__c = null;
        opp.SOW_End_Date__c = System.today()+6;
        opp.Gross_Margin__c = 60;opp.PBD__c = 'Other';
        opp.GDM__c = 'Other';
        opp.LeadSource = 'Alliances';
        opp.Staffing_Requirements__c = 'ok';
        opp.GDM_Comments__c = 'ok';
        opp.Horizontal_Practice__c = 'Digital';
        opp.Vertical_Practice2__c = vp.id;
        insert opp;  
        
        Test.StartTest();
        
        PageReference pageRef = Page.OpportunityEditPage; // Add your VF page Name here
        pageRef.getParameters().put('id', String.valueOf(opp.Id));
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(opp);
        OpportunityEditExtension testOpp = new OpportunityEditExtension(sc);
        
        testOpp.save();
        System.assert(ApexPages.hasMessages(ApexPages.SEVERITY.ERROR),'The Project Start Date must be supplied when Forecast Category is Closed.');
        
        Test.StopTest();
    }
    
    static testMethod void insertOppOnProfileValidation(){
        
        Vertical_Practice_Quotas__c vp = new Vertical_Practice_Quotas__c();
        vp.Name = 'Test Vertical';
        insert vp;
        
        Profile p = [SELECT Id, name FROM Profile WHERE Name='Standard User'];
        
        User u = new User(Alias = 'standt', Email='standarduser321abc@testorg.com', 
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, 
                          TimeZoneSidKey='America/Los_Angeles', UserName='standarduser321abc@testorg.com');
        insert u;
        
        
        
        System.runAs(u) {
            
            system.debug('u-->'+u);
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
            
            Test.StartTest();
            PageReference pageRef = Page.OpportunityEditPage;
            pageRef.getParameters().put('id', String.valueOf(opp.Id));
            Test.setCurrentPage(pageRef);
            
            ApexPages.StandardController sc = new ApexPages.StandardController(opp);
            OpportunityEditExtension testOpp = new OpportunityEditExtension(sc);
            
            Attachment attach=new Attachment();   	
            attach.Name='Unit Test Attachment';
            Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
            attach.body=bodyBlob;
            attach.parentId=opp.id;
            insert attach;
            
            testOpp.save();
            testOpp.changeStageName();
            testOpp.close();
            
            testOpp.attachment.Name='Unit Test Attachment1.PDF';
            testOpp.attachment.body=bodyBlob;
            
            testOpp.upload();
            
            Test.StopTest();
        }
    }
    
    static testMethod void exceptionValidate(){
        
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
        
    }
}