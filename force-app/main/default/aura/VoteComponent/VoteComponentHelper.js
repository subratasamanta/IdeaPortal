({
	/*
    bringLoggedInUserData : function(component, event, helper) {
        var action = component.get('c.getLoggedInUser'); 
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                if(response.getReturnValue()){
                    component.set('v.loggedInUser',response.getReturnValue())
                 
                    helper.bringVoteData(component, event, helper,response.getReturnValue());
                    
                }
            } 
        });
        $A.enqueueAction(action);
    },
    */
    
     bringLoggedInUserData : function(component, event, helper) {
     	var userI = component.set('v.loggedInUser');
     	if(userI == null || userI ==''){
            var userId = $A.get("$SObjectType.CurrentUser.Id");
            component.set('v.loggedInUser',userId);
        }
        helper.bringVoteData(component, event, helper, component.get('v.loggedInUser'));
     },
    
    bringVoteData:function(component,event,helper,userId) {
        if(!component.get('v.ideaRecordId')){
            return false;
        }
        var action = component.get('c.getData'); 
        var params = {
            "Ideaid": component.get('v.ideaRecordId'),
            "userId":userId
        }
        action.setParams(params)
        action.setCallback(this, function (rep) {
            var state = rep.getState();
            //component.set('v.isLoaded',true);
            if (state === "SUCCESS") {               
                var voteRecord = rep.getReturnValue().idea;
                if(voteRecord && voteRecord.length>0 ){
                    var value;
                    if(voteRecord[0].Upvote__c == 0 && voteRecord[0].DownVote__c == 0){
                    }else if(voteRecord[0].Upvote__c == 1 && voteRecord[0].DownVote__c == 0){
                        value = 1;
                        helper.swithValues(component,value);
                    }else if(voteRecord[0].Upvote__c == 0 && voteRecord[0].DownVote__c == 1){
                        value = 0;
                        helper.swithValues(component,value);
                    }
                    component.set('v.voteReocrd',voteRecord[0]);
                    // disabling the buttons for some picklist values
                    
                }
                var upvoted = rep.getReturnValue().upvoted;
                var downvoted = rep.getReturnValue().downvoted;
                var its = component.get('v.ideaSet');
                    //console.log(component.get("v.ideaRecord.Name")+ 'AND Checking Vote buttons 1' + JSON.stringify(its));
                   // console.log('Checking Vote buttons' + its.Current_Status__c);

                    if(downvoted){
                    	//console.log(its.Show_Downvote__c ,'button status res',  its.New_Status_Alwd__c ,'AND allowed status res');
                    	component.set("v.disableButtons", false);
                    }
                    else{
                        
                        component.set("v.disableButtons", "true");
                       // console.log(component.get("v.ideaRecord.Name"), 'false');
                    }
                    if(upvoted){
                        //console.log(its.Show_Upvote__c , 'button status res' ,its.New_Status_Alwd__c , 'allowed status res');
                        component.set("v.disableButtons", false);
                    }
                    else{
                        component.set("v.disableButtons", "true");
                    }
                 
                    console.log('disable buttons' + component.get("v.disableButtons"));
            } ;
        });
        $A.enqueueAction(action);
    },
    voteHelper : function(component, event, helper,upvote,downvote) {
        debugger;
        var voteData = component.get('v.voteReocrd');
        if(voteData && voteData.Id && component.get('v.isWithdrawnVote') == false){
            helper.updateVote(component, event, helper,upvote,downvote,voteData.Id);
        }else{
            helper.insertVote(component, event, helper,upvote,downvote,null);
        }
        
    },
    updateVote : function(component, event, helper,upvote,downvote,voteId) {
        var action = component.get('c.updateVote');
        var params = {
            "voteId":voteId,
            "upvote":upvote,
            "downvote":downvote
        }
        action.setParams(params)
        action.setCallback(this,function (rep) {
            var state = rep.getState();
            if(state === "SUCCESS") {
                var value;
                if(upvote == 0 && downvote == 0){
                    
                }else if(upvote == 1 && downvote == 0){
                    value = 1;
                    helper.swithValues(component,value);
                }else if(upvote == 0 && downvote == 1){
                    value = 0;
                    helper.swithValues(component,value);
                }
                helper.fetchIdeaRecord(component, event, helper);
            } 
        });
        $A.enqueueAction(action);
    },
    insertVote:function(component, event, helper,upvote,downvote,voteId) {
        debugger;
        var action = component.get('c.insertVote'); 
        var params = {
            "ideaId":component.get('v.ideaRecordId'),
            "upvote":upvote,
            "downvote":downvote,
            "userId":component.get('v.loggedInUser')
        }
        action.setParams(params)
        action.setCallback(this, function (rep) {
            var state = rep.getState();
            if (state === "SUCCESS") {
                var record = rep.getReturnValue();
                component.set('v.voteReocrd',record)
                var value;
                if(upvote == 0 && downvote == 0){
                }else if(upvote == 1 && downvote == 0){
                    value = 1;
                    helper.swithValues(component,value);
                }else if(upvote == 0 && downvote == 1){
                    value = 0;
                    helper.swithValues(component,value);
                }
                helper.fetchIdeaRecord(component, event, helper);
            } 
        });
        $A.enqueueAction(action);
    },
    swithValues : function(component,value){
        switch(value){
            case 0: {
                component.set('v.showUpvote',false) 
                component.set('v.showDownvote',false)
                component.set('v.isDownvoted',true) 
                // component.set('v.downvoteStyle','downvote-red')
                // component.set('v.upvoteStyle','') 
                break;
            }
            case 1:{
                component.set('v.showUpvote',false) 
                component.set('v.showDownvote',false)
                component.set('v.isUpvoted',true) 
                // component.set('v.upvoteStyle','upvote-green') 
                // component.set('v.downvoteStyle','');
                break;
            }
        }
        
    },
    fetchIdeaRecord:function(component, event, helper){
        debugger;
        var action = component.get('c.getIdea');
        var record1 = JSON.parse(JSON.stringify(component.get('v.ideaRecord')));
        console.log('record1',record1);
        var params = {
            "ideaId":component.get('v.ideaRecordId')
        };
        action.setParams(params);
        action.setCallback(this, function (rep) {
            var state = rep.getState();
            if (state === "SUCCESS") {
                var record = rep.getReturnValue();
                component.set('v.ideaRecord.Id',record.Id); 
                component.set('v.ideaRecord.Upvote_Sum__c',record.Upvote_Sum__c); 
                component.set('v.ideaRecord.DownVote_Sum__c',record.DownVote_Sum__c); 
                console.log('record',record);
                // component.set('v.ideaRecord',record);
            } 
        });
        $A.enqueueAction(action);
    },
    withdrawVote:function(component, event, helper,votedDataId){
       var action = component.get('c.deleteWithDrawnVote'); 
        var params = {
            "votedDataId":votedDataId
        };
        action.setParams(params);
        action.setCallback(this, function (rep) {
            var state = rep.getState();
            if (state === "SUCCESS") {
            	helper.fetchIdeaRecord(component, event, helper);    
            } 
        });
        $A.enqueueAction(action);
    }
})