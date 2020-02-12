/*
* Description: This visualforce page displays a list of multiple Billing Details records associated to an opportunity record.
* These multiple Billing Details records can be selected, edited or deleted and then saved at the same time.
* Test class - BillingDetailEditExtensionTest
*-------------------------------------------------------------------------------------------------------
*  Author                          Date                               Project         
*  Shiwangi Jha                    2/21/2018                          Tavant Internal Sales 
*-------------------------------------------------------------------------------------------------------
*/
public with sharing class BillingDetailEditExtension {
    
    public List<BillingDetailWrapper> billingDetailsList {get; set;}
    string strBdQuery = '';
    string whereClause = '';
    string whereIds = '';
    public Integer probability{get;set;}    
    
    
    public BillingDetailEditExtension(ApexPages.StandardSetController controller) {
        
        billingDetailsList = new list<BillingDetailWrapper>();
        Id oppId = ApexPages.currentPage().getParameters().get('id');
        set<string> selectedBdIDSet = new set<string>();
        
        strBdQuery = 'Select Id,Name,Opportunity_Name__r.Name, Opportunity_Name__r.Probability, Opportunity_Name__c, Month__c, Year__c'+
            ',BILLING_FORECAST__c, BILLING_LIKELY__c, BILLING_EXPECTED__c, Billing_Expected_Comments__c, BILLING_ACTUAL__c,'+
            'Comments__c, Actual_Invoice_Date__c, Actual_Invoice_Number__c, Locked__c From Billing_Details__c where ';
        
        if(controller.getSelected().size() > 0){
            for(sobject eachbd:  controller.getSelected()){
                if(whereIds ==''){
                    whereIds = '\''+eachbd.Id+'\'' ;
                }else{
                    whereIds = whereIds + ','+ '\''+eachbd.Id+'\'';
                }
            }
            whereClause = 'Id IN ('+ whereIds +')';    
            system.debug('---strBdQuery-1-'+strBdQuery);  
        } 
        else{ 
            whereClause = 'Opportunity_Name__c = \''+oppId+'\' ';
            system.debug('---strBdQuery-2-'+strBdQuery);
        }
        strBdQuery += whereClause;
        
        //Getting the records through dynamic query.
        list<Billing_Details__c> billingList = database.query(strBdQuery);
        System.debug('----billingList-----'+billingList);
        if(!billingList.isEmpty()){
            for(Billing_Details__c eachbd: billingList){
                billingDetailsList.add(new BillingDetailWrapper (eachbd));
            }   
        }
        Billing_Details__c b =   billingList[0];
        probability = (Integer) b.Opportunity_Name__r.Probability;
        system.debug('---probability-2-'+probability);
        
        
    }
    
    //Get the list of the Billing Details records.
    public List<BillingDetailWrapper> getBillingDetailsList() {
        Id oppId = ApexPages.currentPage().getParameters().get('id');
        billingDetailsList = new List<BillingDetailWrapper>();
        system.debug('--whereIds---'+whereIds);
        system.debug('--strBdQuery---'+strBdQuery);
        
        list<Billing_Details__c> billingList = database.query(strBdQuery);
        if(!billingList.isEmpty()){
            for(Billing_Details__c eachbd: billingList){
                billingDetailsList.add(new BillingDetailWrapper (eachbd));
            }    
        }
        system.debug('--strBdQuery-3---'+strBdQuery); 
        
        return billingDetailsList;
    }
    
    public PageReference save() {
        
        List<Billing_Details__c> billingDetailsNewList = new List<Billing_Details__c>();
        
        for(BillingDetailWrapper bdetail: billingDetailsList){
            billingDetailsNewList.add(bdetail.bd);
        }
        
        try{    
            if(!billingDetailsNewList.isEmpty()){
               update billingDetailsNewList; 
            }    	                
        } catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage())); 
            return null;
        }        
        return (new Pagereference('/'+ApexPages.currentPage().getParameters().get('id')));
        
    } 
    
    public PageReference cancel() {
        
        return (new Pagereference('/'+ApexPages.currentPage().getParameters().get('id')));
        
    } 
    
    //To delete the selected records.
    public void deleteSelected() {
        
        List<Billing_Details__c> selectedBillingDetails = new List<Billing_Details__c>();
        for(BillingDetailWrapper bdetails: billingDetailsList) {
            if(bdetails.selected == true) {
                selectedBillingDetails.add(bdetails.bd); 
            }           
        }
        
        try{ 
            if(!selectedBillingDetails.isEmpty()){
               delete selectedBillingDetails; 
            }               
        } catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));                      
        }        
        billingDetailsList = getBillingDetailsList();  
    }
    
    //This wrapper class binds the checkboxes to the records.
    public class BillingDetailWrapper {
        public Billing_Details__c bd {get; set;}
        public Boolean selected {get; set;}
        
        public BillingDetailWrapper(Billing_Details__c b) {
            bd = b;
            selected = false;
        }
    }
}