({
	doInit : function(component, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
		window.open("https://tavant-sso--testingbox.cs35.my.salesforce.com/p/share/CustomObjectSharingDetail?parentId="+component.get("v.recordId"),'_blank');
		
    }
})