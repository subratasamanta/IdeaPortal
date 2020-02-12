({
    fetchAcc : function(component, event, helper) {
        helper.fetchAccHelper(component, event, helper);
    },
    openComments : function(component, event, helper) {
        var mode = event.target.getAttribute("data-mode");
    	helper.openComments(component, event, helper,mode);
    }
})