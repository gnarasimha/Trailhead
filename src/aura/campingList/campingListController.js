({
        // Load expenses from Salesforce
    doInit: function(component, event, helper) {
        // Create the action
        var action = component.get("c.getItems");
        // Add callback behavior for when response is received
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.items", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
    },
    
    clickCreateItem : function(component, newItem) 
    {
         helper.createItem(component, newItem);
        
        
    },
    handleAddItem: function(component, event, helper) {
        var addedItem = event.getParam("item");
        var action = component.get("c.saveItem");
        action.setParams({
            "newItem": addedItem
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
      //  helper.createItem(component, addedItem);
    }
})