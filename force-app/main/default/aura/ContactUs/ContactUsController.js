({    
    createRecord: function(component, event, helper){
        var getEmail = component.get("v.email");
        var getSubject = component.get("v.subject");
        var getbody = component.get("v.body");
        var frstName = component.get("v.FirstName");
        //var lstName = component.get("v.LastName");
        var phn = component.get("v.Phone");
        var cmpny = component.get("v.Company");
        // check if Email field is Empty or not contains @ so display a alert message 
        // otherwise call call and pass the fields value to helper method    
        if ($A.util.isEmpty(getEmail) || !getEmail.includes("@")) {
            alert('Please Enter valid Email Address');
        } else {
            helper.sendHelper(component, getEmail, getSubject, getbody, frstName, phn, cmpny);
        }
        //getting the candidate information
        //var candidate = component.get("v.contactList");
        //console.log('called in to check the candidate',candidate);
        
        //Validation
        /*if($A.util.isEmpty(candidate.FirstName) || $A.util.isUndefined(candidate.FirstName)){
            console.log('First Name is Required');
            return;
        }            
        if($A.util.isEmpty(candidate.LastName) || $A.util.isUndefined(candidate.LastName)){
            console.log('Last Name is Rqquired');
            return;
        }
        if($A.util.isEmpty(candidate.Email) || $A.util.isUndefined(candidate.Email)){
            console.log('Email is Required');
            return;
        }
        if($A.util.isEmpty(candidate.Account.Name) || $A.util.isUndefined(candidate.Account.Name)){
            console.log('CompanyName is Required');
            return;
        }
        if($A.util.isEmpty(candidate.Phone) || $A.util.isUndefined(candidate.Phone)){
            console.log('Phone is Required');
            return;
        } if($A.util.isEmpty(candidate.SelectEnquiryType__c) || $A.util.isUndefined(candidate.SelectEnquiryType__c)){
            console.log('SelectEnquiryType__c is Required');
            return;
        }
        if($A.util.isEmpty(candidate.Description) || $A.util.isUndefined(candidate.Description)){
            console.log('Description is Required');
            return;
        }
        Calling the Apex Function
        var action = component.get("c.getData");
        console.log('class is called');
        Setting the Apex Parameter
        action.setParams({
            //objContact : candidate
            "firstName" : JSON.stringify(first),
            "lastName" : JSON.stringify(last),
            "Email" : JSON.stringify(mail),
            "Phone" : JSON.stringify(phone),
            "Company" : JSON.stringify(Company),
            "Description" : JSON.stringify(description),
            "SelectEnquiryType" : JSON.stringify(selectEnquiryType)
        });
        
        action.setCallback(this,function(a){
            var state = a.getState();
            console.log('called in state'+state);
            if(state == "SUCCESS"){
                console.log('response',state);
            } else if(state == "ERROR"){
                console.log('Error in calling server side action');
            }
            $A.get('e.force:refreshView').fire();
            
        });
        
        //adds the server-side action to the queue        
        $A.enqueueAction(action);  */
    },
    closeMessage: function(component, event, helper) {
        component.set("v.mailStatus", false);
        component.set("v.email", null);
        component.set("v.subject", null);
        component.set("v.body", null);
    },
})