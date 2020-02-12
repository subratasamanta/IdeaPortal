public without sharing class IdeaUtility{
    
    public static Map<String, Idea_Setting__mdt> fetchIdeaSet(){
        Map<String, Idea_Setting__mdt> ideaStMap = new Map<String, Idea_Setting__mdt>();        
        for(Idea_Setting__mdt idr : [Select Show_Add_Cmnts__c,Show_Downvote__c,Show_Upvote__c,Current_Status__c, dontShowComments__c,
        New_Status_Alwd__c,Aply_Status_Validatn__c,Status_Err_Msg__c
             from Idea_Setting__mdt ]){
            ideaStMap.put(idr.Current_Status__c, idr);
        }
        return ideaStMap;
    }
}