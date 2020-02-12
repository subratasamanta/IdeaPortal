({
    sendHelper: function(component, getEmail, getSubject, getbody, frstName, phn, cmpny) {
        // call the server side controller method 	
        var action = component.get("c.sendMailMethod");
        // set the 3 params to sendMailMethod method   
        action.setParams({
            'mMail': getEmail,
            'mSubject': getSubject,
            'mbody': getbody,
            'fstName': frstName,
            'mphn' : phn,
            'mcmpny' : cmpny
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                // if state of server response is comes "SUCCESS",
                // display the success message box by set mailStatus attribute to true
                component.set("v.mailStatus", true);
            }
 
        });
        $A.enqueueAction(action);
    },
})