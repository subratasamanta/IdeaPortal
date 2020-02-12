({
    //onload function
    doInit : function(component, event, helper) {
        helper.fetchPicklistValues(component, event,helper);        
    },
    
    validate: function(cmp) {
        if(!cmp.get("v.IdeaDetails.Idea_Description__c")){
            cmp.set("v.validity", false);
        }
        else{
            cmp.set("v.validity", true);
        }
    },
    
    //onchange event of picklist 
    onControllerFieldChange: function(component, event, helper) {     
        var controllerValueKey = event.getSource().get("v.value");
        var depnedentFieldMap = component.get("v.depnedentFieldMap");
        
        if (controllerValueKey != '--None--') {	
            var ListOfDependentFields = depnedentFieldMap[controllerValueKey];
            component.set("v.isBoolErrorMessage", "");
           // component.set("v.disableButton" , false);
            
            if(ListOfDependentFields.length > 0){
                component.set("v.bDisabledDependentFld" , false);  
                helper.fetchDepValues(component, ListOfDependentFields);    
            }else{
                component.set("v.bDisabledDependentFld" , true); 
                component.set("v.DependingpickListOptions", ['--- None ---']);
            }  
        } else {
            component.set("v.DependingpickListOptions", ['--- None ---']);
            component.set("v.bDisabledDependentFld" , true);
            component.set("v.isBoolErrorMessage", "show");
       		//alert('Please enter the value');
            //component.set("v.disableButton" , true);
        }
    },
    // Open modal to create idea
    openModal: function(component,event,helper) {
        console.log('calling the create Idea');
        component.set("v.isOpenModal",true)
        var cmpTarget = component.find('Modalbox');
        var cmpBack = component.find('Modalbackdrop');
        $A.util.addClass(cmpTarget, 'slds-fade-in-open');
        $A.util.addClass(cmpBack, 'slds-backdrop--open'); 
    },
    // Close modal to create idea
    closeModal:function(component,event,helper){    
        var cmpTarget = component.find('Modalbox');
        var cmpBack = component.find('Modalbackdrop');
        $A.util.removeClass(cmpBack,'slds-backdrop--open');
        $A.util.removeClass(cmpTarget, 'slds-fade-in-open'); 
        component.set("v.isOpenModal",false);
        component.set("v.IdeaDetails",{'Name':'',
                                       'Idea_Description__c': ' ',
                                       'Ideas__c':'',
                                       'SubIdeas__c':''});
        
    },
    // call helper to create idea
    createIdea : function(component, event, helper) {
        helper.createIdea(component, event, helper);
    },
    // Cancel the modal
    Cancel: function(component, event, helper) {
        var ctarget = event.getSource().get("v.tabindex");
        var listIndx = component.get("v.wrapIdea");
        listIndx[ctarget].showComments = false;
        component.set("v.wrapIdea",listIndx);
    },
    
    nextSecondModal : function(component, event, helper){
        var headline = component.find('titleInput').get("v.value");
        if (!$A.util.isEmpty(headline)){
            component.set("v.isOpenModalFirst",false);
            component.set("v.isOpenModalSecond",true);
            var progressBar = document.getElementById('checkProgressBar');
            $A.util.addClass(progressBar, 'slds-is-active');
            var progressBarWidth = document.getElementById('checkProgressBarWidth');
            var wizard1 = document.getElementById('wizard1');
            $A.util.addClass(progressBarWidth, 'progressWidth');
            $A.util.addClass(wizard1, 'wizard');
            component.set("v.openButtonsFirst", false);
            component.set("v.openButtonsSecond", true);
        }
        else{
            component.set("v.isOpenModalFirst",true);
            component.set("v.errorShow", true);
        }
    },
    
    prevfirstModal : function(component, event, helper){
        var progressBar = document.getElementById('checkProgressBar');
        $A.util.removeClass(progressBar, 'slds-is-active');
        var progressBarWidth = document.getElementById('checkProgressBarWidth');
        $A.util.removeClass(progressBarWidth, 'progressWidth');
        var wizard1 = document.getElementById('wizard1');
        $A.util.removeClass(wizard1, 'wizard');
        component.set("v.isOpenModalFirst",true);
        component.set("v.isOpenModalSecond",false);
        component.set("v.openButtonsFirst", true);
        component.set("v.openButtonsSecond", false);
    },
    
    nextThirdModal : function(component, event, helper){
        var businessSelect = component.find('cntrlField').get("v.value");
         var dependentFld = component.find('dependentFld').get("v.value");
        component.set("v.errorShowSecond", false);
        if(!$A.util.isEmpty(businessSelect) && businessSelect !="--- None ---" && !$A.util.isEmpty(dependentFld) && dependentFld !="--- None ---"){
            component.set("v.isOpenModalThird", true);
            component.set("v.isOpenModalSecond",false);
            var progressBar = document.getElementById('checkProgressBarSecond');
            $A.util.addClass(progressBar, 'slds-is-active');
            var progressBarWidth = document.getElementById('checkProgressBarWidth');
            $A.util.addClass(progressBarWidth, 'progressWidthSecond');
            var wizard2= document.getElementById('wizard2');
            $A.util.addClass(wizard2, 'wizard');
            component.set("v.openButtonsThird", true);
            component.set("v.openButtonsSecond", false);
        }
        else{
            component.set("v.errorShowSecond", true);
            component.set("v.isOpenModalSecond",true);
        }
    },
    
    prevSecondModal :  function(component, event, helper){
        component.set("v.isOpenModalThird", false);
        component.set("v.isOpenModalSecond",true);
        var progressBar = document.getElementById('checkProgressBarSecond');
        $A.util.removeClass(progressBar, 'slds-is-active');
        var progressBarWidth = document.getElementById('checkProgressBarWidth');
        $A.util.removeClass(progressBarWidth, 'progressWidthSecond');
        var wizard2 = document.getElementById('wizard2');
        $A.util.removeClass(wizard2, 'wizard');
        component.set("v.openButtonsThird", false);
        component.set("v.openButtonsSecond", true);
    },
    
    
    ok:  function(component, event, helper){
        component.set("v.isOpenModalPostIdea",false);
        //document.location.reload(true)
        var evt = $A.get("e.force:navigateToURL"); 
        evt.setParams({
            "url": '/idea'
        });
        evt.fire();
    },
    
    
})