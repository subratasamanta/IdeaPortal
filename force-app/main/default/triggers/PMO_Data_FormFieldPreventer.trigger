trigger PMO_Data_FormFieldPreventer on PMO_Data_Form__c (before insert, before update) {
     Map<String, PMO_Data_Form__c > leadMap = new Map<String, PMO_Data_Form__c >();
    for (PMO_Data_Form__c  lead : System.Trigger.new) {          
            if ((lead.Month__c != null) && (lead.Year__c != null) &&
                (System.Trigger.isInsert ||
                (lead.Month__c !=System.Trigger.oldMap.get(lead.Id).Month__c) && (lead.Year__c!=System.Trigger.oldMap.get(lead.Id).Year__c))) {           
            if (leadMap.containsKey(lead.Month__c) && leadMap.containsKey(lead.Year__c)) {
                lead.Month__c.addError('Another new Dataform has the '
                                    + 'same Month__c ');
            } else {
                leadMap.put(lead.Month__c, lead);
                 leadMap.put(lead.Year__c, lead);
            }
       }
    }   
     
    for (PMO_Data_Form__c  lead : [SELECT Month__c, Year__c FROM PMO_Data_Form__c  
                      WHERE Month__c IN :leadMap.KeySet() and Year__c IN :leadMap.KeySet()]) {
        PMO_Data_Form__c  newLead = leadMap.get(lead.Month__c);
        newLead.Month__c.addError('A PMO_Data_Form Data Form with this Month'
                               + ' already exists.');
        PMO_Data_Form__c  newLead2 = leadMap.get(lead.Year__c);
        newLead2.Year__c.addError('A PMO_Data_Form Data Form with this Year'
                               + ' already exists.');     
    }
}