({
    fetchAcc : function(component, event, helper) {
        helper.fetchAccHelper(component, event, helper);
        helper.fetchCaseHelper(component, event, helper);
        
    },
    openCase : function(component, event, helper) {
        var mode = event.target.getAttribute("data-mode");
        console.log('wt getting inside',mode);
    	helper.openCase(component, event, helper,mode);
    },
    
    tabSelected : function(component, event, helper){
        helper.fetchCaseHelper(component, event, helper);
	},
    handleRowAction: function (cmp, event, helper) {
        
        var action = event.getParam('action');
       
        var row = event.getParam('row');
        console.log('row::'+row);
        var urlEvent = $A.get("e.force:navigateToURL");
        
        if (row.Status == 'Draft'){
            urlEvent.setParams({
                "url": "/casecreation?CaseId=" +row.Id+"&mode=Edit"
            }); 
        }else{
             urlEvent.setParams({
                "url": "/casecreation?CaseId=" +row.Id+"&mode=View"
            }); 
        }
        urlEvent.fire();
    },
    updateColumnSorting: function (cmp, event, helper) {
        var fieldName = event.getParam('fieldName');
        var sortDirection = event.getParam('sortDirection');
        cmp.set("v.sortedBy", fieldName);
        cmp.set("v.sortedDirection", sortDirection);
        helper.sortData(cmp, fieldName, sortDirection);
    }
})