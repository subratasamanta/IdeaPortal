({
	doInit : function(component, event, helper) {
		console.log('++++++++++');
        var evt = $A.get("e.force:navigateToComponent");
    	evt.setParams({
        componentDef : "c:IdeaTemplate",        
    });
    evt.fire();
	}
})