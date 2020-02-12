({
    // onload method to show the comment section with currently selected idea
    doInit : function(component, event, helper) {
        var ideaIdVar ='';
        var modeVar ='';
        var sPageURL = decodeURIComponent(window.location.search.substring(1)); //You get the whole decoded URL of the page.
        var sURLVariables = sPageURL.split('&'); //Split by & so that you get the key value pairs separately in a list
        var sParameterName;
        var i;
        console.log('sURLVariables::'+sURLVariables);
        if(sURLVariables.length>0){
            for (i = 0; i < sURLVariables.length; i++) {
                sParameterName = sURLVariables[i].split('='); //to split the key from the value.
                if (sParameterName[0] === 'IdeaId') { //lets say you are looking for param name - firstName
                    sParameterName[1] === undefined ? 'Not found' : sParameterName[1];
                    ideaIdVar = sParameterName[1];
                }
            }  
        }
        
        if(component.get("v.isCommunity")){ 
            helper.getSelectedIdea(component, event, helper,sParameterName[1]);
        }else{
            helper.getSelectedIdea(component, event, helper,component.get("v.IdeaId"));
        }
        component.set('v.IdeaId', sParameterName[1]);
        var url = $A.get('$Resource.backgroundIdea');
        component.set('v.backgroundImageURL', url);
        helper.bringLoggedInUserData(component, event, helper);
        console.log('sorting Comments' + sParameterName[1]);
        helper.sortNewComments(component, event, helper);
    },
    
    // function automatic called by aura:waiting event  
    showSpinner: function(component, event, helper) {
        component.set("v.onloadSpinner", true);
    },
    
    // function automatic called by aura:doneWaiting event 
    hideSpinner : function(component,event,helper){
        component.set("v.onloadSpinner", false);
    },
    // for redirecting back to all ideas
    redirectToAllIdeas: function(cmp, event, helper,ideId){
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": '/idea'
        });
        urlEvent.fire();
    },
    // To save the comments which has given by the current user
    saveLatestComment: function(cmp, event, helper){
       /* var action1 = cmp.get("c.getIdeaID");
        action1.setParams({
            "id1":cmp.get("v.IdeaId")
        });
        action1.setCallback( this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                alert('Mail Sent Successfully');
            }
        });
        $A.enqueueAction(action1); */
        
        cmp.set('v.displayView',false);
        var latestComm = cmp.get("v.NewCommentsStr");
        var ideaData = cmp.get('v.wrapIdea');
        var action = cmp.get('c.saveComment');
        action.setParams({
            'StrIdea':ideaData.objIdeaRecord.Id,
            'strbody':latestComm,
            'fileName' :cmp.get('v.fileName'),
            'fileContent' : cmp.get('v.fileContent')
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                cmp.set("v.NewCommentsStr","");
                cmp.set('v.displayView',true);
                var urlEvent = $A.get("e.force:navigateToURL");
                urlEvent.setParams({
                    "url": '/ideawithcommentsview?IdeaId='+ideaData.objIdeaRecord.Id
                });
                urlEvent.fire();
            }
            // component.set("v.onloadSpinner", false);
            component.set("v.spinner", true);
            
        });
        $A.enqueueAction(action);        
    },
    // to sort the comments in assending or decending order
    sortComments:function(component,event,helper){
        var sortedValue=component.find("sort").get("v.value");
        component.set("v.selectedValue",sortedValue);
        if(sortedValue == 'Oldest First'){
            helper.sortOldComments(component, event, helper);
        }else{
            helper.sortNewComments(component, event, helper);
        }
    },
    //for upvote the idea
    upvote : function(component, event, helper) {
        helper.voteHelper(component, event, helper,1,0);
    },
     //for downvote the idea
    downvote:function(component, event, helper) {
        helper.voteHelper(component, event, helper,0,1);
    },
    closeIdea: function(component, event, helper){
        let button = component.find('closeIdea');
        button.set('v.disabled',true);
        
        //on click of close Idea button addcomments will become disabled
        //component.set("v.isShowRichText",false);
        let saveComment = component.find('saveComment');
        saveComment.set('v.disabled',true);
        
        let editTextArea = component.find('editTextarea');
        editTextArea.set('v.disabled',true);
        
        let image = component.find('image');
        image.set('v.disabled',true);
        
        //on click of close Idea button upvote and downvote will become disabled 
        let upButton = component.find('upvote');
        upButton.set('v.disabled',true);
        let downButton = component.find('downvote');
        downButton.set('v.disabled',true);
        
    },
    // to fetch the file the file details from event 
    fetchFiledetils: function(component, event, helper){
        component.set('v.fileName',event.getParam('fname'));
        component.set('v.fileContent',event.getParam('fContent'));
    }
})