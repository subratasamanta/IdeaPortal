/**
*  Name:  VoteController
*  Copyright ? 2019 Tavant Technology.
* -------------------------------------------------------------------------------------------------
Purpose:  This class is used for get the votes.
* --------------------------------------------------------------------------------------------------
*  History                                                            
*
*  @AUTHOR		:   
*  @VERSION     :   1.0
*  @CREATED     :   05-APR-2019
*  @DETAIL		:	INITIAL DEVELOPMENT
*  @MODIFIED	:
* --------------------------------------------------------------------------------------------------
* @changes
* -------------------------------------------------------------------------------------------------
*/
public with sharing class VoteController {
    
    /*******************************************************************
AUTHOR 				: 
PURPOSE				: get Vote list                                                
PARAMETERS			: Idea String, User String
RETURNS				: Returns list of votes
THROWS [EXCEPTIONS]	: N/A  
********************************************************************/    
    @AuraEnabled
    public static ideaWrapperCLS getData(String Ideaid, String userId){
        Map<String, Idea_Setting__mdt> ideaStMap = IdeaUtility.fetchIdeaSet();
        ideaWrapperCLS wrapCLS = new ideaWrapperCLS();
        try{
            Vote__c[]  v = [Select Id,Upvote__c,DownVote__c ,Idea__c,User__c From Vote__c where Idea__c = :Ideaid and User__c=:userId];
            Idea__c i = [Select id,Status__c from Idea__c where id =:Ideaid];
            Idea_Setting__mdt md = [Select Show_Add_Cmnts__c,Show_Downvote__c,Show_Upvote__c,Current_Status__c, dontShowComments__c,
        	New_Status_Alwd__c,Aply_Status_Validatn__c,Status_Err_Msg__c
             from Idea_Setting__mdt where Current_Status__c=:i.Status__c limit 1];
           
            wrapCLS.idea = v;
            wrapCLS.upvoted = md.Show_Upvote__c;
            wrapCLS.downvoted =md.Show_Downvote__c;
            return wrapCLS;
            
        }catch(QueryException e){
            return null;
        }catch(Exception eq){
            return null;  
        }
    }
    
    
    public class ideaWrapperCLS{
        @AuraEnabled
        public List<Vote__c> idea;
        @AuraEnabled
        public boolean upvoted;
        @AuraEnabled
        public boolean downvoted;
    }
    
    /*******************************************************************
AUTHOR 				: 
PURPOSE				: get Idea deatails                                                   
PARAMETERS			: Idea Id
RETURNS				: Returns Idea object
THROWS [EXCEPTIONS]	: N/A  
********************************************************************/     
    @AuraEnabled
    public static Idea__c getIdea(String ideaId){
        try{
            Idea__c  i = [Select Id,Status__c,Upvote_Sum__c,DownVote_Sum__c From Idea__c where Id=:Ideaid];
            Idea_Setting__mdt md = [Select Show_Add_Cmnts__c,Show_Downvote__c,Show_Upvote__c,Current_Status__c, dontShowComments__c,
        New_Status_Alwd__c,Aply_Status_Validatn__c,Status_Err_Msg__c
             from Idea_Setting__mdt limit 1 ];
            return i;
        }catch(QueryException e){
            System.debug('-----------'); 
            return null;
        }catch(Exception eq){
            return null;  
        }
    }
    
    
    
    /*******************************************************************
AUTHOR 				: 
PURPOSE				: loggedInUser Information.                                                 
PARAMETERS			: N/A
RETURNS				: Returns User Id
THROWS [EXCEPTIONS]	: N/A  
********************************************************************/    
    @AuraEnabled 
    public static Id getLoggedInUser(){
        return UserInfo.getUserId();
    }
    /*******************************************************************
AUTHOR 				: 
PURPOSE				: Updating the votes                                                
PARAMETERS			: Voter Id, Integers of  Upvote AND Downvote.
RETURNS				: void
THROWS [EXCEPTIONS]	: N/A  
********************************************************************/   
    @AuraEnabled 
    public static void updateVote(String voteId,Integer upvote,Integer downvote){ 
        Vote__c v = new  Vote__c();
        v.Id = Id.valueOf(voteId);
        v.DownVote__c = downvote;
        v.Upvote__c = upvote;
        update v;
    }
    /*******************************************************************
AUTHOR 				: 
PURPOSE				: Inserting votes on vote Object                                                  
PARAMETERS			: Voter Id, Integers of  Upvote AND Downvote , User Id.
RETURNS				: Returns vote object.
THROWS [EXCEPTIONS]	: N/A  
********************************************************************/     
    @AuraEnabled 
    public static Vote__c insertVote(String ideaId,Integer upvote,Integer downvote,String userId){ 
        Vote__c v = new  Vote__c();
        v.Idea__c = Id.valueOf(ideaId);
        v.DownVote__c = downvote;
        v.Upvote__c = upvote;
        v.User__c = Id.valueOf(userId);
        insert v;
        return v;
    }
     /*******************************************************************
AUTHOR 				: 
PURPOSE				: deleting votes on vote Object                                                  
PARAMETERS			: Voter Id
RETURNS				: Returns String.
THROWS [EXCEPTIONS]	: N/A  
********************************************************************/     
    @AuraEnabled 
    public static String deleteWithDrawnVote(String votedDataId){ 
        try{
            Vote__c vote =[Select id from Vote__c where id =:votedDataId];
       		delete vote;
            return 'Deleted';
        }catch(Exception ex){
          return 'Not Deleted';  
        }
    }
    

}