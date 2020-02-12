/**
*  NAME:  IdeaTrigger
*  Copyright ? 2019 Tavant Technology.
* -------------------------------------------------------------------------------------------------
Purpose:  This trigger is used for Sharing an Idea to the Community Users. 
* --------------------------------------------------------------------------------------------------
*  HISTORY:                                                            
*  -------
*  @AUTHOR      :   
*  @VERSION     :   1.0
*  @CREATED     :   03-APR-2019
*  @DETAIL      :   INITIAL DEVELOPMENT
*  @MODIFIED    :
* --------------------------------------------------------------------------------------------------
* @CHANGES
* -------------------------------------------------------------------------------------------------
*/
trigger IdeaTrigger on Idea__c (after insert, before update, after update ) {
    //SELECT ID,Name,ContactID,Contact.AccountId FROM User Where ContactID != NULL
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            // Logic to sharing the Ideas to the internal Users(Contacts) for the organization(Account).
            IdeaTriggerhelper.processSharingMechanisim(trigger.newMap.keySet());
        }
    }
   
    if(Trigger.isBefore){
        if(Trigger.isUpdate){
            IdeaTriggerHelper.IdeaStatusValidate(trigger.newMap, trigger.OldMap);
        }
    }
    
    if(Trigger.isAfter){
        if(Trigger.isUpdate){
            
            // Logic to sharing the Ideas to the internal Users(Contacts) for the organization(Account).
           IdeaTriggerhelper.shareIdeasOnUpd(trigger.new, trigger.OldMap);
        }
    }
}