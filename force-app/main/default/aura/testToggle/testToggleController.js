({
    doInit : function (cmp, event, helper) {
        var action = cmp.get('c.getId');
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                cmp.set('v.usrId',response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },
    
    onUpVote : function (cmp, event, helper) {
        var upVoteButtonState = cmp.get('v.upVoteButtonState');
        var downVoteButtonState = cmp.get('v.downVoteButtonState');
        //alert(upVoteButtonState +' '+ downVoteButtonState);
        if(upVoteButtonState == false && downVoteButtonState == false){
            var increaseVote = true;
            helper.getVoteCount(cmp,event,increaseVote);
            cmp.set('v.upVoteCount', '1');
        }
        else if(upVoteButtonState == true && downVoteButtonState == false){
            cmp.set('v.upVoteCount', '0');
        }
        cmp.set('v.upVoteButtonState', !upVoteButtonState);
    },
    
    onDownVote : function (cmp, event, helper) {
        var upVoteButtonState = cmp.get('v.upVoteButtonState');
        var downVoteButtonState = cmp.get('v.downVoteButtonState');
        //alert(upVoteButtonState +' '+ downVoteButtonState);
        if(upVoteButtonState == false && downVoteButtonState == false){
            cmp.set('v.downVoteCount', '1');
        }
        else if(upVoteButtonState == false && downVoteButtonState == true){
            cmp.set('v.downVoteCount', '0');
        }
        cmp.set('v.downVoteButtonState', !downVoteButtonState);
    },
});