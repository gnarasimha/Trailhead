({
	createCaseHelper : function(component, event, helper) 
    {
       
		var action = component.get("c.createCase");
        action.setParams({
            
            'strStatus': component.find("StatusContainer").get("v.value"),
            'strOrigin': component.find("OriginContainer").get("v.value"),
            'strComment': component.find("caseCommentContainer").get("v.value"),
            'idContact': component.get("v.recordId")
        });
        
        
        action.setCallback(this, function(response) {
            
            var state = response.getState();
            console.log(response.getState());
            console.log(response.getReturnValue());
            if (state === "SUCCESS") {
                
                    	
                    var storeResponse = response.getReturnValue();
                    
            }
        });
        $A.enqueueAction(action);
    },
   	
})