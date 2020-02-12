({
	doInit : function(component, event, helper) {
		helper.fetchTypePicklist(component);
	},
    setSelectedValue:function(component, event, helper) {
       component.set('v.selectedValue',event.target.value)
    }
})