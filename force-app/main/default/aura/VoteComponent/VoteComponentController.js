({
    doInit : function(component, event, helper) {
       // console.log('its' + component.get("v.ideaSet").Show_Upvote__c);
        helper.bringLoggedInUserData(component, event, helper);
        
    },
    upvote : function(component, event, helper) {
        helper.voteHelper(component, event, helper,1,0);
        
    },
    downvote:function(component, event, helper) {
        helper.voteHelper(component, event, helper,0,1);
        
    },
    greenButtonClicked:function(component, event, helper) {
        component.set('v.isWithdrawnVote',true);
        var voteData = component.get('v.voteReocrd');
        var votedDataId = voteData.Id;
        component.get('v.voteReocrd',null)
        component.set('v.showUpvote',true);
        component.set('v.disableButtons',false);
        component.set('v.showDownvote',true);
        component.set('v.isUpvoted',false);
        component.set('v.isDownvoted',false);
        helper.withdrawVote(component, event, helper,votedDataId);
    },
    redButtonClicked:function(component, event, helper) {
        component.set('v.isWithdrawnVote',true);
        var voteData = component.get('v.voteReocrd');
        var votedDataId = voteData.Id;
        component.get('v.voteReocrd',null)
        component.set('v.showUpvote',true);
        component.set('v.disableButtons',false);
        component.set('v.showDownvote',true);
        component.set('v.isUpvoted',false);
        component.set('v.isDownvoted',false);
        helper.withdrawVote(component, event, helper,votedDataId);
    }
    
})