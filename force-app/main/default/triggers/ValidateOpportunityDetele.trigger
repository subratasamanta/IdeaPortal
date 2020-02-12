/**********************************************************************
 Name:  ValidateOpportunityDetele Trigger
 Copyright © 2013  TAVANT Technologies
======================================================
======================================================
Purpose:                                                            
-------     
SFDC users (except Admins and Finance users) should 
not be able to delete any Opportunity record if there is 
at least one billing details with a proper billing actual 
is associated with that opportunity                                                        
======================================================
======================================================
History                                                            
-------                                                            
VERSION     AUTHOR            DATE            DETAIL                          
1.0         Praveen KH        25/02/2013      INITIAL DEVELOPMENT             
***********************************************************************/

trigger ValidateOpportunityDetele on Opportunity (before delete) {

  Profile UserProfile = [SELECT Name FROM Profile Where Id = :UserInfo.getProfileId() LIMIT 1];
  String ProfileName = UserProfile.Name;  
  
  //if profile is not admin and tavant finance user 
  if(!'System Administrator'.equals(ProfileName) && !'Tavant Finance Profile'.equals(ProfileName)){
  //if(!'Tavant Finance Profile'.equals(ProfileName)){  
      for (Opportunity opp : trigger.old){
          if(0 < opp.Count_of_Billing_Details_with_Actual__c){
              opp.addError('<Font color=red><B>Opportunity contains actual revenue data and cannot be deleted. Please contact Salesforce Administrator or Finance team.</b></font>');
          }
      }
  } 
}