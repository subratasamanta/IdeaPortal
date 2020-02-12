({
    fetchAccHelper : function(component, event, helper) {
        component.set('v.mycolumns', [
            {label: 'Id', fieldName: 'Id', type: 'text'},
                {label: 'Owner Id', fieldName: 'OwnerId', type: 'Lookup'},
                {label: 'Subject', fieldName: 'Subject', type: 'Text'},
                {label: 'Status', fieldName: 'Status', type: 'Picklist '}
            ]);
        var action = component.get("c.getWrapCaseWithCaseItems");
        action.setParams({
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            var result = response.getReturnValue();
            //console.log('console console',result.length);
            if (state === "SUCCESS") {
                component.set("v.acctList", response.getReturnValue());
            }
            // Used for the setting the boolean var in component
            /*if (result.length > 0){
                for (var i =0 ; i < result.length ; i++){
                    var status = result[i].objCaseRecord.Status;
                    console.log('called in to status',status);
                    if (status == "Draft"){
                        console.log('called in if', status);
                        component.set("v.linkView", true);
                    }
                    else{
                        console.log('called in else', status);
                        component.set("v.linkView", false);
                    }
                }
            }*/
        });
        $A.enqueueAction(action);
    },
    openComments : function(component, event, helper,mode){ 
        var id = event.target.id;
        console.log('called in to check',id);
        var urlEvent = $A.get("e.force:navigateToURL");
        if(id && mode){
            urlEvent.setParams({
                "url": "/casecreation?CaseId=" +id+'&mode='+mode
            }); 
        }else{
             urlEvent.setParams({
                "url": "/casecreation"
            }); 
        }
       
        urlEvent.fire();
    },

    /*var action = component.get("c.getWrapCaseWithCaseItems");
        action.setParams({
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                var urlEvent = $A.get("e.force:navigateToURL");
                 urlEvent.setParams({
                 "url": '/casecreation?CaseId='+result
                });
               urlEvent.fire();
            }
        });
        $A.enqueueAction(action);*/
})