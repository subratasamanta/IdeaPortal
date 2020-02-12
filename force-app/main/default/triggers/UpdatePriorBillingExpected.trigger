/**********************************************************************
 Name:  UpdatePriorBillingExpected Trigger
 Copyright © 2013  TAVANT Technologies
======================================================
======================================================
Purpose:                                                            
-------     
Update Prior Billing Expected field                                                 
======================================================
======================================================
History                                                            
-------                                                            
VERSION     AUTHOR            DATE            DETAIL                          
1.0         Praveen KH        02/04/2013      INITIAL DEVELOPMENT             
***********************************************************************/
trigger UpdatePriorBillingExpected on Billing_Details__c (before update) {    
    System.debug('-># UpdatePriorBillingExpected');
    
    Map<Id,Billing_Details__c > oldBDMap = Trigger.oldMap;    
    
    for(Billing_Details__c bd : Trigger.new){
        Billing_Details__c OldBD = oldBDMap .get(bd.Id);
        if(bd.BILLING_EXPECTED__c <> OldBD .BILLING_EXPECTED__c){
            bd.Prior_Billing_Expected__c = OldBD.BILLING_EXPECTED__c;
        }
    }
    System.debug('<-# UpdatePriorBillingExpected');
}