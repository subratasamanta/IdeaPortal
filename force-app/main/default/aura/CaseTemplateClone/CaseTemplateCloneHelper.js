({
    fetchAccHelper : function(component, event, helper) {
        component.set('v.mycolumns', [
            {label: 'Id', fieldName: 'Id', type: 'text', sortable: true},
            {label: 'Owner Name', fieldName: 'Name', type: 'text'},
            {label: 'Subject', fieldName: 'Subject', type: 'Text'},
            {label: 'Status', fieldName: 'Status', type: 'Picklist '},
            {label: 'Created Date', fieldName: 'CreatedDate', type: 'date-local'},
            {label: 'View', fieldName: 'View', type: 'button', initialWidth: 135, typeAttributes: { label: 'View Details', name: 'view_details', title: 'Click to View Details'}}]);
        
        var action = component.get("c.getWrapCaseWithCaseItems");
        action.setParams({
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            var result = response.getReturnValue();
            console.log('console console',result.length);
            if (state === "SUCCESS") {
                component.set("v.acctList", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },
    openCase : function(component, event, helper,mode){ 
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
    
    fetchCaseHelper : function(component, event, helper) {
        var caseType = component.get("v.selTabId");
        component.set('v.mycolumns', [
            {label: 'Case Number', fieldName: 'LinkCaseId', type: 'url', sortable: true,typeAttributes: {label: { fieldName: 'CaseNumber' }, target: '_self',tooltip: 'Click to visit reocrd' }},
            {label: 'Owner Name', fieldName: 'OwnerId', type: 'String', sortable: true},
            {label: 'Subject', fieldName: 'Subject', type: 'Text', sortable: true},
            {label: 'Status', fieldName: 'Status', type: 'Picklist ', sortable: true},
            {label: 'Created Date', fieldName: 'CreatedDate', type: 'date-local', sortable: true} ]);
        //{label: 'View', fieldName: 'View', type: 'button', initialWidth: 135, typeAttributes: { label: 'View Details', name: 'view_details', title: 'Click to View Details'}}
        var action = component.get("c.fetchCase");
        action.setParams({
            "caseType" :  caseType
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            console.log('called in to check the result',result);
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                var countVar = [];
                var submittedCount = 0;
                var draftCount = 0;
                var closedCount = 0;
                var InprogressCount = 0;
                var  allCasesCount = result.length;
                var url = window.location.href;
                var geturl = url.split('/tavantcustomerportal')[0];
                component.set('v.allCounts',allCasesCount);
                for(var i=0; i<result.length; i++){
                    if(result[i].Status=='Submitted'){
                        submittedCount++;
                        component.set('v.submittedCounts',submittedCount);
                    }
                    if(result[i].Status=='Draft'){
                        draftCount++;
                        component.set('v.draftCounts', draftCount);
                    }
                    if (result[i].Status=='Closed'){
                        closedCount++;
                        component.set('v.closedCounts', closedCount);
                    }
                    if (result[i].Status=='In progress'){
                        InprogressCount++;
                        component.set('v.inProgressCounts', InprogressCount);
                    }
                }
                var dataTemp = response.getReturnValue();
                for(var i=0; i< dataTemp.length; i++){
                    dataTemp[i].OwnerId = dataTemp[i].Owner.Name;
                    if(dataTemp[i].Status == 'Draft' ){
                        dataTemp[i].LinkCaseId = geturl+'/tavantcustomerportal/s/casecreation?CaseId='+dataTemp[i].Id+'&mode=Edit';
                    }else{
                        dataTemp[i].LinkCaseId = geturl+'/tavantcustomerportal/s/casecreation?CaseId='+dataTemp[i].Id+'&mode=View';
                    }
                }
                
                component.set("v.acctList1", dataTemp);               
                component.set('v.Counts', result.length);
                helper.sortData(component, component.get("v.sortedBy"), component.get("v.sortedDirection"));
            }
        });
        $A.enqueueAction(action);
    },
    
    sortData: function (cmp, fieldName, sortDirection) {
        var data = cmp.get("v.acctList1");
        var reverse = sortDirection !== 'asc';
        data.sort(this.sortBy(fieldName, reverse))
        cmp.set("v.acctList1", data);
    },
    
    sortBy: function (field, reverse, primer) {
        var key = primer ?
            function(x) {return primer(x[field])} :
        function(x) {return x[field]};
        reverse = !reverse ? 1 : -1;
        return function (a, b) {
            return a = key(a), b = key(b), reverse * ((a > b) - (b > a));
        }
    }
})