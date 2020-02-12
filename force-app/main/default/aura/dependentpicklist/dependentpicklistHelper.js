({
     getStatusPicklistValues : function(component, event, helper){
         console.log('calling status functionS');
        var action = component.get("c.getPicklistvalues");
         console.log('ststu value::::',action);
            console.log('calling the apex meethos');
        action.setParams({
            objectName : component.get("v.objDetail"),
            field_apiname: component.get("v.status")
        });
        var opts = [];
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var allValues = response.getReturnValue();
                console.log(' respose is::::',allValues);
                if (allValues != undefined && allValues.length > 0) {
                    
                    for (var i = 0; i < allValues.length; i++) {
                        opts.push({
                            class: "optionClass",
                            label: allValues[i],
                            value: allValues[i]
                        });
                    }
                     console.log('pickListOptions::::',component.get("v.pickListOptions"));
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
               // console.log('status++++',response);
                var StoreResponse = response.getReturnValue();
               // console.log('list of values++++',StoreResponse);
                
                component.set("v.depnedentFieldMap",StoreResponse);
                var listOfkeys = []; 
                var ControllerField = []; 
                for (var singlekey in StoreResponse) {
                    listOfkeys.push(singlekey);
                }
                
                if (listOfkeys != undefined && listOfkeys.length > 0) {
                    ControllerField.push('--- None ---');
                }
                for (var i = 0; i < listOfkeys.length; i++) {
                    ControllerField.push(listOfkeys[i]);
                }  
                component.set("v.ControllingpickListOptions", ControllerField);
                //console.log('list of Controlling values++++',component.get("v.ControllingpickListOptions"));
                
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
    displayAllIdeas: function(component, event, helper){
        var action = component.get('c.getIdeasWithComments');
        var pageSize = component.get("v.pageSize");
      
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === 'SUCCESS' && component.isValid()){
                var result = response.getReturnValue();
                //console.log('response+++++',result);
                //component.set('v.ideaList',result);
                component.set('v.wrapIdea',response.getReturnValue());
                //console.log('idea response+++++', JSON.stringify(response.getReturnValue()));

                //pagination starts here
                component.set("v.totalIdeas", component.get("v.ideaList").length);
                component.set("v.startPage",0);
                component.set("v.endPage",pageSize-1);
                
                var ideaPaginationList = [];
                for(var i=0; i< pageSize; i++)
                {
                    if(component.get("v.ideaList").length> i)
                        ideaPaginationList.push(result[i]);    
                }
                component.set('v.ideaPaginationList', ideaPaginationList);
                //console.log('Pagination '+JSON.stringify(component.get('v.ideaPaginationList')));
            }else if(state === 'ERROR'){
                console.log(response.error);
            }else{
                console.log('UNKNOWN ERROR');
            }
        });
        $A.enqueueAction(action);
    },
    recentIdeas : function(component, event, helper) {
        var action = component.get('c.fetchAllRecentIdeas');
        var pageSize = component.get("v.pageSize");
        
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === 'SUCCESS' && component.isValid()){
                var result = response.getReturnValue();
                component.set('v.ideaList',result);
                
                component.set("v.totalIdeas", component.get("v.ideaList").length);
                component.set("v.startPage",0);
                component.set("v.endPage",pageSize-1);
                
                var ideaPaginationList = [];
                for(var i=0; i< pageSize; i++)
                {
                    if(component.get("v.ideaList").length> i)
                        ideaPaginationList.push(result[i]);    
                }
                component.set('v.ideaPaginationList', ideaPaginationList);
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
        console.log('called in for console check',objIdea.Ideas__c);
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
                console.log(state);
                if(state === 'SUCCESS' && component.isValid()){
                    
                    //Reset Form
                    var newIdeaList= {'sobjectType': 'Idea__c',
                                      'Name': '',
                                      'Idea_Description__c': ' ',
                                      'Ideas__c':'',
                                      'SubIdeas__c':''
                                     };
                    
                    component.set("v.IdeaDetails", newIdeaList);
                    component.set("v.isOpenModal",false)
                   // component.set("v.isPosted", true);
                    var showToast = $A.get("e.force:showToast"); 
                    showToast.setParams({ 
                        'title' : 'Success Message', 
                        'message' : 'The Idea has been Submitted sucessfully.',
                        'type': 'success',
                        'mode': 'pester'
                    }); 
                    showToast.fire(); 
                    
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
        console.log('comment::::',objComments);
         var rowIndex = event.getSource().get("v.tabindex"); 
        var listIndx = component.get("v.wrapIdea");
        var ideaId = listIndx[rowIndex].objIdeaRecord.Id;
        console.log('IdeaId::::',ideaId);
        var action = component.get("c.saveComment");
          action.setParams({
            'StrIdea':ideaId,
             'strbody':objComments.CommentBody__c
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            var result = response.getReturnValue();
            console.log(state);
            if(state === 'SUCCESS' ){
                var newComments= {'sobjectType': 'Comment__c',
                                  'CommentBody__c': '',
                                  'UpVotes__c': ' ',
                                  'Idea__c':''
                                 };
                                 
                component.set("v.Comments", newComments);
                console.log('comentSaved', component.get("v.Comments"));
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
    next : function(component, event, helper){
        var idealist = component.get("v.ideaList");
        var end = component.get("v.endPage");
        var start = component.get("v.startPage");
        var pageSize = component.get("v.pageSize");
        var PaginationIdealist = [];
        
        var counter = 0;
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
        
        component.set("v.startPage",start);
        console.log('In first Page',  component.get("v.startPage"));
        
        component.set("v.endPage",end);
        console.log('Inlast Page',  component.get("v.endPage"));
        
        component.set('v.ideaPaginationList', PaginationIdealist);
        console.log('in next page',component.get('v.ideaPaginationList'));
        
    },
    previous : function(component, event, helper) 
    {
        var idealist = component.get("v.ideaList");
        var end = component.get("v.endPage");
        var start = component.get("v.startPage");
        var pageSize = component.get("v.pageSize");
        var PaginationIdealist = [];
        
        var counter = 0;
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
        
        component.set("v.startPage",start);
        console.log('In first Page',  component.get("v.startPage"));
        
        component.set("v.endPage",end);
        console.log('Inlast Page',  component.get("v.endPage"));
        
        component.set('v.ideaPaginationList', PaginationIdealist);
        console.log('in Previous page',component.get('v.ideaPaginationList'));
        
    }
})