trigger InsertDailyRecord on Batch_Script__c bulk (after update) {

for(Batch_Script__c bs:Trigger.new)
{
    if(bs.Run__C == true)
    {
        system.debug('Attempting to insert salesforecast data');
        
        try{
          Sales_Forecast__C newRec = new Sales_Forecast__C();
          newRec.Date__c = system.today();
          
          List<AggregateResult> expTotal = [SELECT Sum(Billing_Expected__C) from Billing_Details__C where Billing_Expected__c != null AND Billing_Date__C = THIS_QUARTER];
          newRec.Expected__c = (Decimal) expTotal[0].get('expr0');
          
          List<AggregateResult> frcstTotal = [SELECT Sum(Billing_Forecast__C) from Billing_Details__C where Billing_Forecast__C != null AND Billing_Date__C = THIS_QUARTER];
          newRec.Forecast__c = (Decimal) frcstTotal[0].get('expr0');

          List<AggregateResult> likelyTotal = [SELECT Sum(Billing_Likely__c) from Billing_Details__C where Billing_Likely__c != null AND Billing_Date__C = THIS_QUARTER];
          newRec.Likely__c = (Decimal) likelyTotal[0].get('expr0');
          
          insert newRec;
          
          system.debug('Attemptin to insert salesforecast data - save point 2');
          
          Batch_Script__c ourBS = new Batch_Script__c (
          Id = bs.Id,
          Run__c = false,
          Last_run__c = system.now()
          );
          update ourBS;
                    
        }
        catch(Exception ex)
        {
        system.debug('Exception occured in inserting Sales Forecast data');
        }
    }
}
}