({
    // dynamically fetch picklist value from picklist field
    fetchPicklistValues: function(component,event, helper) {
        var controllingField= component.get("v.controllingField");
        var dependingField = component.get("v.dependingField");
        var objDetails = component.get("v.objDetail");
        var action = component.get("c.getDependentMap");
        action.setParams({
            'objDetail' : objDetails,
            'contrfieldApiName': controllingField,
            'depfieldApiName': dependingField 
        });
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var StoreResponse = response.getReturnValue();
                //console.log('wt inside::::',StoreResponse);
                component.set("v.depnedentFieldMap",StoreResponse);
               // console.log('response inside::::', component.get('v.depnedentFieldMap'));
                var listOfkeys = []; 
                var accordianItems = [];
                for (var singlekey in StoreResponse) {
                    listOfkeys.push(singlekey);
                }
              //  console.log('values in listOfKeys::::',listOfkeys);  
                if (listOfkeys != undefined && listOfkeys.length > 0) {
                    accordianItems.push('--- None ---');
                }
                  console.log('accordianItems:::',accordianItems);  
                for (var i = 0; i < listOfkeys.length; i++) {
                   /* var obj = {};
                    obj.Label = listOfkeys[i];
                    obj.value= listOfkeys[i];
                    obj.childs= StoreResponse[''+listOfkeys[i]] != undefined && StoreResponse[''+listOfkeys[i]] != null?StoreResponse[''+listOfkeys[i]]:[];
                    console.log('childs in++++',obj.childs);*/
                   // accordianItems.push(obj);
                    accordianItems.push(listOfkeys[i]);
                }  
                //console.log('called in accordiaon',accordianItems);
                component.set("v.accordianItems", accordianItems);
                
            }else{
                console.log('Something went wrong..');
            }
        });
        $A.enqueueAction(action);
    },
    // Get the dependent picklist values 
    fetchDepValues: function(component, ListOfDependentFields) {
        var dependentFields = [];
        dependentFields.push('--- None ---');
        for (var i = 0; i < ListOfDependentFields.length; i++) {
            dependentFields.push(ListOfDependentFields[i]);
        }
        component.set("v.DependingpickListOptions", dependentFields);
    },
    //Create idea
    createIdea : function(component, event, helper){
        debugger;
        var objIdea = component.get("v.IdeaDetails");
        
        if(objIdea.Ideas__c == '--- None ---' ){
           // component.set("v.disableButton", true);
        }
        else if(objIdea.Idea_Description__c == " " || $A.util.isEmpty(objIdea.Idea_Description__c) || $A.util.isUndefined(objIdea.Idea_Description__c)){
        	var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "type":"warning",
                "title": "Warning!",
                "message": "Description is required."
            });
    		toastEvent.fire();
            return;    
        }
        else{
            var action = component.get("c.createRecord");
            action.setParams({
                'objcandidate':objIdea 
            });
            action.setCallback(this, function(response){
                var state = response.getState();
                var result = response.getReturnValue();
                
                if(state === 'SUCCESS' && component.isValid()){
                    //Reset Form
                    var newIdeaList= {'sobjectType': 'Idea__c',
                                      'Name': '',
                                      'Idea_Description__c': ' ',
                                      'Ideas__c':'',
                                      'SubIdeas__c':''
                                     };
                    
                    component.set("v.IdeaDetails", newIdeaList);
                    
                    component.set("v.isOpenModal",false);
                    component.set("v.isOpenModalPostIdea", true);
                    var mainId = component.find("mainPage");
                    var cmpBack = component.find('Modalbackdropmsg');
                    $A.util.addClass(mainId, 'slds-fade-in-open');
                    $A.util.addClass(cmpBack, 'slds-backdrop--open'); 
                    
                    
                    // window.location.reload();
                    /*var showToast = $A.get("e.force:showToast"); 
                    showToast.setParams({ 
                        'title' : 'Success Message', 
                        'message' : 'The Idea has been Submitted sucessfully.',
                        'type': 'success',
                        'mode': 'pester'
                    }); 
                    showToast.fire();
                    var alertboxContent = {
                        message:'Thanks for submitting your idea. We will keep you posted about the progress',
                        heading: 'Success',
                        class: 'slds-theme--success',
                        callableFunction: component.getReference('c.closeAlert'),
                        buttonHeading: $A.get("$Label.c.OK")
                    };
                    alert('before Calling helper'); 
                    self.showAlert(component, event, helper);*/
                }else if(state === 'ERROR'){
                    console.log(response.error);
                }else{
                    console.log('UNKNOWN ERROR');
                }
            });
        }
        $A.enqueueAction(action);
        
    },
    
})