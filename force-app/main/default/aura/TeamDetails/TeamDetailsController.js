({
    doInit : function(component, event, helper) {
        var action = component.get("c.fetchContactDetailList");       
        action.setCallback(this, function(data){
            var state = data.getState();
            console.log('response'+state);
            if(component.isValid() && state === 'SUCCESS' ){
                var recordResp = data.getReturnValue();
                console.log('called in for check',recordResp[0].Name);
                component.set("v.contactList", recordResp);
            }
        });       
        $A.enqueueAction(action);
    },    
    
    handleSectionToggle: function (cmp, event) {
        var openSections = event.getParam('openSections');
        
        if (openSections.length === 0) {
            console.log("called in if");
            cmp.set('v.activeSectionsMessage', "All sections are closed");
        } else {
            console.log("calle din else");
            cmp.set('v.activeSectionsMessage', "Open sections: " + openSections.join(', '));
        }
    },
   
})