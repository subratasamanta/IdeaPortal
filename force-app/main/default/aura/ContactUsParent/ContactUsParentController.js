({
	  GetInTouch: function(component, event, helper){
          debugger;
        //getting the candidate information
        var candidate = component.get("v.contactList");
        
        //Validation
        if($A.util.isEmpty(candidate.First_Name__c) || $A.util.isUndefined(candidate.First_Name__c)){
            alert('First Name is Required');
            return;
        }            
        if($A.util.isEmpty(candidate.Last_Name__c) || $A.util.isUndefined(candidate.Last_Name__c)){
            alert('Last Name is Rqquired');
            return;
        } 
        if($A.util.isEmpty(candidate.Email__c) || $A.util.isUndefined(candidate.Email__c)){
            alert('Email is Required');
            return;
        }
        if($A.util.isEmpty(candidate.Company__c) || $A.util.isUndefined(candidate.Company__c)){
            alert('Company name is Required');
            return;
        }
        if($A.util.isEmpty(candidate.Phone__c) || $A.util.isUndefined(candidate.Phone__c)){
            alert('Phone is Required');
            return;
        } if($A.util.isEmpty(candidate.Enquiry_Type__c) || $A.util.isUndefined(candidate.Enquiry_Type__c)){
            alert('Enquiry type is Required');
            return;
        }
        if($A.util.isEmpty(candidate.Description__c) || $A.util.isUndefined(candidate.Description__c)){
            alert('Your message is Required');
            return;
        }
        //Calling the Apex Function
        var action = component.get("c.createRecord");
        component.set("v.NotLoggedInTheUser", false);     
        //Setting the Apex Parameter
        action.setParams({
            objContact : candidate
        });
        
        action.setCallback(this,function(a){
            var state = a.getState();
            if(state == "SUCCESS"){
                //Reset Form
                var newCandidate = {'sobjectType': 'Contact_Us__c',
                                     'First_Name__c': '',
                                     'Last_Name__c': '',
                                     'Email__c': '', 
                                     'Phone__c ': '',
                                     'Enquiry_Type__c': '',
                                     'Description__c': '',
                                     'Company__c': ''    
                                    };
                
                //resetting the Values in the form
                component.set("v.contactList",newCandidate);
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "type": "success",
                    "title": "Success!",
                    "message": "The record has been created successfully."
                });
                toastEvent.fire();
               
            } else if(state == "ERROR"){
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "type": "error",
                    "title": "Error!",
                    "message": "Failed to create record."
                });
                toastEvent.fire();
            }
            $A.get('e.force:refreshView').fire();
            
        });
        
        //adds the server-side action to the queue        
        $A.enqueueAction(action);
    }    
})