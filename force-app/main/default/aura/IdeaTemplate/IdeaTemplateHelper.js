({
    getStatusPicklistValues : function(component, event, helper){
        this.showSpinner(component);
        var objectName =component.get("v.objDetail");
        var fieldname =component.get("v.status");
        var action = component.get("c.getselectOptions");             
        action.setParams({
            objectName : objectName,
            field_apiname: fieldname
        });
        var opts = [];
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var allValues = response.getReturnValue();
                opts.push({class: "optionClass", label: '--None--', value: '--None--'})
                if (allValues != undefined && allValues.length > 0) {
                    for (var i = 0; i < allValues.length; i++) {
                        opts.push({
                            class: "optionClass",
                            label: allValues[i],
                            value: allValues[i]
                        });
                    }
                    component.set("v.pickListOptions", opts);
                }
            }
            this.hideSpinner(component);
        });
        $A.enqueueAction(action);
    },
    
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
                
                component.set("v.depnedentFieldMap",StoreResponse);
                var listOfkeys = []; 
                var accordianItems = [];
                for (var singlekey in StoreResponse) {
                    listOfkeys.push(singlekey);
                }
                
                for (var i = 0; i < listOfkeys.length; i++) {
                    var obj = {};
                    obj.Label = listOfkeys[i];
                    obj.value= listOfkeys[i];
                    obj.childs= StoreResponse[''+listOfkeys[i]] != undefined && StoreResponse[''+listOfkeys[i]] != null?StoreResponse[''+listOfkeys[i]]:[];
                    accordianItems.push(obj);
                }  
                component.set("v.accordianItems", accordianItems);
                
            }
        });
        $A.enqueueAction(action);
    },
    
    fetchDepValues: function(component, ListOfDependentFields) {
        var dependentFields = [];
        dependentFields.push('--- None ---');
        for (var i = 0; i < ListOfDependentFields.length; i++) {
            dependentFields.push(ListOfDependentFields[i]);
        }
        component.set("v.DependingpickListOptions", dependentFields);
    },
    
    displayAllIdeas: function(component, pageNumber,pageSize){
        debugger;
        this.showSpinner(component);
        var pageSize = component.get("v.pageSize");
        var pageNumber  = component.get("v.currentPageNumber");
        var action = component.get('c.getIdeasWithComments');
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === 'SUCCESS' && component.isValid()){
                var result = response.getReturnValue();
                component.set('v.idStringMap',result[0].idStringMap);
                if( result.length > 0){
                    component.set('v.wrapIdea',result);
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
                    component.set("v.TotalPages", Math.ceil(result.length / pageSize));
                }else{
                    component.set("v.isAllIdeas", false);
                    component.set("v.isNoIdeas", true);
                    component.set("v.RecordStart",0);
                    component.set("v.RecordEnd",0);
                    component.set("v.TotalRecords",0);
                } 
            }else if(state === 'ERROR'){
                console.log(response.error);
            }else{
                console.log('UNKNOWN ERROR');
            }
            this.hideSpinner(component);
        });
        $A.enqueueAction(action);
    },
    
    getIdeaCount : function(component, event, helper) {
        this.showSpinner(component);
        var action = component.get("c.mapIdeasWithCount");
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS"){
                var result = response.getReturnValue();
                var listOfkeys = []; 
                var accordianItems = [];
                for (var singlekey in result) {
                    listOfkeys.push(singlekey);
                }
                for (var i = 0; i < listOfkeys.length; i++) {
                    var obj = {};
                    obj.Label = listOfkeys[i];
                    obj.value= listOfkeys[i];
                    obj.childs= result[''+listOfkeys[i]] != undefined && result[''+listOfkeys[i]] != null?result[''+listOfkeys[i]]:[];
                    accordianItems.push(obj);
                }
                component.set("v.mapcountValues", accordianItems);
            }
            this.hideSpinner(component);
        });
        $A.enqueueAction(action);
    },
    
    recentIdeas : function(component, event, helper) {
        var pageSize = component.get("v.pageSize");
        var action = component.get('c.fetchAllRecentIdeas');     
        var pageNumber = component.get("v.currentPageNumber");
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === 'SUCCESS' && component.isValid()){
                var result = response.getReturnValue();
                if( result.length > 0){
                    component.set('v.wrapIdea',result);
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
                    component.set("v.TotalPages", Math.ceil(result.length / pageSize));
                }else{
                    component.set("v.isAllIdeas", false);
                    component.set("v.isNoIdeas", true);
                    component.set("v.RecordStart",0);
                    component.set("v.RecordEnd",0);
                    component.set("v.TotalRecords",0);
                }
            }else if(state === 'ERROR'){
                console.log(response.error);
            }else{
                console.log('UNKNOWN ERROR');
            }
        });
        $A.enqueueAction(action);
    },
    
    popularIdeas : function(component, event, helper) {
        var pageSize = component.get("v.pageSize");
        var action = component.get('c.fetchAllPopularIdeas');     
        var pageNumber = component.get("v.currentPageNumber");
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === 'SUCCESS' && component.isValid()){
                var result = response.getReturnValue();
                if( result.length > 0){
                    component.set('v.wrapIdea',result);
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
                    component.set("v.TotalPages", Math.ceil(result.length / pageSize));
                }else{
                    component.set("v.isAllIdeas", false);
                    component.set("v.isNoIdeas", true);
                    component.set("v.RecordStart",0);
                    component.set("v.RecordEnd",0);
                    component.set("v.TotalRecords",0);
                }
            }else if(state === 'ERROR'){
                console.log(response.error);
            }else{
                console.log('UNKNOWN ERROR');
            }
        });
        $A.enqueueAction(action);
    },
    myIdeas : function(component, event, helper) {
        var pageSize = component.get("v.pageSize");
        var action = component.get('c.getMyIdeas');     
        var pageNumber = component.get("v.currentPageNumber");
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === 'SUCCESS' && component.isValid()){
                var result = response.getReturnValue();
                if( result.length > 0){
                    component.set('v.wrapIdea',result);
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
                    component.set("v.TotalPages", Math.ceil(result.length / pageSize));
                }else{
                    component.set("v.isAllIdeas", false);
                    component.set("v.isNoIdeas", true);
                    component.set("v.RecordStart",0);
                    component.set("v.RecordEnd",0);
                    component.set("v.TotalRecords",0);
                }
            }else if(state === 'ERROR'){
                console.log(response.error);
            }else{
                console.log('UNKNOWN ERROR');
            }
        });
        $A.enqueueAction(action);
    },
    
    
    next : function(component, event, helper){
        var idealist = component.get("v.wrapIdea");
        var end = component.get("v.RecordEnd");
        var start = component.get("v.RecordStart");
        var pageSize = component.get("v.pageSize");
        var pageNumber = component.get("v.currentPageNumber");
        var PaginationIdealist = [];
        var counter = 0;
        if(pageSize > 0){
            for(var i=end; i<end+pageSize; i++)
            {
                if(idealist.length > i)
                {
                    PaginationIdealist.push(idealist[i]);
                }
                counter ++ ;
            }
            start = start + counter;
            end = end + counter;
            
            component.set("v.RecordStart",start);
            component.set("v.RecordEnd",end);
            component.set('v.wrapPaginationList', PaginationIdealist);
           component.set("v.currentPageNumber",pageNumber+1);
            component.set("v.TotalPages", Math.ceil(idealist.length / pageSize));
        }else{
            component.set("v.isAllIdeas", false);
            component.set("v.isNoIdeas", true);
        }
    },
    
    previous : function(component, event, helper) 
    {
        var idealist = component.get("v.wrapIdea");
        var end = component.get("v.RecordEnd");
        var start = component.get("v.RecordStart");
        var pageSize = component.get("v.pageSize");
        var pageNumber = component.get("v.currentPageNumber");
        var PaginationIdealist = [];
        var counter = 0;
        if(pageSize > 0){
            for(var i= start-pageSize; i < start ; i++)
            {
                if(i > -1)
                {
                    PaginationIdealist.push(idealist[i]);
                    counter ++;
                }
                else
                {
                    start++;
                }
            }
            start = start - counter;
            end = end - counter;
            
            component.set("v.RecordStart",start);
            component.set("v.RecordEnd",end);
            component.set('v.wrapPaginationList', PaginationIdealist);
            component.set("v.currentPageNumber",pageNumber-1);
            component.set("v.TotalPages", Math.ceil(idealist.length / pageSize));
        }else{
            component.set("v.isAllIdeas", false);
            component.set("v.isNoIdeas", true);
            
        }
    },
    
    fetchMainIdeas:function(component, event, helper,mainIdea) {
        var action = component.get('c.fetchIdeasWithComments');
        var param = {
            "busIdea":mainIdea
        }
        action.setParams(param);
        var pageSize = component.get("v.pageSize");
        var pageNumber = component.get("v.currentPageNumber");       
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === 'SUCCESS' && component.isValid()){
                var result = response.getReturnValue();
                if( result.length > 0){
                    component.set('v.wrapIdea',result);
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
                    component.set("v.TotalPages", Math.ceil(result.length / pageSize));
                }else{
                    component.set("v.isAllIdeas", false);
                    component.set("v.isNoIdeas", true);
                    component.set("v.RecordStart",0);
                    component.set("v.RecordEnd",0);
                    component.set("v.TotalRecords",0);
                }
            }else if(state === 'ERROR'){
                console.log(response.error);
            }else{
                console.log('UNKNOWN ERROR');
            }
            
            
        });
        $A.enqueueAction(action);
    },
    
    fetchSubIdeas : function(component, event, subIdea) {
        var action = component.get('c.fetchSubIdeasWithComments');
        var param = {
            "subIdea":subIdea
        }
        action.setParams(param);
        var pageSize = component.get("v.pageSize");
        var pageNumber = component.get("v.currentPageNumber");       
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === 'SUCCESS' && component.isValid()){
                var result = response.getReturnValue();                
                //component.set('v.ideaList',result);
                if( result.length > 0){
                    component.set('v.wrapIdea',result);
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
                    component.set("v.TotalPages", Math.ceil(result.length / pageSize));
                }else{
                    component.set("v.isAllIdeas", false);
                    component.set("v.isNoIdeas", true);
                    component.set("v.RecordStart",0);
                    component.set("v.RecordEnd",0);
                    component.set("v.TotalRecords",0);
                }
            }else if(state === 'ERROR'){
                console.log(response.error);
            }else{
                console.log('UNKNOWN ERROR');
            }
        });
        $A.enqueueAction(action);
    },
    
    
    
    createIdea : function(component, event, helper){
        var objIdea = component.get("v.IdeaDetails");
        
        if(objIdea.Ideas__c == '--- None ---' ){
            component.set("v.disableButton", true);
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
                }else if(state === 'ERROR'){
                    console.log(response.error);
                }else{
                    console.log('UNKNOWN ERROR');
                }
            });
        }
        $A.enqueueAction(action);
    },
    
    SaveComment : function(component, event, helper){
        var objComments = component.get("v.Comments");
        var rowIndex = event.getSource().get("v.tabindex"); 
        var listIndx = component.get("v.wrapIdea");
        var ideaId = listIndx[rowIndex].objIdeaRecord.Id;
        
        var action = component.get("c.saveComment");
        action.setParams({
            'StrIdea':ideaId,
            'strbody':objComments.CommentBody__c
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            var result = response.getReturnValue();
            if(state === 'SUCCESS' ){
                var newComments= {'sobjectType': 'Comment__c',
                                  'CommentBody__c': '',
                                  'UpVotes__c': ' ',
                                  'Idea__c':''
                                 };
                component.set("v.Comments", newComments);
                var showToast = $A.get("e.force:showToast"); 
                showToast.setParams({ 
                    'title' : 'Success Message', 
                    'message' : 'The Comment has been saved sucessfully.',
                    'type': 'success',
                    'mode': 'pester'
                }); 
                showToast.fire(); 
                $A.get('e.force:refreshView').fire();
            }else if(state === 'ERROR'){
                console.log(response.error);
            }else{
                console.log('UNKNOWN ERROR');
            }
        });
        $A.enqueueAction(action);
        
    },
    showSpinner: function(component) {
        // remove slds-hide class from mySpinner
        var spinner = component.find("mySpinner");
        $A.util.removeClass(spinner, "slds-hide");
    },  
    
    // function automatic called by aura:doneWaiting event 
    hideSpinner : function(component){
        // add slds-hide class from mySpinner    
        var spinner = component.find("mySpinner");
        $A.util.addClass(spinner, "slds-hide");
    }
})