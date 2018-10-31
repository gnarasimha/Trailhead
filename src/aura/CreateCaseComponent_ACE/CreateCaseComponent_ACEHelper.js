/**
* JS Helper class for CreateCase Lightning component.
* <p/><p/>
* @author Narasimha
**/
({
    
/*
*  method to create new Case.
* 
*/    
    createCaseHelper : function(component, event, helper) 
    {
        //Initialize action
        var action = component.get("c.createCase");
        
        //Set apex method parameters.
        action.setParams({
            
            'strStatus': component.find("StatusContainer").get("v.value"),
            'strOrigin': component.find("OriginContainer").get("v.value"),
            'strComment': component.find("caseCommentContainer").get("v.value"),
            'strContactId': component.get("v.recordId")
        });
        
        // Define method callBack
        action.setCallback(this, function(response) {
            
            var state = response.getState();
            var storeResponse = response.getReturnValue();
            if (state === "SUCCESS" && storeResponse != null && storeResponse != 'undefined') {
                 
                //Set variables on error
                if(storeResponse.length > 1)
                {
                    component.set("v.boolErrorFlag", true);
                    component.set("v.strErrorlogNumber", storeResponse[1]);      
                }
                //Set variables on success and fire event
                else
                {
                    component.set("v.boolSuccessFlag", true);
                    var evt = $A.get("e.c:newCaseEvt_ACE");
                    evt.setParams({
                        "strCaseComment": storeResponse[0]
                    });
                    evt.fire();     }
            }
        });
        $A.enqueueAction(action);
    },
})