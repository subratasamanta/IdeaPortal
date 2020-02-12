({
    doInit : function(component, event, helper) {
        helper.displayAllIdeas(component,event,helper);
    },
    openDetailPage : function(component, event, helper){
        var ctarget = event.srcElement.id;
        var listIndx = component.get("v.wrapPaginationList");
        var urlEvent = $A.get("e.force:navigateToURL");
        
        urlEvent.setParams({
            "url": '/ideawithcommentsview?IdeaId='+listIndx[ctarget].objIdeaRecord.Id
        });
        urlEvent.fire();
        component.set("v.wrapPaginationList",listIndx);
    },
    openComments : function(component, event, helper){ 
        console.log('method Calling');
        var ctarget = event.srcElement.id;
        console.log('called in for ctarget id',ctarget);
        var listIndx = component.get("v.wrapPaginationList");
        console.log('called in for listIndx id',listIndx);
        console.log('called in for listIndx[ctarget] id',listIndx[ctarget]);
        
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": '/ideawithcommentsview?IdeaId='+listIndx[ctarget].objIdeaRecord.Id
        });
        urlEvent.fire();
        component.set("v.wrapPaginationList",listIndx);
    },
      handleNext: function(component, event, helper) {
        console.log('next button callig');
        helper.next(component,event, helper);
    },
    
    handlePrev: function(component, event, helper) {
        console.log('prev button callig');
        helper.previous(component,event, helper);
    },
})