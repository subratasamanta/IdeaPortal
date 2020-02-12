/********************************************** 
Name: AccountTeamAutomation trigger
Author: Nishad K
Date: 04/19/2019
Purpose: To automate Account team allocation based on the account's Vertical Practice
*//////////////////////////////////////////////// 
trigger AccountTeamAutomation on Account (after insert) {
    Map<string,list<Vertical_Practice_Team__c>> VerticalPracticeMap = new Map<string,list<Vertical_Practice_Team__c>>();
    for(Vertical_Practice_Team__c VPT : [SELECT id,Team_Member__c,Team_Member_Role__c,Vertical_Practice__c FROM Vertical_Practice_Team__c  WHERE Vertical_Practice__c != null]){
        if(VerticalPracticeMap.containsKey(VPT.Vertical_Practice__c)){
             list<Vertical_Practice_Team__c> VPTList = VerticalPracticeMap.get(VPT.Vertical_Practice__c);
             VPTList.add(VPT);
             VerticalPracticeMap.put(VPT.Vertical_Practice__c, VPTList);  
          }
    }
     for(Account Acct : trigger.new){
			If(VerticalPracticeMap.containsKey(acct.Vertical_Practice__c)){
                
                    
            }
     }
}