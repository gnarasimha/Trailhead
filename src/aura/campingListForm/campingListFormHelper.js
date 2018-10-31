({
	createItem : function(component,event,newItem) {
        var item = component.get("v.item");
        var addItemEvent  = component.getEvent("addItem");
        addItemEvent.setParams({ "item": item });
        addItemEvent.fire();
        
        component.set("v.newItem", "{'sobjectType':'Camping_Item__c','Name':'',Quantity__c': 0,'Price__c': 0}");
    }})