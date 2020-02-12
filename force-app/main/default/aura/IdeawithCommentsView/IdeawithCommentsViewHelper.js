({
    // called from onload function to get the selected idea
    getSelectedIdea: function(cmp, event, helper,ideId){
        var action = cmp.get('c.getSpecificIdeaWithComments');
        action.setParams({
            'ideaId' : ideId
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                var result = response.getReturnValue();
                cmp.set('v.wrapIdea',response.getReturnValue());
                //alert('Test::'+JSON.stringify(result));
                cmp.set('v.displayView',true);
                console.log(result.its.New_Status_Alwd__c , 'res');
                if(result.its.Show_Add_Cmnts__c){
                    cmp.set("v.isShowRichText", true);
                }
                else{
                    cmp.set("v.isShowRichText", false);
                }
                if(result.its.Show_Downvote__c){
                    console.log(result.its.Show_Downvote__c , 'button status res' ,result.its.New_Status_Alwd__c , 'allowed status res');
                    
                    cmp.set("v.disableButtons", false);
                }
                else{
                    cmp.set("v.disableButtons", true);
                }
                
                if(result.its.Show_Upvote__c){
                    console.log(result.its.Show_Upvote__c , 'button status res' ,result.its.New_Status_Alwd__c , 'allowed status res');
                    
                    cmp.set("v.disableButtons", false);
                }
                else{
                    cmp.set("v.disableButtons", true);
                }
                
            }
        });
        $A.enqueueAction(action);
    },
    
    // get the comments in decending order
    sortOldComments: function(component, event, helper){
        console.log('call the sort old comments');
        var ideaI= component.get('v.IdeaId');
        console.log('call the sort new comments for this Idea Id&&&&&&',ideaI);
        var action = component.get("c.sortOldComments");
        action.setParams({
            'ideaId' : ideaI
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                var result = response.getReturnValue();
                console.log('response',result);
                component.set('v.lstComments',result);
                //component.set('v.displayView',true);
                component.set('v.ShowSortedOldComments',true);
                component.set('v.ShowSortedNewComments',false); 
            }
        });
        $A.enqueueAction(action);
    },
    // the the latest comments first
    sortNewComments: function(component, event, helper){
        console.log('call the sort new comments');
        var ideaI= component.get('v.IdeaId');
        var action = component.get("c.sortNewComments");
        action.setParams({
            'ideaId' : ideaI
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                console.log('response state',state);
                var result = response.getReturnValue();
                console.log('call the sort new comments for this Idea Id&&&&&&',ideaI);
                component.set('v.lstComments',result);
                // component.set('v.displayView',true);
                component.set('v.ShowSortedOldComments',false);
                component.set('v.ShowSortedNewComments',true);
            }
        });
        $A.enqueueAction(action);
    },
    // get the logged in user data 
    bringLoggedInUserData : function(component, event, helper) {
        var action = component.get('c.getLoggedInUser'); 
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                if(response.getReturnValue()){
                    //console.log('current logged in user::;',response.getReturnValue());
                    component.set('v.loggedInUser',response.getReturnValue())
                    helper.bringVoteData(component, event, helper,response.getReturnValue());
                }
            } 
        });
        $A.enqueueAction(action);
    },
    // get the voting details of an idea from vote object
    bringVoteData:function(component,event,helper,userId) {
        var ideaData = component.get('v.wrapIdea');
        var ideaId = ideaData.objIdeaRecord.Id;
        //console.log('ideaId:::',ideaData.objIdeaRecord.Id);
        /*if(!component.get('v.ideaId')){
            return false;
        }*/
        var action = component.get('c.getData'); 
        var params = {
            "Ideaid":ideaId,
            "userId":userId
        }
        action.setParams(params)
        action.setCallback(this, function (rep) {
            var state = rep.getState();
            if (state === "SUCCESS") {
                var voteRecord = rep.getReturnValue();
                // console.log('voteRecord::::',voteRecord);
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
                }
            } 
        });
        $A.enqueueAction(action);
    },
    voteHelper : function(component, event, helper,upvote,downvote) {
        var voteData = component.get('v.voteReocrd');
        if(voteData && voteData.Id){
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
        var ideaData = component.get('v.wrapIdea');
        var ideaId = ideaData.objIdeaRecord.Id;
        //   console.log('ideaId:::',ideaData.objIdeaRecord.Id);   
        //   console.log('loggedinuser::',component.get('v.loggedInUser'));    
        var action = component.get('c.insertVote'); 
        var params = {
            "ideaId":ideaId,
            "upvote":upvote,
            "downvote":downvote,
            "userId":component.get('v.loggedInUser')
        }
        action.setParams(params)
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var record = response.getReturnValue();
                //console.log('response:::',record);
                component.set('v.voteReocrd',record)
                var value;
                if(upvote == 0 && downvote == 0){
                    component.set('v.showUpvote',true) 
                    component.set('v.showDownvote',true)
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
                //var downvoteFocus = component.find('downvote');
                //$A.util.addClass(downvoteFocus, 'downvoted');
                component.set('v.showUpvote',false) 
                component.set('v.showDownvote',false)
                component.set('v.isDownvoted',true)
                break;
            }
            case 1:{
                
                //var upvoteFocus = component.find('upvote'); 
                // $A.util.addClass(upvoteFocus, 'upvoted');
                component.set('v.showUpvote',false) 
                component.set('v.showDownvote',false)
                component.set('v.isUpvoted',true)
                
                break;
            }
        }
    },
    
    fetchIdeaRecord:function(component, event, helper){
        var ideaData = component.get('v.wrapIdea');
        var ideaId = ideaData.objIdeaRecord.Id;
        //console.log('ideaId:::',ideaData.objIdeaRecord.Id);
        var action = component.get('c.getIdea');
        var record1 = ideaData.objIdeaRecord;
        //  console.log('record1',record1)
        var params = {
            "ideaId":ideaId,
        }
        action.setParams(params)
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var record = response.getReturnValue();
                //  console.log('record',record);
                component.set('v.wrapIdea.objIdeaRecord.Id',record.Id); 
                component.set('v.wrapIdea.objIdeaRecord.Upvote_Sum__c',record.Upvote_Sum__c); 
                component.set('v.wrapIdea.objIdeaRecord.DownVote_Sum__c',record.DownVote_Sum__c); 
                
                // component.set('v.wrapIdea.objIdeaRecord',record);
            } 
        });
        $A.enqueueAction(action);
    }
    
})