({
    createObjectData: function(component, event) {
        // get the contactList from component and add(push) New Object to List  
        var RowItemList = component.get("v.caseList") == null?[]:component.get("v.caseList");
        
        RowItemList.push({
            'Licence_Name__c': '--None--',
            'Quantity__c': 0,
            'Action__c': '--None--',
            'Comments__c':'',
            'Effective_Date__c':''
        });
        // set the updated list to attribute (contactList) again    
        component.set("v.caseList", RowItemList);
    },
    // helper function for check if first Name is not null/blank on save  
    validateRequired: function(component, event) {
        var isValid = true;
        var allContactRows = component.get("v.caseList");
        for (var indexVar = 0; indexVar < allContactRows.length; indexVar++) {
            if (allContactRows[indexVar].FirstName == '') {
                isValid = false;
                alert('First Name Can\'t be Blank on Row Number ' + (indexVar + 1));
            }
        }
        return isValid;
    },
})