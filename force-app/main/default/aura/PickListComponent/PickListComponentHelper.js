({
	fetchTypePicklist : function(component){
        var action = component.get("c.getPicklistvalues");
        action.setParams({
            'objectName': component.get("v.objectName"),
            'field_apiname': component.get("v.fieldApiName"),
            'nullRequired': component.get("v.nullrequired") 
        });
        action.setCallback(this, function(a){
            var state = a.getState();
            if (state === "SUCCESS"){
                var items = a.getReturnValue();
                var item = [];
                console.log(a.getReturnValue());
                for(var i=0;i<items.length;i++){
                    var obj = {};
                    obj.label=items[i];
                    obj.value=items[i];
                    item.push(obj);
                }
                component.set("v.items", item);
                component.set("v.selectedValue", component.get('v.selectedValue')) 
            } 
        });
        $A.enqueueAction(action);
    },
})