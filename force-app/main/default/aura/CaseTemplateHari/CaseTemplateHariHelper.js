({
    fetchAccHelper : function(cmp, event, helper) {
        cmp.set('v.mycolumns', [
            	{label: 'Id', fieldName: 'Id', type: 'text'},
                {label: 'Owner Id', fieldName: 'OwnerId', type: 'Lookup'},
                {label: 'Subject', fieldName: 'linkName', type: 'url', 
            	typeAttributes: {label: { fieldName: 'Subject' }, target: '_blank'}},
                {label: 'Status', fieldName: 'Status', type: 'Picklist '}
            ]);
        var action = cmp.get("c.getWrapCaseWithCaseItems");
        action.setCallback(this, function(response){
            var state = response.getState();
            var result = response.getReturnValue();
            console.log('console console',result.length);
            if (state === "SUCCESS") {
                var caseData = response.getReturnValue();
                //var caseType = component.get("v.selTabId");
                 caseData.forEach(function(record){
                     if(record.Status =='Draft'){
                         record.linkName = '/casecreation?CaseId='+record.Id+'&mode='+'Edit';
                     }else{
                         record.linkName = '/casecreation?CaseId='+record.Id+'&mode='+'View';
                     }
                    
                });
                cmp.set("v.acctList", caseData);
                cmp.set("v.acctList1", caseData);
                
            }
        });
        $A.enqueueAction(action);
    },
    openComments : function(cmp, event, helper,mode){ 
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

    fetchCaseHelper : function(cmp, event, helper) {
        var caseType = cmp.get("v.selTabId");
        console.log('called in ',caseType);
        var caseData = cmp.get("v.acctList");
        var caseSpecificData = [];
        if(caseType != 'AllCases'){
            for(var i=0; i<caseData.length; i++){
                if(caseType == caseData[i].Status){
                    caseSpecificData.push(caseData[i]);
                }
            }
            cmp.set("v.acctList1",caseSpecificData);
        }else{
            cmp.set("v.acctList1",caseData);
        }
        
    }
})