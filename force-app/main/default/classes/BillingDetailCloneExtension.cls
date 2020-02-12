/*
* Description: This class displays a list of Billing Details records which are clones of a Billing Details record.
* These multiple Billing Details records are then edited and saved to create multiple new Billing Details records at the same time.
* Test class - BillingDetailCloneExtensionTest
*-------------------------------------------------------------------------------------------------------
*  Author                          Date                               Project         
*  Shiwangi Jha                    2/21/2018                          Tavant Internal Sales 
*-------------------------------------------------------------------------------------------------------
*/
public with sharing class BillingDetailCloneExtension {    
    
    public list <Billing_Details__c> bdList {get; set;}
    public Integer probability{get;set;}
    
    public BillingDetailCloneExtension (ApexPages.StandardController controller) {
        
        Billing_Details__c cloneDetail = new Billing_Details__c();
        bdList = new list <Billing_Details__c>();
        list <Billing_Details__c> cloneDetailList = [Select Opportunity_Name__r.Probability,Opportunity_Name__r.Name, Opportunity_Name__c, Month__c, Year__c,
                                                     BILLING_FORECAST__c, BILLING_LIKELY__c, BILLING_EXPECTED__c, Billing_Expected_Comments__c, BILLING_ACTUAL__c,
                                                     Comments__c, Actual_Invoice_Date__c, Actual_Invoice_Number__c, Locked__c
                                                     From Billing_Details__c
                                                     where Id =: ApexPages.currentPage().getParameters().get('id')]; //field values of that Billing Details record which is cloned.
 
        integer i ;
        
        //this method clones the same record multiple times.
        for(i=0;i< integer.valueOf(System.Label.Clone_Number);i++) {
            
            for(Billing_Details__c  bd: cloneDetailList){
                
                cloneDetail= new Billing_Details__c();
                cloneDetail.Opportunity_Name__c = bd.Opportunity_Name__c; 
                
                if(i==0 && Integer.valueOf(bd.Month__c) != 12){
                    cloneDetail.Month__c = String.valueOf(Integer.valueOf(bd.Month__c) + 1);
                }
                else if(Integer.valueOf(bd.Month__c) + i < 12){
                    cloneDetail.Month__c = String.valueOf(Integer.valueOf(bd.Month__c) + i + 1) ;   
                }
                else{
                    cloneDetail.Month__c =  String.valueOf(Integer.valueOf(bd.Month__c) + i - 11);      
                }
                
                if(Integer.valueOf(bd.Month__c) + i < 12){
                    cloneDetail.Year__c= String.valueOf(Integer.valueOf(bd.Year__c));
                }else{
                    cloneDetail.Year__c= String.valueOf(Integer.valueOf(bd.Year__c) + 1);
                }

                cloneDetail.BILLING_FORECAST__c = bd.BILLING_FORECAST__c;
                cloneDetail.BILLING_LIKELY__c= bd.BILLING_LIKELY__c;
                cloneDetail.BILLING_EXPECTED__c = bd.BILLING_EXPECTED__c;
                cloneDetail.Billing_Expected_Comments__c = bd.Billing_Expected_Comments__c;
                cloneDetail.BILLING_ACTUAL__c = bd.BILLING_ACTUAL__c;
                cloneDetail.Comments__c= bd.Comments__c;
                cloneDetail.Actual_Invoice_Date__c= bd.Actual_Invoice_Date__c;
                cloneDetail.Actual_Invoice_Number__c = bd.Actual_Invoice_Number__c;
                cloneDetail.Locked__c = bd.Locked__c;
                
                bdList.add(cloneDetail); // list of cloned records.
                
            }
            
        }
        probability = (Integer) cloneDetailList[0].Opportunity_Name__r.Probability; // to fetch the value of Probability of the opportunity record.
        
    }
    
    
    public PageReference cancel() {
        
        return (new Pagereference('/'+ApexPages.currentPage().getParameters().get('id')));
        
    }
    
    //list of cloned records is edited and saved to create new records.
    public PageReference save() {
        
        try{   
            if(!bdList.isEmpty()){
                insert bdList;
            }                 
        } catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage())); 
            return null;
        }        
        return (new Pagereference('/'+ApexPages.currentPage().getParameters().get('id')));
        
    } 
    
}