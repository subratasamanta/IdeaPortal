({
	 doInit: function(component, event, helper){
        var action = component.get('c.fetchAllIdeas');
        var pageSize = component.get("v.pageSize");
        /*action.setParams({
            'strIdeas': component.find('picklist').get('v.value')
        });*/
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === 'SUCCESS' && component.isValid()){
                var result = response.getReturnValue();
                
                component.set('v.ideaList',result);
               
               
            }else if(state === 'ERROR'){
                console.log(response.error);
            }else{
                console.log('UNKNOWN ERROR');
            }
        });
        $A.enqueueAction(action);
    },
})