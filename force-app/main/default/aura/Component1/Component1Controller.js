({
	 Navigatet2 : function(component, event, helper) {
         
        console.log('Enter Here');
        var evt = $A.get("e.force:navigateToComponent");
        console.log('evt'+evt);
        evt.setParams({
            componentDef: "c:Component2"
            //componentAttributes :{ }
        });
        
        evt.fire();
    },
    handleNavigationComplete : function(component, event, helper) {
        var canGoBack = event.getParam("canGoBack");
        // take any other action based on if back navigation is possible or not
    },
   NavigatetoC2 : function(component, event, helper) {

    //Find the text value of the component with aura:id set to "address"
    //var address = component.find("address").get("v.value");

    var urlEvent = $A.get("e.force:navigateToURL");
    urlEvent.setParams({
      "url": 'https://www.google.com/' 
    });
    urlEvent.fire();
},
    
     setPagref : function(component, event, helper) {
        var navLink = component.find("navLink");

        var pageRef = {
            type: 'standard__objectPage',
            attributes: {
                actionName: 'list',
                objectApiName: 'Account',

            },
            state: {
                filterName: "MyAccounts"
            }
        };

        // Set the URL on the link or use the default if there's an error

        navLink.generateUrl(pageRef).then($A.getCallback(function(a) {
                component.set("v.url", a ? a : "https://www.google.com/");
            }), $A.getCallback(function(error) {
                component.set("v.url", "#");
            }));
    },
   goToRec : function(component, event, helper) {
        var navLink = component.find("navLink");
        var pageRef = {
            type: 'standard__recordPage',
            attributes: {
                actionName: 'view',
                objectApiName: 'Idea__c',
                recordId : 'a0K7F00000RBxn5UAD' // change record id. 
            },
        };
        navLink.navigate(pageRef, true);
    }
})