trigger UpdateFinanceName on Finance_Data_form__c (after insert) {
    Set<ID> setaccId = new Set<ID>();
    for(Finance_Data_form__c  acc : trigger.new)
        {
            setaccId.add(acc.Id);
        }    
    if(setaccId.size() > 0)
        {    
            List<Finance_Data_form__c > listTask = [Select Name, Month__c, Year__c from Finance_Data_form__c  where Id in: setaccId];
            for(Finance_Data_form__c  t : listTask )
              {
              t.Name= t.Name+'_'+t.Month__c+'_'+t.Year__c;
              }           
            //update listTask 
            update listTask;    
        }
}