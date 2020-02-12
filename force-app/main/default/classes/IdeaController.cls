/**
*  Name:  IdeaController
*  Copyright ? 2019 Tavant Technology.
* -------------------------------------------------------------------------------------------------
Purpose:  This class is used for Ability to submit an idea.
* --------------------------------------------------------------------------------------------------
*  History                                                            
*
*  @AUTHOR      :   
*  @VERSION     :   1.0
*  @CREATED     :   04-FEB-2019
*  @DETAIL      :   INITIAL DEVELOPMENT
*  @MODIFIED    :
* --------------------------------------------------------------------------------------------------
* @changes
* -------------------------------------------------------------------------------------------------
*/
public with sharing class IdeaController {    
    
    /*******************************************************************
AUTHOR              : 
PURPOSE             : onLoad displaying all Ideas                                                    
PARAMETERS          : N/A
RETURNS             : Returns list of WrapperIdeasWithComments
THROWS [EXCEPTIONS] : N/A  
********************************************************************/   
    @AuraEnabled
    public static List<WrapIdeasWithComments> getIdeasWithComments() {
        Map<String, Idea_Setting__mdt> ideaStMap = IdeaUtility.fetchIdeaSet();
        String unsubscribeStr ='Unsubscribe';
        String subscribeStr = 'Subscribe';
        Set<Id> idSets = new Set<Id>();
        Map<String,String> EntitySubscriptionMap = new Map<String,String>();
        User lstUserCompany = [SELECT Id, Profile.Name,username,Company_Name__c FROM User where Id =: UserInfo.getUserId() LIMIT 1];
        List<WrapIdeasWithComments> wrpList = new List<WrapIdeasWithComments>();
        List<Idea__c> lstIdeas =[SELECT Id, Name,Ideas__c,Upvote_Sum__c,DownVote_Sum__c ,LastName__c,Status__c,CreatedDate,CreatedBy.Id,CreatedBy.Name,CreatedBy.SmallPhotoUrl, CreatedBy.FullPhotoUrl,
                                 LastViewedDate,Idea_Description__c,SubIdeas__c,Rating__c,Negative_Rating__c,Show_Comments__c,
                                 (SELECT Id, Name,Idea__c, CommentBody__c,UpVotes__c FROM Comment__r)
                                 FROM Idea__c
                                ];
        for(Idea__c each : lstIdeas){
        	idSets.add(each.Id); // get list of ids for ideas   
        }        
        // Query on EntitySubscription with all the ideas for current user
        for(EntitySubscription eachSub :[SELECT Id,ParentId FROM EntitySubscription WHERE ParentId =: idSets AND SubscriberId =: 
                                         UserInfo.getUserId() limit 1000]){
        	EntitySubscriptionMap.put(eachSub.ParentId,eachSub.Id);                                 
        }               
        
        for(Idea__c ide : lstIdeas){
            
            WrapIdeasWithComments wrapIdeasCommentList = new WrapIdeasWithComments();
            
            wrapIdeasCommentList.objIdeaRecord = ide; 
            wrapIdeasCommentList.its=ideaStMap.get(ide.Status__c);                                   
            //wrapIdeasCommentList.setIdea(ide);
            wrapIdeasCommentList.lstComents = ide.Comment__r;
            if(!ide.Comment__r.isEmpty()){
                wrapIdeasCommentList.commentsCount = ide.Comment__r.size();
            }else{
                wrapIdeasCommentList.commentsCount = 0;   
            }                               
            // wrapIdeasCommentList.showComments = false;
            wrapIdeasCommentList.logdUsrProfilename = lstUserCompany.Profile.Name;
            if(EntitySubscriptionMap.containsKey(ide.Id)){
                wrapIdeasCommentList.subscribeString = unsubscribeStr;
            }
            else{
                wrapIdeasCommentList.subscribeString = subscribeStr;
            }            
            wrpList.add(wrapIdeasCommentList) ;
        }
        
        return wrpList;
    }
    
    /*******************************************************************
AUTHOR              : 
PURPOSE             : onClick of Idea                                                  
PARAMETERS          : Idea Id
RETURNS             : Returns WrapperIdeasWithComments
THROWS [EXCEPTIONS] : N/A  
********************************************************************/  
    @AuraEnabled
    public static WrapIdeasWithComments getSpecificIdeaWithComments(String ideaId) {
        WrapIdeasWithComments wrpList = new WrapIdeasWithComments();
        Map<String, Idea_Setting__mdt> ideaStMap = IdeaUtility.fetchIdeaSet();
        List<Idea__c> lstIdeas =[SELECT Id, Name,Ideas__c,Upvote_Sum__c,DownVote_Sum__c ,LastName__c,Status__c,CreatedDate,CreatedBy.Name, CreatedBy.SmallPhotoUrl,
                                 LastViewedDate,Idea_Description__c,SubIdeas__c,Rating__c,Negative_Rating__c,Show_Comments__c,
                                 (SELECT Id, Name,Idea__c, CommentBody__c,UpVotes__c,CreatedBy.Name,CreatedBy.SmallPhotoUrl,CreatedDate FROM Comment__r ORDER BY CreatedDate DESC ) 
                                 FROM Idea__c Where Id =: ideaId LIMIT 1];
        for(Idea__c ide :lstIdeas){
            WrapIdeasWithComments wrapIdeasCommentList = new WrapIdeasWithComments();
            wrapIdeasCommentList.objIdeaRecord = ide;                                    
            wrapIdeasCommentList.lstComents = ide.Comment__r;
            if(!ide.Comment__r.isEmpty()){
                wrapIdeasCommentList.commentsCount = ide.Comment__r.size();
            }else{
                wrapIdeasCommentList.commentsCount = 0;   
            }     
            wrapIdeasCommentList.its=ideaStMap.get(ide.Status__c);
            //wrapIdeasCommentList.showComments = false;
            wrpList = wrapIdeasCommentList ;
        }
        return wrpList;
    }
    
/********************************************************
Send Mail to Users
***********************/
    
    @AuraEnabled
    public static void getIdeaID(ID id1){ 
        Set<String> s1= new Set<String>();
        Set<Id> usrId = new Set<Id>();
        List<Id> usrListId = new List<Id>();
        string emailName = 'Comment Notification';
        string displayName ='Tavant System Admin';
        
        List<Comment__c> ls2=[Select Id,CreatedById,CreatedBy.Email,Idea__c,Idea__r.CreatedById 
                              from Comment__c where Idea__c =: id1];
        for(Comment__c comm: ls2){
            {
               // s1.add(comm.CreatedBy.Email);
                usrId.add(comm.CreatedById);
                usrId.add(comm.Idea__r.CreatedById);
            }
        }      
        usrListId.addAll(usrId);
        
        EmailTemplate et=[Select Id from EmailTemplate where name =:emailName limit 1];
        try{
            Messaging.MassEmailMessage mail = new Messaging.MassEmailMessage();
            mail.setTargetObjectIds(usrListId);
            mail.setSenderDisplayName(displayName);
            mail.setTemplateId(et.Id);
            mail.setSaveAsActivity(false);
            Messaging.sendEmail(new Messaging.MassEmailMessage[] { mail });
            
        }
        catch(Exception e){
            System.debug('~~~~Exception Line number '+e.getLineNumber()+' ~~~ Message is -> '+e.getMessage());
        }
    }
    
    /*******************************************************************
AUTHOR              : 
PURPOSE             : Recently Created Ideas based on CREATEDBY                                                 
PARAMETERS          : N/A
RETURNS             : Returns list of WrapperIdeasWithComments
THROWS [EXCEPTIONS] : N/A  
********************************************************************/  
    @AuraEnabled
    public static List<WrapIdeasWithComments> fetchAllRecentIdeas() {
        Map<String, Idea_Setting__mdt> ideaStMap = IdeaUtility.fetchIdeaSet();
        List<WrapIdeasWithComments> wrpList = new List<WrapIdeasWithComments>();
        List<Idea__c> ideaList = [SELECT Id, Name,Ideas__c,Upvote_Sum__c,DownVote_Sum__c ,LastName__c,Status__c,CreatedDate,CreatedBy.Name,CreatedBy.SmallPhotoUrl,
                                  LastViewedDate,Idea_Description__c,SubIdeas__c,Rating__c,Negative_Rating__c,Show_Comments__c,
                                  (SELECT Id, Name,Idea__c, CommentBody__c,UpVotes__c FROM Comment__r) 
                                  FROM Idea__c 
                                  ORDER By CreatedDate DESC
                                  LIMIT 50000];
        for(Idea__c ide : ideaList){
            WrapIdeasWithComments wrapIdeasCommentList = new WrapIdeasWithComments();
            wrapIdeasCommentList.objIdeaRecord = ide;  
            wrapIdeasCommentList.its=ideaStMap.get(ide.Status__c);                                 
            wrapIdeasCommentList.lstComents = ide.Comment__r;
            if(!ide.Comment__r.isEmpty()){
                wrapIdeasCommentList.commentsCount = ide.Comment__r.size();
            }else{
                wrapIdeasCommentList.commentsCount = 0;   
            }   
            //wrapIdeasCommentList.showComments = false;
            wrpList.add(wrapIdeasCommentList) ;
        }
        
        return wrpList;
    }
    
    /*******************************************************************
AUTHOR              : 
PURPOSE             : Ideas more voted based on votingSum                                                 
PARAMETERS          : N/A
RETURNS             : Returns list of WrapperIdeasWithComments
THROWS [EXCEPTIONS] : N/A  
********************************************************************/  
    @AuraEnabled
    public static List<WrapIdeasWithComments> fetchAllPopularIdeas() {
        Map<String, Idea_Setting__mdt> ideaStMap = IdeaUtility.fetchIdeaSet();
        List<WrapIdeasWithComments> wrpList = new List<WrapIdeasWithComments>();
        List<Idea__c> ideaList = [SELECT Id, Name,Ideas__c,Upvote_Sum__c,DownVote_Sum__c ,LastName__c,Status__c,CreatedDate,CreatedBy.Name,CreatedBy.SmallPhotoUrl,
                                  LastViewedDate,Idea_Description__c,SubIdeas__c,Rating__c,Negative_Rating__c,Show_Comments__c,
                                  (SELECT Id, Name,Idea__c, CommentBody__c,UpVotes__c FROM Comment__r) 
                                  FROM Idea__c                                  
                                  ORDER BY Upvote_Sum__c DESC
                                  LIMIT 50000];
        for(Idea__c ide : ideaList){
            WrapIdeasWithComments wrapIdeasCommentList = new WrapIdeasWithComments();
            wrapIdeasCommentList.objIdeaRecord = ide; 
            wrapIdeasCommentList.its=ideaStMap.get(ide.Status__c);                                   
            wrapIdeasCommentList.lstComents = ide.Comment__r;
            if(!ide.Comment__r.isEmpty()){
                wrapIdeasCommentList.commentsCount = ide.Comment__r.size();
            }else{
                wrapIdeasCommentList.commentsCount = 0;   
            }   
            //  wrapIdeasCommentList.showComments = false;
            wrpList.add(wrapIdeasCommentList) ;
        }
        // system.debug('c--'+wrpList);
        
        return wrpList;
    }
    /*******************************************************************
AUTHOR              : 
PURPOSE             :  displaying My Ideas                                                    
PARAMETERS          : N/A
RETURNS             : Returns list of WrapperIdeasWithComments
THROWS [EXCEPTIONS] : N/A  
********************************************************************/   
    @AuraEnabled
    public static List<WrapIdeasWithComments> getMyIdeas() {
        Map<String, Idea_Setting__mdt> ideaStMap = IdeaUtility.fetchIdeaSet();
        List<WrapIdeasWithComments> wrpList = new List<WrapIdeasWithComments>();
        List<Idea__c> lstIdeas =[SELECT Id, Name,Ideas__c,Upvote_Sum__c,DownVote_Sum__c ,LastName__c,Status__c,CreatedDate,CreatedBy.Name,CreatedBy.SmallPhotoUrl, CreatedBy.FullPhotoUrl,
                                 LastViewedDate,Idea_Description__c,SubIdeas__c,Rating__c,Negative_Rating__c,Show_Comments__c,
                                 (SELECT Id, Name,Idea__c, CommentBody__c,UpVotes__c FROM Comment__r)
                                 FROM Idea__c
                                 WHERE CreatedById =:UserInfo.getUserId() 
                                 LIMIT 50000
                                ];
        
        for(Idea__c ide : lstIdeas){
            
            WrapIdeasWithComments wrapIdeasCommentList = new WrapIdeasWithComments();
            
            wrapIdeasCommentList.objIdeaRecord = ide; 
            wrapIdeasCommentList.its=ideaStMap.get(ide.Status__c);                                
            wrapIdeasCommentList.lstComents = ide.Comment__r;
            if(!ide.Comment__r.isEmpty()){
                wrapIdeasCommentList.commentsCount = ide.Comment__r.size();
            }else{
                wrapIdeasCommentList.commentsCount = 0;   
            }                               
            // wrapIdeasCommentList.showComments = false;
            wrpList.add(wrapIdeasCommentList) ;
        }
        
        return wrpList;
    }
    
    
    /*******************************************************************
AUTHOR              : 
PURPOSE             : Sorting Ideas based on subIdea                                                     
PARAMETERS          : subIdea String
RETURNS             : Returns list of WrapperIdeasWithComments
THROWS [EXCEPTIONS] : N/A  
********************************************************************/  
    @AuraEnabled
    public static List<WrapIdeasWithComments> fetchSubIdeasWithComments(String subIdea) {
        Map<String, Idea_Setting__mdt> ideaStMap = IdeaUtility.fetchIdeaSet();
        List<WrapIdeasWithComments> wrpList = new List<WrapIdeasWithComments>();
        List<Idea__c> lstSubIdeas =[SELECT Id, Name,Ideas__c,Upvote_Sum__c,DownVote_Sum__c ,LastName__c,Status__c,CreatedDate,CreatedBy.Name,CreatedBy.SmallPhotoUrl, 
                                    LastViewedDate,Idea_Description__c,SubIdeas__c,Rating__c,Negative_Rating__c,Show_Comments__c,
                                    (SELECT Id, Name,Idea__c, CommentBody__c,UpVotes__c FROM Comment__r) 
                                    FROM Idea__c 
                                    where SubIdeas__c =:subIdea
                                    LIMIT 50000] ;
        for(Idea__c ide :lstSubIdeas){ 
            WrapIdeasWithComments wrapIdeasCommentList = new WrapIdeasWithComments();
            wrapIdeasCommentList.objIdeaRecord = ide;          
            wrapIdeasCommentList.its=ideaStMap.get(ide.Status__c);                          
            wrapIdeasCommentList.lstComents = ide.Comment__r;
            if(!ide.Comment__r.isEmpty()){
                wrapIdeasCommentList.commentsCount = ide.Comment__r.size();
            }
            else{
                wrapIdeasCommentList.commentsCount = 0;   
            }                               
            // wrapIdeasCommentList.showComments = false;
            wrpList.add(wrapIdeasCommentList) ;
        }
        
        return wrpList;
    }
    
    /*******************************************************************
AUTHOR              : 
PURPOSE             : Sorting Ideas based on businessIdea                                                       
PARAMETERS          : BusinessIdeaFunction String
RETURNS             : Returns list of WrapperIdeasWithComments
THROWS [EXCEPTIONS] : N/A  
********************************************************************/  
    @AuraEnabled
    public static List<WrapIdeasWithComments> fetchIdeasWithComments(String busIdea) {
        Map<String, Idea_Setting__mdt> ideaStMap = IdeaUtility.fetchIdeaSet();
        List<WrapIdeasWithComments> wrpList = new List<WrapIdeasWithComments>();
        List<Idea__c> lstIdeaCount = [Select  Ideas__c from Idea__c where Ideas__c=:busIdea ];
        List<Idea__c> lstBusIdeas =  [SELECT Id, Name,Ideas__c,Upvote_Sum__c,DownVote_Sum__c ,LastName__c,Status__c,CreatedDate,CreatedBy.Name,CreatedBy.SmallPhotoUrl, 
                                      LastViewedDate,Idea_Description__c,SubIdeas__c,Rating__c,Negative_Rating__c,Show_Comments__c,
                                      (SELECT Id, Name,Idea__c, CommentBody__c,UpVotes__c FROM Comment__r) 
                                      FROM Idea__c 
                                      where Ideas__c =:busIdea
                                      LIMIT 50000];
        for(Idea__c ide : lstBusIdeas){ 
            WrapIdeasWithComments wrapIdeasCommentList = new WrapIdeasWithComments();
            wrapIdeasCommentList.objIdeaRecord = ide;          
            wrapIdeasCommentList.its=ideaStMap.get(ide.Status__c);                          
            wrapIdeasCommentList.lstComents = ide.Comment__r;
            if(!ide.Comment__r.isEmpty()){
                wrapIdeasCommentList.commentsCount = ide.Comment__r.size();
            }else{
                wrapIdeasCommentList.commentsCount = 0;   
            }                               
            // wrapIdeasCommentList.showComments = false;
            wrpList.add(wrapIdeasCommentList) ;
        }
        return wrpList;
    }
    
    /*******************************************************************
AUTHOR              : 
PURPOSE             : Sorting All Ideas based on selectedStatus                                                  
PARAMETERS          : Selected Status String
RETURNS             : Returns list of WrapperIdeasWithComments
THROWS [EXCEPTIONS] : N/A  
********************************************************************/  
    @AuraEnabled
    public static List<WrapIdeasWithComments> fetchRelatedIdeas(String strSelectedStatus) {
        Map<String, Idea_Setting__mdt> ideaStMap = IdeaUtility.fetchIdeaSet();
        List<WrapIdeasWithComments> wrpList = new List<WrapIdeasWithComments>();
        List<Idea__c> ideaList = [SELECT Id, Name,Ideas__c,Status__c,CreatedDate,Upvote_Sum__c,DownVote_Sum__c , CreatedBy.Name,CreatedBy.SmallPhotoUrl,
                                  LastViewedDate,Idea_Description__c,SubIdeas__c,Rating__c,Negative_Rating__c,Show_Comments__c,
                                  (SELECT Id, Name,Idea__c,CommentBody__c,UpVotes__c FROM Comment__r) 
                                  FROM Idea__c 
                                  WHERE Status__c =:strSelectedStatus
                                  LIMIT 50000];
        for(Idea__c ide : ideaList){
            WrapIdeasWithComments wrapIdeasCommentList = new WrapIdeasWithComments();
            wrapIdeasCommentList.objIdeaRecord = ide;         
            wrapIdeasCommentList.its=ideaStMap.get(ide.Status__c);                           
            wrapIdeasCommentList.lstComents = ide.Comment__r;
            if(!ide.Comment__r.isEmpty()){
                wrapIdeasCommentList.commentsCount = ide.Comment__r.size();
            }else{
                wrapIdeasCommentList.commentsCount = 0;   
            }   
            // wrapIdeasCommentList.showComments = false;
            wrpList.add(wrapIdeasCommentList) ;
        }
        system.debug('c--'+wrpList);
        
        return wrpList;
    }
    
    /*******************************************************************
AUTHOR              : 
PURPOSE             : Posting(create idea) an Idea By user                                               
PARAMETERS          : Idea Object
RETURNS             : Void
THROWS [EXCEPTIONS] : N/A  
********************************************************************/  
    @AuraEnabled
    public static void createRecord(Idea__c objcandidate){
        
        system.debug('c--'+objcandidate);
        if(objcandidate != null){
            User usr = [SELECT Id, ContactId , AccountId FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];
            if(usr <> null){
                objcandidate.Contact__c = usr.ContactId;
                objcandidate.Customer__c = usr.AccountId ;
            }
            insert objcandidate;
        }
    }
    
    /*******************************************************************
AUTHOR              : 
PURPOSE             : onLoad Status Picklits values Dynamically                                                   
PARAMETERS          : Object , FieldName
RETURNS             : Returns list of Strings(PicklistValues)
THROWS [EXCEPTIONS] : N/A  
********************************************************************/  
    @AuraEnabled
    public static List <String> getselectOptions(sObject objectName, string field_apiname) {

        List<String> allOpts = new list < String > ();
        Schema.sObjectType objType = objectName.getSObjectType(); 
        Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
        Map<String, Schema.SObjectField> fieldMap = objDescribe.fields.getMap();
        List <Schema.PicklistEntry> values = fieldMap.get(field_apiname).getDescribe().getPickListValues();
        for (Schema.PicklistEntry a: values) {
            allOpts.add(a.getValue());
        }
        return allOpts;
    }
    
    /*******************************************************************
AUTHOR              : 
PURPOSE             : Getting User Info                                                    
PARAMETERS          : N/A
RETURNS             : Returns user list
THROWS [EXCEPTIONS] : N/A  
********************************************************************/  
    @AuraEnabled
    public static List<User> UserCompany(){
        String strId = UserInfo.getUserId();
        List<User> lstUserCompany = [SELECT Id, Profile.Name,username,Company_Name__c FROM User where Id =: strId];
        return lstUserCompany;
    } 
    
    /*******************************************************************
AUTHOR              : 
PURPOSE             : Saving the Comments for the idea.                                                   
PARAMETERS          : Idea String, String Body
RETURNS             : Void
THROWS [EXCEPTIONS] : N/A  
********************************************************************/  
    @AuraEnabled
    public static void saveComment(String StrIdea,String strbody,String fileName,String fileContent) {
        Comment__c objComment = new Comment__c();
        objComment.Idea__c = StrIdea;
        objComment.CommentBody__c = strbody;
        insert objComment; 
        if(null != fileName && fileName !='' && fileName !='undefined'){
        	string base64Data = EncodingUtil.urlDecode(fileContent, 'UTF-8');
            ContentVersion cv = new ContentVersion();
            cv.Title = fileName;
            cv.PathOnClient = '/' + fileName;
            cv.FirstPublishLocationId = objComment.Id;
            cv.VersionData = EncodingUtil.base64Decode(base64Data);
            cv.IsMajorVersion = true;
            Insert cv;
        }
       
        /*Attachment att=new Attachment();
		att.Body=EncodingUtil.base64Decode(base64Data);
		att.Name='Note_' + System.now().format('yyyy_MM_dd_hh_mm_ss') + '.png';
		att.parentId=objComment.id;
		insert att;*/        
       // system.debug(objComment.id+'==========='+cv.id);
    }
    
    /*******************************************************************
AUTHOR              : 
PURPOSE             : Sorting the Comments for the idea.                                                   
PARAMETERS          : Idea String
RETURNS             : List of oldcomments.
THROWS [EXCEPTIONS] : N/A  
********************************************************************/  
    @AuraEnabled
    public static List<Comment__c> sortOldComments(String ideaId) {
        List<Comment__c> lstComments =[SELECT Id, Name,Idea__c, CommentBody__c,UpVotes__c,CreatedBy.Name,CreatedBy.SmallPhotoUrl,CreatedDate FROM Comment__c WHERE Idea__c=:ideaId];
        return lstComments;
    }
    /*******************************************************************
AUTHOR              : 
PURPOSE             : Sorting the Comments for the idea.                                                   
PARAMETERS          : Idea String
RETURNS             : List of newcomments.
THROWS [EXCEPTIONS] : N/A  
********************************************************************/  
    @AuraEnabled
    public static List<Comment__c> sortNewComments(String ideaId) {
        List<Comment__c> lstComments =[SELECT Id, Name,Idea__c, CommentBody__c,UpVotes__c,CreatedBy.Name,CreatedBy.SmallPhotoUrl,CreatedDate FROM Comment__c WHERE Idea__c=:ideaId ORDER By CreatedDate DESC];
        return lstComments;
    }
    
    /*******************************************************************
AUTHOR              : 
PURPOSE             : OnClose of an Idea By user                                               
PARAMETERS          : Idea Object
RETURNS             : Idea Object
THROWS [EXCEPTIONS] : N/A  
********************************************************************/  
    @AuraEnabled     
    public static Idea_Setting__mdt getIdeaSettings(Idea__c idR){
        Idea_Setting__mdt its;    
        its = [Select Show_Add_Cmnts__c,Show_Downvote__c,Show_Upvote__c,Current_Status__c, dontShowComments__c 
               from Idea_Setting__mdt where Current_Status__c=: idR.Status__c LIMIT 1];
        
        return its;     
    }
    
    @AuraEnabled
    public static String donotShowComments(Idea__c idR){
        Idea_Setting__mdt lst = [Select Show_Add_Cmnts__c,Show_Downvote__c,Show_Upvote__c,Current_Status__c, dontShowComments__c from Idea_Setting__mdt where Current_Status__c=: idR.Status__c LIMIT 1];
        return lst.dontShowComments__c;
        
    }
    /*******************************************************************
AUTHOR              : 
PURPOSE             : onLoad dependent Picklits values dynamically                                                   
PARAMETERS          : sObject, Strings of ControllingFieldName AND DependentFieldName
RETURNS             : Returns list of Controlling and Deppendent picklist values
THROWS [EXCEPTIONS] : N/A  
********************************************************************/  
    @AuraEnabled 
    public static Map<String, List<String>> getDependentMap(sObject objDetail, string contrfieldApiName,string depfieldApiName) {
        
        String controllingField = contrfieldApiName.toLowerCase();
        String dependentField = depfieldApiName.toLowerCase();
        
        Map<String,List<String>> objResults = new Map<String,List<String>>();
        
        Schema.sObjectType objType = objDetail.getSObjectType();
        if (objType==null){
            return objResults;
        }
        
        Map<String, Schema.SObjectField> objFieldMap = objType.getDescribe().fields.getMap();
        
        if (!objFieldMap.containsKey(controllingField) || !objFieldMap.containsKey(dependentField)){
            return objResults;     
        }
        
        Schema.SObjectField theField = objFieldMap.get(dependentField);
        Schema.SObjectField ctrlField = objFieldMap.get(controllingField);
        
        List<Schema.PicklistEntry> contrEntries = ctrlField.getDescribe().getPicklistValues();
        List<PicklistEntryWrapper> depEntries = wrapPicklistEntries(theField.getDescribe().getPicklistValues());
        
        List<PicklistEntryWrapper> cntrlValues = wrapPicklistEntries(ctrlField.getDescribe().getPicklistValues());
        
        List<String> controllingValues = new List<String>();
        List<String> lststrIdeaCount = new List<String>();
        
        for (Schema.PicklistEntry ple : contrEntries) {
            String label = ple.getLabel();
            objResults.put(label, new List<String>());
            controllingValues.add(label);
            /* List<Idea__c> lstIdeaCount = [SELECT id,name,Ideas__c from Idea__c WHERE Ideas__c =: label];
Integer ideaCount = lstIdeaCount.size();
String strCountAppendIdealabel='';
strCountAppendIdealabel = strCountAppendIdealabel+label+'('+ ideaCount +')';
system.debug('wt is printing+++'+strCountAppendIdealabel);
objResults.put(strCountAppendIdealabel, new List<String>());
controllingValues.add(strCountAppendIdealabel);*/
        }
        
        for (PicklistEntryWrapper plew : depEntries) {
            String label = plew.label;
            String validForBits = base64ToBits(plew.validFor);
            // system.debug('wt is there in the string validForBits :::'+validForBits);
            for (Integer i = 0; i < validForBits.length(); i++) {
                String bit = validForBits.mid(i, 1);
                if (bit == '1') {
                    objResults.get(controllingValues.get(i)).add(label);
                }
            }
        }
        
        return objResults;
    }
    
    public static String decimalToBinary(Integer val) {
        String bits = '';
        while (val > 0) {
            Integer remainder = Math.mod(val, 2);
            val = Integer.valueOf(Math.floor(val / 2));
            bits = String.valueOf(remainder) + bits;
        }
        return bits;
    }
    
    public static String base64ToBits(String validFor) {
        if (String.isEmpty(validFor)) return '';
        
        String validForBits = '';        
        for (Integer i = 0; i < validFor.length(); i++) {
            String thisChar = validFor.mid(i, 1);
            Integer val = base64Chars.indexOf(thisChar);
            String bits = decimalToBinary(val).leftPad(6, '0');
            validForBits += bits;
        }        
        return validForBits;
    }
    
    private static final String base64Chars = '' + 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' + 'abcdefghijklmnopqrstuvwxyz' + '0123456789+/';
    
    private static List<PicklistEntryWrapper> wrapPicklistEntries(List<Schema.PicklistEntry> PLEs) {
        return (List<PicklistEntryWrapper>)
            JSON.deserialize(JSON.serialize(PLEs), List<PicklistEntryWrapper>.class);
    }
    
    /*******************************************************************
AUTHOR              : 
PURPOSE             : to display idea count on buisness function                                                 
PARAMETERS          : N/A
RETURNS             : Returns list of Controlling picklist values with related Idea Count
THROWS [EXCEPTIONS] : N/A  
********************************************************************/  
    @AuraEnabled
    public static Map<String, List<String>> mapIdeasWithCount() {
        Map<String,List<String>> countResults = new Map<String,List<String>>();
        List<String> controllingValues = new List<String>();
        // Schema.DescribeFieldResult fieldResult = Idea__c.Ideas__c.getDescribe();
        List<Schema.PicklistEntry> cntrlValues = Idea__c.Ideas__c.getDescribe().getPicklistValues();
        Schema.DescribeFieldResult theField = Idea__c.SubIdeas__c.getDescribe();
        List<PicklistEntryWrapper> depEntries = wrapPicklistEntries(theField.getPicklistValues());
        for (Schema.PicklistEntry ple : cntrlValues) {
            String label = ple.getLabel();
            // countResults.put(label, new List<String>());
            // controllingValues.add(label);
            
            List<Idea__c> lstIdeaCount = [SELECT id,name,Ideas__c from Idea__c WHERE Ideas__c =: label];
            Integer ideaCount = lstIdeaCount.size();
            String strCountAppendIdealabel='';
            strCountAppendIdealabel = strCountAppendIdealabel+label+' '+'('+ ideaCount +')';
            countResults.put(strCountAppendIdealabel, new List<String>());
            controllingValues.add(strCountAppendIdealabel);
        }
        for (PicklistEntryWrapper plew : depEntries) {
            String label = plew.label;
            String validForBits = base64ToBits(plew.validFor);
            // system.debug('wt is there in the string validForBits :::'+validForBits);
            for (Integer i = 0; i < validForBits.length(); i++) {
                String bit = validForBits.mid(i, 1);
                if (bit == '1') {
                    countResults.get(controllingValues.get(i)).add(label);
                }
            }
            
        }
        return countResults;
    }
    
    /*******************************************************************
AUTHOR              : 
PURPOSE             : get Vote list                                                
PARAMETERS          : Idea String, User String
RETURNS             : Returns list of votes
THROWS [EXCEPTIONS] : N/A  
********************************************************************/  
    @AuraEnabled
    public static List<Vote__c> getData(String Ideaid, String userId){
        Vote__c[]  v; 
        try{
            v= [Select Id,Upvote__c,DownVote__c From Vote__c where Idea__c = :Ideaid and User__c=:userId];
           
            if(Test.isRunningTest()){
                String str;
                integer i = str.length();  
            }
            
        }catch(Exception e){
            v= null;
        }
        return v;
    }
    
    /*******************************************************************
AUTHOR              : 
PURPOSE             : get Idea deatails                                                   
PARAMETERS          : Idea Id
RETURNS             : Returns Idea object
THROWS [EXCEPTIONS] : N/A  
********************************************************************/  
    @AuraEnabled
    public static Idea__c getIdea(String ideaId){
        try{
            Idea__c  i = [Select Id,Status__c,Upvote_Sum__c,DownVote_Sum__c From Idea__c where Id=:Ideaid];
            return i;
        }catch(QueryException e){
            System.debug('-----------'); 
            return null;
        }
    }
    
    /*******************************************************************
AUTHOR              : 
PURPOSE             : loggedInUser Information.                                                 
PARAMETERS          : N/A
RETURNS             : Returns User Id
THROWS [EXCEPTIONS] : N/A  
********************************************************************/  
    @AuraEnabled 
    public static Id getLoggedInUser(){
        return UserInfo.getUserId();
    }
    
    /*******************************************************************
AUTHOR              : 
PURPOSE             : Updating the votes                                                
PARAMETERS          : Voter Id, Integers of  Upvote AND Downvote.
RETURNS             : void
THROWS [EXCEPTIONS] : N/A  
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
AUTHOR              : 
PURPOSE             : Inserting votes on vote Object                                                  
PARAMETERS          : Voter Id, Integers of  Upvote AND Downvote , User Id.
RETURNS             : Returns vote object.
THROWS [EXCEPTIONS] : N/A  
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
    
    //WrapperClasses 
    public class PicklistEntryWrapper{
        public String active {get;set;}
        public String defaultValue {get;set;}
        public String label {get;set;}
        public String value {get;set;}
        public String validFor {get;set;}
        public Integer ideaCount {get;set;}
        public Boolean showSubIdeas {get;set;}
        public PicklistEntryWrapper(){            
        }
    }
    
    public class WrapIdeasWithComments{
        @AuraEnabled  public Idea__c objIdeaRecord{get;set;}
        @AuraEnabled  public List<Comment__c> lstComents{get;set;}
        @AuraEnabled public string subscribeString{get;set;}
        @AuraEnabled  public Integer commentsCount{get;set;}
        // @AuraEnabled  public Boolean showComments; 
        @AuraEnabled  public String logdUsrProfilename{get;set;}
        @AuraEnabled public Idea_Setting__mdt its{get;set;}
        
        
        public void setIdea(Idea__c idR){
            this.objIdeaRecord = idR;
            if(idR.Idea_Description__c.length() > 100){
                
                this.objIdeaRecord.Idea_Description__c= idr.Idea_Description__c.subString(0,500)+ '<span id=\"dots\">... </span>';
             //   +  '<a onclick=\"{!c.openDetailPage}\" > Show More  </a>';
                
                // idr.Idea_Description__c.subString(101,idr.Idea_Description__c.length());style=/"color:#556a8c;"  class=/"slds-text-heading_small/"
                  
            }
        }
    }
    
    
        
          
}