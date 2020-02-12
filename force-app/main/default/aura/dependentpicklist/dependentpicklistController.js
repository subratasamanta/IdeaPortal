({
    doInit : function(component, event, helper) {
        helper.fetchPicklistValues(component, event,helper);
        helper.displayAllIdeas(component, event,helper);
        helper.getStatusPicklistValues(component, event,helper);
        
        var url = $A.get('$Resource.backgroundIdea');
        component.set('v.backgroundImageURL', url);
    },
    
    onControllerFieldChange: function(component, event, helper) {     
       var controllerValueKey = event.getSource().get("v.value");
              //var controllerValueKey = component.find('cntrlField').get("v.value");
         console.log('called in 11111', controllerValueKey);
        var depnedentFieldMap = component.get("v.depnedentFieldMap");
        
        if (controllerValueKey != '--- None ---') {
            var ListOfDependentFields = depnedentFieldMap[controllerValueKey];
            component.set("v.isBoolErrorMessage", "");
            component.set("v.disableButton" , false);
            
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
            component.set("v.disableButton" , true);
        }
    },
    
    handleOnChange: function(component, event, helper){
        var SelectedValue=component.find("deptpicklist").get("v.value");
        console.log('called in 11111', SelectedValue);
         var SelectedStatus=component.find("Status").get("v.value");
         console.log('called in Status', SelectedStatus);
        //component.set("v.picklistOption",SelectedValue)
        if (!$A.util.isEmpty(SelectedValue)){
            var action = component.get("c.fetchRelatedIdeas");
            var pageSize = component.get("v.pageSize");
            action.setParams({
                selectedStrOption : SelectedValue,
                strSelectedStatus:SelectedStatus
            });
            action.setCallback(this, function(response){
                var state = response.getState();
              
                var result = response.getReturnValue();
                if (state === "SUCCESS") {                  
                    component.set("v.wrapIdea", result);
                    // pagoination starts here
                    component.set("v.totalIdeas", component.get("v.wrapIdea").length);
                    component.set("v.startPage",0);
                    component.set("v.endPage",pageSize-1);
                    
                    var ideaPaginationList = [];
                    for(var i=0; i< pageSize; i++)
                    {
                        if(component.get("v.wrapIdea").length> i)
                            ideaPaginationList.push(result[i]);    
                    }
                    component.set('v.ideaPaginationList', ideaPaginationList);
                }else if(state === 'ERROR'){
                   
                }else{
                    
                }
            });
            $A.enqueueAction(action);
        }     
    },
    handleOnStatusChange: function(component, event, helper){
        var SelectedStatus=component.find("Status").get("v.value");
        console.log('selected;;;;',SelectedValue);
        component.set("v.picklistOption",SelectedStatus);
    },
   
    showAllIdeas:function(component,event,helper){   
        helper.displayAllIdeas(component, event);
    },
    showRecentIdeas : function(component, event, helper){
        helper.recentIdeas(component, event, helper);
    },
    openModal: function(component,event,helper) {
        component.set("v.isOpenModal",true)
        var cmpTarget = component.find('Modalbox');
        var cmpBack = component.find('Modalbackdrop');
        $A.util.addClass(cmpTarget, 'slds-fade-in-open');
        $A.util.addClass(cmpBack, 'slds-backdrop--open'); 
    },
    closeModal:function(component,event,helper){    
        var cmpTarget = component.find('Modalbox');
        var cmpBack = component.find('Modalbackdrop');
        $A.util.removeClass(cmpBack,'slds-backdrop--open');
        $A.util.removeClass(cmpTarget, 'slds-fade-in-open'); 
        component.set("v.isOpenModal",false);
        
    },
    createIdea : function(component, event, helper) {
        helper.createIdea(component, event, helper);
    },
    SaveComment : function(component, event, helper) {
        helper.SaveComment(component, event, helper);
    },
    
    Cancel: function(component, event, helper) {
        var ctarget = event.getSource().get("v.tabindex");
        console.log('called in',ctarget);
        var listIndx = component.get("v.wrapIdea");
        console.log('called in listindex',listIndx);
        listIndx[ctarget].showComments = false;
        component.set("v.wrapIdea",listIndx);
        
    },
    next : function(component, event, helper){ 
        helper.next(component, event, helper);
    },
    openComments : function(component, event, helper){
       
        var ctarget = event.getSource().get("v.tabindex"); 
        console.log('called in for id',ctarget);
        var listIndx = component.get("v.wrapIdea");
        if(listIndx[ctarget].showComments){
            listIndx[ctarget].showComments = false;
        }else{
            listIndx[ctarget].showComments = true;
        }
        for(var i=0; i<listIndx.length; i++){
            if(i != ctarget){
                listIndx[i].showComments = false;
            }
        }
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": '/ideawithcommentsview?IdeaId='+listIndx[ctarget].objIdeaRecord.Id
        });
        urlEvent.fire();
        component.set("v.wrapIdea",listIndx);
        
    },
    viewIdea : function(component, event, helper){
        
        component.set("v.viewComments", true);
        var cmpTarget = component.find('ModalboxComments');
        var cmpBack = component.find('ModalbackdropComments');
        $A.util.addClass(cmpTarget, 'slds-fade-in-open');
        $A.util.addClass(cmpBack, 'slds-backdrop--open'); 
    },
     closeModalComments : function(component,event,helper){    
        var cmpTarget = component.find('ModalboxComments');
        var cmpBack = component.find('ModalbackdropComments');
        $A.util.removeClass(cmpBack,'slds-backdrop--open');
        $A.util.removeClass(cmpTarget, 'slds-fade-in-open'); 
        component.set("v.viewComments",false);   
    },
    like : function(component, event, helper){
        var ctarget = event.getSource().get("v.tabindex"); 
        var listIndx = component.get("v.wrapIdea");
        var id = listIndx[ctarget].objIdeaRecord.Id;
        
        var action = component.get("c.UpdateRatingLike");
        action.setParams({
            'ideaId':id,
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            var result = response.getReturnValue();
            
            if(state === 'SUCCESS' ){
                component.set("v.Ratings", result);
            }else if(state === 'ERROR'){
                console.log(response.error);
            }else{
                console.log('UNKNOWN ERROR');
            }
        });
        $A.enqueueAction(action);
    },
    dislike : function(component, event, helper){
        var ctarget = event.getSource().get("v.tabindex"); 
        var listIndx = component.get("v.wrapIdea");
        var id = listIndx[ctarget].objIdeaRecord.Id;
        
        var action = component.get("c.UpdateRatingDislike");
        action.setParams({
            'ideaId':id,
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            var result = response.getReturnValue();
            
            if(state === 'SUCCESS' ){
                component.set("v.Ratings", result);
            }else if(state === 'ERROR'){
                console.log(response.error);
            }else{
                console.log('UNKNOWN ERROR');
            }
        });
        $A.enqueueAction(action);
    },
    nextSecondModal : function(component, event, helper){
       
        var headline = component.find('titleInput').get("v.value");
        
        if (!$A.util.isEmpty(headline)){
      		
            component.set("v.isOpenModalFirst",false);
        	component.set("v.isOpenModalSecond",true);
            var progressBar = document.getElementById('checkProgressBar');
          
            $A.util.addClass(progressBar, 'slds-is-active');
            var progressBarWidth = document.getElementById('checkProgressBarWidth');
           
            $A.util.addClass(progressBarWidth, 'progressWidth');
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
        component.set("v.isOpenModalFirst",true);
        component.set("v.isOpenModalSecond",false);
        component.set("v.openButtonsFirst", true);
        component.set("v.openButtonsSecond", false);
    },
    
    nextThirdModal : function(component, event, helper){
        var businessSelect = component.find('cntrlField').get("v.value");
        console.log('called ',businessSelect);
        if(!$A.util.isEmpty(businessSelect)){
            component.set("v.isOpenModalThird", true);
            component.set("v.isOpenModalSecond",false);
            var progressBar = document.getElementById('checkProgressBarSecond');
            $A.util.addClass(progressBar, 'slds-is-active');
            var progressBarWidth = document.getElementById('checkProgressBarWidth');
            $A.util.addClass(progressBarWidth, 'progressWidthSecond');
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
        component.set("v.openButtonsThird", false);
        component.set("v.openButtonsSecond", true);
    },
    
    closeModal1 : function(component, event, helper){
        console.log('called in to check');
        component.set("v.isOpenModalFirst", false);
        component.set("v.isOpenModalSecond", true);
    },
    bringResults : function(component, event, helper){
       var selectedValue =  event.target.getAttribute('data-value');
       component.set('v.selectedSubIdea',selectedValue);
       helper.fetchIdeas(component, event, helper,selectedValue)
    }
})