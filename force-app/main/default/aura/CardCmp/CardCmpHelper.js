({
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
    
})