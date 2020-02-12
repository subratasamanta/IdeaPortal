({
    fetchAcc : function(cmp, event, helper) {
        helper.fetchAccHelper(cmp, event, helper);
        //helper.fetchCaseHelper(cmp, event, helper);
        
    },
    openComments : function(cmp, event, helper) {
        var mode = event.target.getAttribute("data-mode");
    	helper.openComments(cmp, event, helper,mode);
    },
    
    tabSelected : function(cmp, event, helper){
        helper.fetchCaseHelper(cmp, event, helper);
	}
})