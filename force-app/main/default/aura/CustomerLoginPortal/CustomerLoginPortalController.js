({
    
    SignUp : function(component, event, helper) {
        
        console.log('Enter Here');
        var evt = $A.get("e.force:navigateToComponent");
        console.log('evt',evt);
        evt.setParams({
            componentDef: "c:CustomerSignUpPortal"
        });
        
        evt.fire();
    }
    
})