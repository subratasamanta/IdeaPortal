({
    doInit : function(component, event, helper) {
        helper.displayAllIdeas(component, event);
    },
    openComments : function(component, event, helper) {
        var btnId = event.target.id;
        console.log('btnId-=-=-'+btnId);
    },    
})