({
	validateCaseItems: function(component, event,helper) {
        debugger;
        var isValid = true;
        var allCaseItems = component.get("v.wrapCase.caseLineItem");
         var set1 = new Set(); 
        for (var indexVar = 0; indexVar < allCaseItems.length; indexVar++) {
           var item = JSON.parse(JSON.stringify(allCaseItems[indexVar]));
            if(item.Licence_Name__c != '--None--' && !set1.has(item.Licence_Name__c)){
                set1.add(item.Licence_Name__c);
            }else if(set1.has(item.Licence_Name__c)){
                isValid = false;
                helper.showToast(component, event, helper,'Remove '+ item.Licence_Name__c +' Duplicate Licence','Error!','error'); 
            }
            if(item.Licence_Name__c == '--None--'){
                isValid = false;
                helper.showToast(component, event, helper,'Please select Licence','Error!','error'); 
            }else if(item.Quantity__c == null ||item.Quantity__c == undefined ||  item.Quantity__c == '' || item.Quantity__c == 0){
                 isValid = false;
                helper.showToast(component, event, helper,'Please enter No. of Licence','Error!','error'); 
            }else if(item.Effective_Date__c == '' || !item.Effective_Date__c){
                isValid = false;
                helper.showToast(component, event, helper,'Please select Effective Date','Error!','error'); 
            }else if(item.Effective_Date__c != '' && item.Effective_Date__c){
                isValid = this.validateDate(item.Effective_Date__c);
                if(!isValid){
                	helper.showToast(component, event, helper,'Past date is not applicable','Error!','error');                     
                }                
            }else if(item.Action__c == '--None--' || item.Action__c == ''){
                isValid = false;
                helper.showToast(component, event, helper,'Please select Action','Error!','error'); 
            }
        }
        return isValid;
    },
    saveCaseHelper : function(component, event,helper) {
        if(!helper.validateCaseField(component, event,helper)){
            helper.hideLoader(component, event,helper);
            return false;
        }
        if(!helper.validateCaseItems(component, event,helper)){
            helper.hideLoader(component, event,helper);
            return false;
        }
       var action = component.get("c.createCase");      
        action.setParams({
            "properties":JSON.stringify(component.get("v.wrapCase"))
        });
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                helper.hideLoader(component, event,helper);
                component.set('v.wrapCase',response.getReturnValue());
                helper.showToast(component, event, helper,'Your case is drafted in system.','Success!','success'); 
                component.set('v.showSubmit',true);
                //helper.resetValues(component, event,helper);
                //helper.redirectDetailComponent(component, event,helper,allValues);
            }
        });
        $A.enqueueAction(action);
   
    },
    validateCaseField : function(component, event,helper) {
        if(component.get('v.wrapCase.caseobj.Subject') == '' || !component.get('v.wrapCase.caseobj.Subject')){
            helper.showToast(component, event, helper,'Please enter subject','Error!','error');
            return false;
        }else if(component.get('v.wrapCase.caseobj.Salesforce_Org_Id__c') == ''){
            helper.showToast(component, event, helper,'Please enter Salesforce Org Id','Error!','error');
            return false;
        }else if(component.get('v.wrapCase.caseobj.Salesforce_Org_Id__c') != ''){
            if(component.get('v.wrapCase.caseobj.Salesforce_Org_Id__c').length == 15){
                return true;
            }else{
            	helper.showToast(component, event, helper,'Please enter 15 digit Salesforce Org Id','Error!','error');
                return false;
            }          
        }
        return true;
    },
    showToast : function(component, event, helper,message,title,type) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": title,
            "message": message,
            "type":type
        });
        toastEvent.fire();
    },
    showLoader:function(component, event, helper){
        component.set('v.showLoader',true)
    },
    hideLoader:function(component, event, helper){
        component.set('v.showLoader',false)
    },
    redirectDetailComponent:function(component,event,helper){
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": '/case/Case/Recent'
        });
        urlEvent.fire();
    },
    resetValues :function(component, event, helper){
        component.set('v.caseSubject','');
        component.set('v.sfOrgId','')
        component.set('v.selectedStatus','Draft')
        component.set('v.selectedPriority','--None--');
        component.set('v.comments','');
        //component.set('v.caseDescription','');
        var RowItemList = [];
        RowItemList.push({
            'Licence_Name__c': '--None--',
            'Quantity__c': '',
            'Action__c': '--None--',
            'Comments__c':'',
            'Effective_Date__c':''
        });
        // set the updated list to attribute (contactList) again    
        
    },
    updateCaseHelper : function(component, event,helper) {
        if(!helper.validateCaseField(component, event,helper)){
            helper.hideLoader(component, event,helper);
            return false;
        }
        if(!helper.validateCaseItems(component, event,helper)){
            helper.hideLoader(component, event,helper);
            return false;
        }
        var caseInfo  = component.get("v.wrapCase");
        if(caseInfo.caseobj.Case_Line_Items__r){
            delete caseInfo.caseobj.Case_Line_Items__r;
            component.set("v.wrapCase",caseInfo);
        }
        var action = component.get("c.updateCase");
        component.set("v.wrapCase.caseobj.Status",'Submitted')
        action.setParams({
            "properties":JSON.stringify(component.get("v.wrapCase"))
        });
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                helper.hideLoader(component,event,helper);
                helper.showToast(component, event, helper,'Your case is submitted in system.','Success!','success'); 
                component.set("v.disabled",'true')
                //helper.resetValues(component, event,helper);
                helper.redirectDetailComponent(component, event,helper);
            }
        });
        $A.enqueueAction(action);
   
    },
    getCaseInfo : function(cmp, event,helper,caseIdVar) {
        var action = cmp.get("c.getCaseData");      
        action.setParams({
            "caseId":caseIdVar
        });
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var resVar = response.getReturnValue();
                cmp.set("v.wrapCase",response.getReturnValue()); 
            }
        });
        $A.enqueueAction(action);
   
    },
    pushLineItem : function(cmp, event,helper){
        var varWrpList = cmp.get("v.wrapCase.caseLineItem");
        
        varWrpList.push({
            'sobjectType':'Case_Line_Item__c',
            'Licence_Name__c': '--None--',
            'Quantity__c': 0,
            'Action__c': '--None--',
            'Comments__c':'',
            'Effective_Date__c':''
        });
        cmp.set("v.wrapCase.caseLineItem",varWrpList);
    },
    
    removeItems :  function(cmp, event,helper){
       
        var index = event.target.getAttribute('data-index');
        var AllRowsList = cmp.get("v.wrapCase.caseLineItem");
         AllRowsList.splice(index-1, 1);
        // set the contactList after remove selected row element  
        cmp.set("v.wrapCase.caseLineItem", AllRowsList);
    },
    validateDate:  function(providedDate){
        var today = new Date();        
        var dd = today.getDate();
        var mm = today.getMonth() + 1; //January is 0!
        var yyyy = today.getFullYear();
     	// if date is less then 10, then append 0 before date   
        if(dd < 10){
            dd = '0' + dd;
        } 
    	// if month is less then 10, then append 0 before date    
        if(mm < 10){
            mm = '0' + mm;
        }        
     	var todayFormattedDate = yyyy+'-'+mm+'-'+dd;
        if(providedDate != '' && providedDate < todayFormattedDate){
            return false;
            //component.set("v.dateValidationError" , true);
        }else{
            return true;
            //component.set("v.dateValidationError" , false);
        }
    }    
    
})