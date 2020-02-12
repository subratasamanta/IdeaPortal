/**********************************************************************
Name:  ()
Copyright © 2016  Tavant
======================================================
======================================================
Purpose:                                                            

======================================================
======================================================
History                                                            
-------                                                            
VERSION  AUTHOR         DATE(mm/dd/yyy) DETAIL                          FEATURES/CSR/TTP
1.0 -    Praveen KH     01/07/2016      INITIAL DEVELOPMENT             FEATURES
***********************************************************************/
global class DailySalesForecastBatch implements Database.Batchable<sObject>{

    global Database.QueryLocator start(Database.BatchableContext BC){
        String query = 'SELECT ID FROM Account LIMIT 1';
        return Database.getQueryLocator(query);
    }
    
    
    global void execute(Database.BatchableContext BC, List<Account> scope){
        
          Sales_Forecast__C newRec = new Sales_Forecast__C();
          newRec.Date__c = system.today();
          
          List<AggregateResult> expTotal = [SELECT Sum(Billing_Expected__C) from Billing_Details__C where Opportunity_Name__r.ForecastCategoryName != 'Omitted' AND Billing_Expected__c != null AND Billing_Date__C = THIS_QUARTER];
          newRec.Expected__c = (Decimal) expTotal[0].get('expr0');
          
          List<AggregateResult> frcstTotal = [SELECT Sum(Billing_Forecast__C) from Billing_Details__C where Opportunity_Name__r.ForecastCategoryName != 'Omitted' AND Billing_Forecast__C != null AND Billing_Date__C = THIS_QUARTER];
          newRec.Forecast__c = (Decimal) frcstTotal[0].get('expr0');

          List<AggregateResult> likelyTotal = [SELECT Sum(Billing_Likely__c) from Billing_Details__C where Opportunity_Name__r.ForecastCategoryName != 'Omitted' AND Billing_Likely__c != null AND Billing_Date__C = THIS_QUARTER];
          newRec.Likely__c = (Decimal) likelyTotal[0].get('expr0');

          List<AggregateResult> nextExpTotal = [SELECT Sum(Billing_Expected__C) from Billing_Details__C where Opportunity_Name__r.ForecastCategoryName != 'Omitted' AND  Billing_Expected__c != null AND Billing_Date__C = NEXT_QUARTER];
          newRec.NextQuarterExpected__c = (Decimal) nextExpTotal[0].get('expr0');
          
          List<AggregateResult> nextFrcstTotal = [SELECT Sum(Billing_Forecast__C) from Billing_Details__C where Opportunity_Name__r.ForecastCategoryName != 'Omitted' AND Billing_Forecast__C != null AND Billing_Date__C = NEXT_QUARTER];
          newRec.NextQuarterForecast__c = (Decimal) nextFrcstTotal[0].get('expr0');

          List<AggregateResult> nextLikelyTotal = [SELECT Sum(Billing_Likely__c) from Billing_Details__C where Opportunity_Name__r.ForecastCategoryName != 'Omitted' AND  Billing_Likely__c != null AND Billing_Date__C = NEXT_QUARTER];
          newRec.NextQuarterLikely__c = (Decimal) nextLikelyTotal[0].get('expr0');


          
          insert newRec;        
        
    }
    
    global void finish(Database.BatchableContext BC){
     
    }
            
}