({
	createItem : function(component,event,helper, newItem) {
        var action = component.get("c.saveItem");
        action.setParams({
            "newItem": newItem
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var items = component.get("v.items");
                items.push(response.getReturnValue());
                component.set("v.items", expenses);
            }
        });
        $A.enqueueAction(action);
    }})