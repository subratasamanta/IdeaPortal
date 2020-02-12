/**
*  NAME:  IdeaTriggerhelper
*  Copyright ? 2019 Tavant Technology.
* -------------------------------------------------------------------------------------------------
Purpose:  This class is used for IdeaTrigger. 
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
public without sharing class IdeaTriggerhelper{
   
   public static Set<Id> getAccChangedIdeas(List<Idea__c> trigNew, Map<Id,Idea__c> trigOldMap){
       Set<Id> ideasList = new Set<Id> ();
       for(Idea__c idR : trigNew){
            if((idr.Contact__c != trigOldMap.get(idr.id).Contact__c)|| (idr.Customer__c != trigoldMap.get(idr.Id).Customer__c)){
                ideasList.add(idr.id);
            }
        }
        return ideasList;
   }
   
   
   public static void shareIdeasOnUpd(List<Idea__c> trigNew, Map<Id,Idea__c> trigOldMap){
       Set<Id> ideas = new Set<Id> ();
       ideas = getAccChangedIdeas(trigNew, trigOldMap);
       if(ideas <> null && ideas.size() > 0){
           processSharingMechanisim(ideas);
       }
   }
   
    /*******************************************************************
AUTHOR              : 
PURPOSE             : Logic to sharing the Ideas to the internal Users(Contacts) for the organization(Account).                                               
PARAMETERS          : Set of Idea Id List.
RETURNS             : Returns void
THROWS [EXCEPTIONS] : N/A  
********************************************************************/     
    @future
    public static void processSharingMechanisim(Set<Id> ideaIdList){
        List<Idea__c> ideaList = new List<Idea__c>();
        ideaList =[SELECt ID,Customer_User_Contact_Id__c,Customer_User_Account_Id__c,Ownerid FROM Idea__c Where Id IN : ideaIdList LIMIT 50000];
        Set<Id> accIdSet = new Set<Id>();
        Map<Id,Id> conIdIdeaIdMap = new Map<Id,Id>();
        Map<Id,List<Id>> accIdIdeaIdMap = new Map<Id,List<Id>>();
        for(Idea__c ide : ideaList ){
            if(String.isNotBlank(ide.Customer_User_Account_Id__c) ){
                if(!accIdIdeaIdMap.isEmpty() && accIdIdeaIdMap.containsKey(ide.Customer_User_Account_Id__c)){
                    accIdIdeaIdMap.get(ide.Customer_User_Account_Id__c).add(ide.Id);
                    system.debug('created Idea record ID  in if part++:::'+ accIdIdeaIdMap.get(ide.Customer_User_Account_Id__c).add(ide.Id));
                }else{
                    accIdIdeaIdMap.put(ide.Customer_User_Account_Id__c,new List<Id>{ide.Id});
                    system.debug('created Idea record ID in else part +++:::'+accIdIdeaIdMap.put(ide.Customer_User_Account_Id__c,new List<Id>{ide.Id}));
                }
            }
            if(String.isNotBlank(ide.Customer_User_Account_Id__c) ){
                accIdSet.add(ide.Customer_User_Account_Id__c);
            }
        }
        system.debug('accIdSet++:::'+accIdSet );
        system.debug('accIdIdeaIdMap++:::'+accIdIdeaIdMap );
        system.debug('conIdIdeaIdMap++:::'+conIdIdeaIdMap );
        Map<Id,Id> conIdUserIdMap = new Map<Id,Id>();
        Map<Id,List<Id>> accIdUserIdMap = new Map<Id,List<Id>>();
        
        for(User usr : [SELECT ID,Name,ContactID,Contact.AccountId FROM User 
                        WHERE ContactID != NULL 
                        AND Contact.AccountId IN:accIdIdeaIdMap.keyset() 
                        AND  Id != : userInfo.getUserId() AND IsActive = true 
                        LIMIT 50000]){
                             system.debug('users contact &&&&&&'+ usr);
                            system.debug('user contact and account Ids+++++++'+usr.Contact.AccountId);
                            if(!accIdUserIdMap.isEmpty() && accIdUserIdMap.containsKey(usr.Contact.AccountId)){
                                accIdUserIdMap.get(usr.Contact.AccountId).add(usr.Id);
                                system.debug('Account Id in if part ++:::1'+ accIdUserIdMap.get(usr.Contact.AccountId).add(usr.Id));
                            }else{
                                accIdUserIdMap.put(usr.Contact.AccountId,new List<Id>{usr.Id});
                                system.debug('Account Id in else  ++:::2'+  accIdUserIdMap.put(usr.Contact.AccountId,new List<Id>{usr.Id}));
                            }
                        }
        system.debug('conIdUserIdMap :::'+conIdUserIdMap );
        system.debug('accIdUserIdMap++:::'+accIdUserIdMap );
        List<Idea__Share> ideaShrList = new List<Idea__Share>();
        if(accIdIdeaIdMap != null){
            for(Id accId : accIdIdeaIdMap.keySet()){
                for(Id ideaId : accIdIdeaIdMap.get(accId)){
                    if(accIdUserIdMap != null){
                        for(Id usrId : accIdUserIdMap.get(accId)){
                            Idea__Share ideaShr  = new Idea__Share();
                            ideaShr.ParentId = ideaId;
                            ideaShr.UserOrGroupId = usrId;
                            ideaShr.AccessLevel = 'edit';
                            ideaShr.RowCause = 'manual';
                            ideaShrList.add(ideaShr);
                        }
                    }
                }
            }
        }
        system.debug('ideaShrList:::'+ideaShrList);
        if(!ideaShrList.isEmpty()){
            insert ideaShrList;
        }
       /* try{
            if(!ideaShrList.isEmpty()){
                insert ideaShrList;
            }
        }Catch(exception e){
            system.debug('failed due to:::::'+e);
        }*/
        
        
    }   
    
    public static void IdeaStatusValidate(Map<Id,Idea__c > trigNewM, Map<Id,Idea__c> trigOldM){
        Map<String, Idea_Setting__mdt> ideaStMap = IdeaUtility.fetchIdeaSet();
        for(Idea__c idRO : trigOldM.values()){
            if(idrO.Status__c != trigNewM.get(idrO.Id).Status__c){
                if(ideaStMap.containsKey(idrO.Status__c) && ideaStMap.get(idRO.Status__c ).Aply_Status_Validatn__c){
                    
                    String newValsAl = ideaStMap.get(idrO.Status__c).New_Status_Alwd__c;
                    if(! newValsAl.contains(trigNewM.get(idrO.Id).Status__c)){
                        trigNewM.get(idrO.Id).addError (ideaStMap.get(idrO.Status__c).Status_Err_Msg__c);
                    }
                }
            }
        }
        
            
    }    
}