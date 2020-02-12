({
    getStatusPicklistValues : function(component, event, helper){
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
                console.log('wt inside::::',StoreResponse);
                component.set("v.depnedentFieldMap",StoreResponse);
                console.log('response inside::::', component.get('v.depnedentFieldMap'));
                var listOfkeys = []; 
                var accordianItems = [];
                for (var singlekey in StoreResponse) {
                    listOfkeys.push(singlekey);
                }
                console.log('values in listOfKeys::::',listOfkeys);  
                
                for (var i = 0; i < listOfkeys.length; i++) {
                    var obj = {};
                    obj.Label = listOfkeys[i];
                    obj.value= listOfkeys[i];
                    obj.childs= StoreResponse[''+listOfkeys[i]] != undefined && StoreResponse[''+listOfkeys[i]] != null?StoreResponse[''+listOfkeys[i]]:[];
                    //console.log('childs in++++',obj.childs);
                    accordianItems.push(obj);
                }  
                //console.log('called in accordiaon',accordianItems);
                component.set("v.accordianItems", accordianItems);
                console.log('accordians inside accordianItems::::', component.get('v.accordianItems'));
                
            }else{
                //console.log('Something went wrong..');
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
        var pageSize = component.get("v.pageSize");
        var pageNumber  = component.get("v.currentPageNumber");
        console.log('page size is::::',pageSize);
        var action = component.get('c.getIdeasWithComments');
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === 'SUCCESS' && component.isValid()){
                var result = response.getReturnValue();
                console.log('all ideas with counts::::',result);
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
                    console.log('wt is getting',component.get('v.wrapPaginationList'));
                    component.set("v.TotalPages", Math.ceil(result.length / pageSize));
                    /* component.set("v.PageNumber", result.pageNumber);
                component.set("v.TotalRecords", result.length);
                component.set("v.RecordStart", result.recordStart);
                component.set("v.RecordEnd", result.recordEnd);*/
                    /* if(result.length > 0 && result[0].logdUsrProfilename == 'Tavant Customer User'){
                    component.set('v.isCommunityUser',true);
                }else{
                    component.set('v.isCommunityUser',false);
                }*/
                }else{
                    component.set("v.isAllIdeas", false);
                    component.set("v.isNoIdeas", true);
                } 
            }else if(state === 'ERROR'){
                console.log(response.error);
            }else{
                console.log('UNKNOWN ERROR');
            }
        });
        $A.enqueueAction(action);
    },
    
    getIdeaCount : function(component, event, helper) {
        var action = component.get("c.mapIdeasWithCount");
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS"){
                var result = response.getReturnValue();
                console.log('response in Idea Count',result);
                /* var arrayMapKeys = [];
                console.log('all ideas with counts::::',result);
                for(var key in result){
                    arrayMapKeys.push({value:result[key], key:key});
                }*/
                //  component.set("v.mapcountValues", result);
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
                    // console.log('what values r cmng:::',obj.childs);
                    accordianItems.push(obj);
                }
                console.log('picklist values in Idea Count',accordianItems);
                component.set("v.mapcountValues", accordianItems);
                console.log('all ideascount in getideacount on mapcountValues::::', component.get("v.mapcountValues"));
            }
        });
        $A.enqueueAction(action);
    },
    
    recentIdeas : function(component, event, helper) {
        console.log('on click of recent ::::');
        var pageSize = component.get("v.pageSize");
        var action = component.get('c.fetchAllRecentIdeas');     
        var pageNumber = component.get("v.currentPageNumber");
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === 'SUCCESS' && component.isValid()){
                var result = response.getReturnValue();
                if( result.length > 0){
                    console.log('response inside on recent',result);
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
                    console.log('wt is getting',component.get('v.wrapPaginationList'));
                    component.set("v.TotalPages", Math.ceil(result.length / pageSize));
                }else{
                    component.set("v.isAllIdeas", false);
                    component.set("v.isNoIdeas", true);
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
        console.log('on click of trending ::::');
        var pageSize = component.get("v.pageSize");
        var action = component.get('c.fetchAllPopularIdeas');     
        var pageNumber = component.get("v.currentPageNumber");
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === 'SUCCESS' && component.isValid()){
                var result = response.getReturnValue();
                console.log('response inside on popular',result);
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
                    console.log('wt is getting',component.get('v.wrapPaginationList'));
                    component.set("v.TotalPages", Math.ceil(result.length / pageSize));
                }else{
                    component.set("v.isAllIdeas", false);
                    component.set("v.isNoIdeas", true);
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
        console.log('records per page:::',pageSize);
        var pageNumber = component.get("v.currentPageNumber");
        var PaginationIdealist = [];
        var counter = 0;
        if(pageSize > 0){
            for(var i=end+1; i<end+pageSize+1; i++)
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
            console.log('on click of next pbutton:::',component.get('v.wrapPaginationList'));
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
        console.log('records per page:::',pageSize);
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
            console.log('on click of previous pbutton:::',component.get('v.wrapPaginationList'));
            component.set("v.currentPageNumber",pageNumber-1);
            component.set("v.TotalPages", Math.ceil(idealist.length / pageSize));
        }else{
            component.set("v.isAllIdeas", false);
            component.set("v.isNoIdeas", true);
        }
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
                console.log('response inside on subidea',result);
                console.log('and no.of ideas',result.length);
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
                    console.log('wt is getting',component.get('v.wrapPaginationList'));
                    component.set("v.TotalPages", Math.ceil(result.length / pageSize));
                }else{
                    component.set("v.isAllIdeas", false);
                    component.set("v.isNoIdeas", true);
                }
            }else if(state === 'ERROR'){
                console.log(response.error);
            }else{
                console.log('UNKNOWN ERROR');
            }
        });
        $A.enqueueAction(action);
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
                // console.log('idea list:::::',result);
                //component.set('v.ideaList',result);
                if( result.length > 0){
                    component.set('v.wrapIdea',result);
                    //pagination starts here
                    component.set("v.TotalRecords", component.get("v.wrapIdea").length);
                    component.set("v.RecordStart",1);
                    component.set("v.RecordEnd",pageSize);
                    component.set("v.TotalPages", Math.ceil(result.length / pageSize));
                    var ideaPaginationList = [];
                    for(var i=0; i< pageSize; i++)
                    {
                        if(component.get("v.wrapIdea").length > i)
                            ideaPaginationList.push(response.getReturnValue()[i]);
                    }
                    component.set('v.wrapPaginationList', ideaPaginationList);
                    console.log('wt is getting',component.get('v.wrapPaginationList'));
                }else{
                    component.set("v.isAllIdeas", false);
                    component.set("v.isNoIdeas", true);
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
                    console.log('idea details are after save::::', component.get("v.IdeaDetails"));
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
    /* showAlert: function(component, event, helper) {
        console.log('after Calling helper');
        // create dynamic alert box with some initializations
        var self = this;
        var test;
        $A.createComponent(
            "c:AlertBoxCmp", {
                message: 'sdagjfvsajdlfglhaklhgdhsaldh',
                heading: 'Your Idea Posted Succesfully',
                class:'slds-theme--success',
                onOkay: component.getReference('c.closeAlert'),
                //onSecondaryOkay: alertboxContent.secondaryCallableFunction,
                buttonHeading:  $A.get("$Label.c.OK"),
                //  secondaryButtonHeading: alertboxContent.secondaryButtonHeading,
            },
            function(alertbox) {  
                if (alertbox !== undefined && alertbox !== null && alertbox.isValid()) {
                    var body = [];
                    body.push(alertbox);
                    if (!alertbox.isInstanceOf("c:AlertBoxCmp")) {
                        component.set("v.body", []);
                    } else {
                        component.set("v.body", body);
                    } 
                }
            }
            
        );
        
    },*/
    
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
})