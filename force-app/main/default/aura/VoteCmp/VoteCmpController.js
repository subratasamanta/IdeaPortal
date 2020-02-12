({
	doInit : function(component, event, helper) {
		helper.bringLoggedInUserData(component, event, helper);
        
	},
    upvote : function(component, event, helper) {
        helper.voteHelper(component, event, helper,1,0);
    },
    downvote:function(component, event, helper) {
        helper.voteHelper(component, event, helper,0,1);
    },
  
})