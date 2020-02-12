trigger UpdateSales_MarketingName on Sales_Marketing_Data_Form__c (after insert) {
    Set<ID> setaccId = new Set<ID>();
    for(Sales_Marketing_Data_Form__c  acc : trigger.new)
        {
            setaccId.add(acc.Id);
        }    
    if(setaccId.size() > 0)
        {    
            List<Sales_Marketing_Data_Form__c > listTask = [Select Name, Month__c, Year__c from Sales_Marketing_Data_Form__c  where Id in: setaccId];
            for(Sales_Marketing_Data_Form__c  t : listTask )
              {
              t.Name= t.Name+'_'+t.Month__c+'_'+t.Year__c;
              }           
            //update listTask 
            update listTask;    
        }
}