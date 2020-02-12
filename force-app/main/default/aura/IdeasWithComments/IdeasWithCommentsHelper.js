({
    displayAllIdeas: function(component, event, helper){
        var ideaRecordId = component.get("v.recordId");
        var action = component.get('c.getIdeasWithComments');
        action.setParams({
            'strIdeaId': ideaRecordId
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === 'SUCCESS' && component.isValid()){
                var result = response.getReturnValue();
                console.log('responseerror',result);
                component.set('v.ideaList',result);
                component.set('v.wrapRecord',result);
                console.log('called in ',  component.get('v.wrapRecord'));
               
            }else if(state === 'ERROR'){
                console.log(result.error);
            }else{
                console.log('UNKNOWN ERROR');
            }
        });
        $A.enqueueAction(action);
    },
})