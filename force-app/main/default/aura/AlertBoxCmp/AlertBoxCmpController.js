({
    alertAction : function(component, event, helper) {
        conosle.log('first button key is firing');
        var onOkay = component.getEvent("onOkay");
        onOkay.fire();
        
    },
    secondaryAlertAction : function(component, event, helper) {
        var onSecondaryOkay = component.getEvent("onSecondaryOkay");
        onSecondaryOkay.fire();
        
    }
    
})