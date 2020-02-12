/*
* Description: This Apex Trigger helps the lead assignment rule "UpdateLeadOwner" to run, when certain conditions are met.
* Another class named "AvoidRecursion" is called in this trigger for avoiding recursion.
* Test Class - RunLeadAssignmentRuleTest
*-------------------------------------------------------------------------------------------------------
*  Author                          Date                               Project         
*  Shiwangi Jha                    6/12/2018                          Tavant Internal Sales 
*-------------------------------------------------------------------------------------------------------
*/
trigger RunLeadAssignmentRule on Lead (after update) {
    
    List<Lead> leadList = new List<Lead>();
    List<Lead> updatedLeadList = new List<Lead>();
    
    // Calling Active Lead Assignment Rule
    AssignmentRule  AR = [select id, active, name, SobjectType from AssignmentRule where SobjectType =: 'Lead' AND active =: true];
    Database.DMLOptions dmo = new Database.DMLOptions();
    dmo.assignmentRuleHeader.assignmentRuleId= AR.Id;
    
    for(Lead l : Trigger.new){
        
        // Checking the conditions for assigning lead to new lead owner
        if(l.Status == 'Incorrect Data' && l.Owner.UserRole.Name != 'Inside sales'){
            leadList.add(l);
        }               
    }    
    for(Lead ld : leadList){
        Lead eachLead = new Lead();
        eachLead.Id = ld.Id;
        eachLead.setOptions(dmo);  
        updatedLeadList.add(eachLead); 
        
    }
    
    // To avoid recursion process for After Update
    if(AvoidRecursion.firstRun == true){
        AvoidRecursion.firstRun = false;
        database.update(updatedLeadList,dmo);
    }    
    
}