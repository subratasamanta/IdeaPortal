({
	doInit : function(component, event, helper) {
        component.set("v.showSpinner",true);
        var url = $A.get('$Resource.backgroundIdea');
        component.set('v.backgroundImageURL', url);
        var caseIdVar ='';
        var modeVar ='';
        var sPageURL = decodeURIComponent(window.location.search.substring(1)); //You get the whole decoded URL of the page.
        var sURLVariables = sPageURL.split('&'); //Split by & so that you get the key value pairs separately in a list
        var sParameterName;
        var i;
        console.log('sURLVariables::'+sURLVariables);
        if(sURLVariables.length>0){
        	for (i = 0; i < sURLVariables.length; i++) {
                sParameterName = sURLVariables[i].split('='); //to split the key from the value.
                if (sParameterName[0] === 'CaseId') { //lets say you are looking for param name - firstName
                    sParameterName[1] === undefined ? 'Not found' : sParameterName[1];
                    caseIdVar = sParameterName[1];
                }
                if (sParameterName[0] === 'mode') { //lets say you are looking for param name - firstName
                    sParameterName[1] === undefined ? 'Not found' : sParameterName[1];
                    modeVar = sParameterName[1];
                }
            }  
        }
        
        //console.log('caseIdVar::'+caseIdVar+'::modeVar::'+modeVar);
        if(caseIdVar != ''){
            helper.getCaseInfo(component, event, helper,caseIdVar);
            if(modeVar == 'View'){
                component.set("v.disabled",true);
                component.set("v.headerLabel",'View');
            }else if(modeVar == 'Edit'){
                component.set("v.disabled",false);
                component.set("v.showSubmit",true);
                component.set("v.headerLabel",'Edit');
            }else{
                component.set("v.disabled",false);
                component.set("v.headerLabel",'Create');
            }
        }else{
            var varWrpList = component.get("v.wrapCase") ? component.get("v.wrapCase"):{};
            varWrpList.caseobj = {
                'sobjectType':'Case',
                'Status': '',
                'Priority': '',
                'Subject': '',
                'Salesforce_Org_Id__c':'',
                'Comments__c':''}
            varWrpList.caseLineItem = [];
            component.set("v.wrapCase", varWrpList); 
            helper.pushLineItem(component, event, helper);
            component.set("v.headerLabel",'Create');
        }
        component.set("v.showSpinner",false);
        
	},
   
    SaveCase:  function(component, event, helper) {
        helper.showLoader(component, event, helper);
        helper.saveCaseHelper(component, event, helper);
    },
    submitCase:  function(component, event, helper) {
        helper.showLoader(component, event, helper);
        helper.updateCaseHelper(component, event, helper);
    },
    cancel :function(component, event, helper) {
         helper.redirectDetailComponent(component, event,helper);
    },
    AddNewRow : function(component, event, helper) {
        if(!component.get('v.disabled')){
            helper.pushLineItem(component, event, helper);
        }
        
    },
    removeRow : function(component, event, helper) {
        if(!component.get('v.disabled')){
            helper.removeItems(component, event, helper);
        }
    }
})