({
    doInit : function(component, event, helper) {
        helper.displayAllIdeas(component,event,helper);
        helper.fetchPicklistValues(component, event,helper);
        helper.getStatusPicklistValues(component, event,helper);
        helper.getIdeaCount(component, event,helper);     
        var url = $A.get('$Resource.backgroundIdea');
        component.set('v.backgroundImageURL', url);
    },
    
    handleNext: function(component, event, helper) {
        console.log('next button callig');
        helper.next(component,event, helper);
    },
    
    handlePrev: function(component, event, helper) {
        console.log('prev button callig');
        helper.previous(component,event, helper);
    },
    
    onControllerFieldChange: function(component, event, helper) {     
        var controllerValueKey = event.getSource().get("v.value");
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
        console.log('calling on change of the status');
        var SelectedStatus=component.find("ideaStatus").get("v.value");
        console.log('calling on change of the status',SelectedStatus);
        component.set("v.selectedStatusValue",SelectedStatus);
        var action = component.get("c.fetchRelatedIdeas");
        var pageSize = component.get("v.pageSize");
        var pageNumber = component.get("v.currentPageNumber");
        action.setParams({              
            strSelectedStatus:SelectedStatus
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS"  && component.isValid()) { 
                console.log('status response:::',state);
                var result = response.getReturnValue();
                if( result.length > 0)
                {
                    component.set("v.wrapIdea", result);
                    //pagination starts here
                    component.set("v.TotalRecords", component.get("v.wrapIdea").length);
                    component.set("v.RecordStart",1);
                    component.set("v.RecordEnd",pageSize);
                    var ideaPaginationList = [];
                    for(var i=0; i< pageSize; i++)
                    {
                        if(component.get("v.wrapIdea").length > i)
                            ideaPaginationList.push(response.getReturnValue()[i]);
                    }
                    component.set('v.wrapPaginationList', ideaPaginationList);
                    console.log('wt is getting',component.get('v.wrapPaginationList'));
                    component.set("v.TotalPages", Math.ceil(result.length / pageSize));
                }else{
                    component.set("v.isAllIdeas", false);
                    component.set("v.isNoIdeas", true);
                }
            }else if(state === 'ERROR'){
            }else{}
            
        });
        $A.enqueueAction(action);
    },
    
    showSortIdeas:function(component,event,helper){
        var sorting=component.find("Status").get("v.value");
        var buttonName = event.getSource().get("v.name");
        component.set("v.selectedValue",sorting);
        if(sorting == 'Recent' || buttonName == 'Recent'){
            helper.recentIdeas(component, event, helper);
        }else if(sorting == 'Trending'){ 
            helper.popularIdeas(component, event, helper);
        }else { 
            helper.displayAllIdeas(component, event);
        }    
    },
    
    openModal: function(component,event,helper) {
        console.log('calling the button');
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
        component.set("v.IdeaDetails",{'Name':'',
                                       'Idea_Description__c': ' ',
                                       'Ideas__c':'',
                                       'SubIdeas__c':''});
    },
    
    createIdea : function(component, event, helper) {
        helper.createIdea(component, event, helper);
    },
    
    SaveComment : function(component, event, helper) {
        helper.SaveComment(component, event, helper);
    },
    
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
        if(!$A.util.isEmpty(businessSelect)){
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
    
   /* closeModal1 : function(component, event, helper){
        component.set("v.isOpenModalFirst", false);
        component.set("v.isOpenModalSecond", true);
    },*/
    
    bringResults : function(component, event, helper){
        //var selectedValue =  event.target.getAttribute('data-value');
        // console.log('called in to check selectedValue',selectedValue);
        // var selectedSort = component.find("Status").get("v.value");
        // console.log('called in to check selectedSort',selectedSort);
        // var ideaStatus = component.find("ideaStatus").get("v.value");
        // console.log('called in to check ideaStatus',ideaStatus);
        
        var selectedValue =  event.target.getAttribute('data-value');
        component.set('v.selectedSubIdea',selectedValue);
        helper.fetchSubIdeas(component, event, selectedValue)
    },
    handleMainIdeas:function(component, event, helper){
        
        component.set('v.mapcountValues.childs', [{showSubIdeas:false}]);
        var ideatarget = event.target.getAttribute('data-selected-Index');
        console.log('index of picklist:::',ideatarget);
        var listIndx = component.get("v.mapcountValues");
        console.log('wt getting on clickof wrap:::',listIndx);
        //listIndx[ideatarget].expanded = !listIndx[ideatarget].expanded;
        
        if(listIndx[ideatarget].showSubIdeas){
            listIndx[ideatarget].showSubIdeas = false;
        }else{
            listIndx[ideatarget].showSubIdeas = true;
        }
        for(var i=0; i<listIndx.length; i++){
            if(i != ideatarget){
                listIndx[i].showSubIdeas = false;
            }
        }
        component.set("v.mapcountValues",listIndx);
        
        var selectedIdea =  event.target.getAttribute('data-value');
        console.log('called in to check selectedValue',selectedIdea);
        var splitSelectedIdea = selectedIdea.replace(/[{()}]/g, '').split(/(\d+)/g).filter(Boolean);
        console.log('after splitting the string:::',splitSelectedIdea);
        var newStrSelcetedIdea = splitSelectedIdea.shift().trim();
        console.log('after removing the integer:::',newStrSelcetedIdea);
        component.set('v.selectedMainIdea',newStrSelcetedIdea);
        console.log('wt is getting in the selectedMainIdea :',component.get('v.selectedMainIdea'));
        helper.fetchMainIdeas(component, event, helper,newStrSelcetedIdea)
    },
    
    ok:  function(component, event, helper){
        component.set("v.isOpenModalPostIdea",false);
        document.location.reload(true)
    },
    
    okNoidea : function(component, event, helper){
        component.set("v.isNoIdeas",false);    
        component.set("v.isAllIdeas", true);
    },
    openDetailPage : function(component, event, helper){
        var ctarget = event.srcElement.id;
        var listIndx = component.get("v.wrapPaginationList");
        
        /*  if(listIndx[ctarget].showComments){
            listIndx[ctarget].showComments = false;
        }else{
            listIndx[ctarget].showComments = true;
        }
        for(var i=0; i<listIndx.length; i++){
            if(i != ctarget){
                listIndx[i].showComments = false;
            }
        } */
        
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": '/ideawithcommentsview?IdeaId='+listIndx[ctarget].objIdeaRecord.Id
        });
        urlEvent.fire();
        
        /* if(component.get("v.isCommunityUser")){
            var urlEvent = $A.get("e.force:navigateToSObject");
            urlEvent.setParams({
                "recordId": listIndx[ctarget].objIdeaRecord.Id,
                "slideDevName": "chatter"
            });
            urlEvent.fire();
        }else{
            var evt = $A.get("e.force:navigateToComponent"); 
            evt.setParams({
                componentDef : "c:IdeawithCommentsView",
                componentAttributes: { 
                    IdeaId : listIndx[ctarget].objIdeaRecord.Id,
                    isCommunity : false
                }
            });
            evt.fire();
        }*/
        component.set("v.wrapPaginationList",listIndx);
    },
    openComments : function(component, event, helper){ 
        console.log('method Calling');
        var ctarget = event.srcElement.id;
        console.log('called in for ctarget id',ctarget);
        var listIndx = component.get("v.wrapPaginationList");
        console.log('called in for listIndx id',listIndx);
        console.log('called in for listIndx[ctarget] id',listIndx[ctarget]);
        
      /*  if(listIndx[ctarget].showComments){
            console.log('called in to check check cehck',listIndx[ctarget].showComments);
            listIndx[ctarget].showComments = false;
        }else{
            listIndx[ctarget].showComments = true;
        }
        for(var i=0; i<listIndx.length; i++){
            if(i != ctarget){
                listIndx[i].showComments = false;
            }
        } */
        
        if(component.get("v.isCommunityUser")){
            console.log('called inside if ');
            var urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({
                "url": '/ideawithcommentsview?IdeaId='+listIndx[ctarget].objIdeaRecord.Id
            });
            urlEvent.fire();
        }else{
            // Commneted as navigate to component was not working on 27/may
            /*var evt = $A.get("e.force:navigateToComponent"); 
            evt.setParams({
                componentDef : "c:IdeawithCommentsView",
                componentAttributes: { 
                    IdeaId : listIndx[ctarget].objIdeaRecord.Id,
                    isCommunity : false
                }
            });
            evt.fire();*/
            var urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({
                "url": '/ideawithcommentsview?IdeaId='+listIndx[ctarget].objIdeaRecord.Id
            });
            urlEvent.fire();
        }
        component.set("v.wrapPaginationList",listIndx);
    },
    
    /*alertAction:function(component,event,helper){
        component.set("v.isShowAlert",false);
    },*/
    
   
    
})