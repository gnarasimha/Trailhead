/**
* JS controller class for CreateCase Lightning component.
* <p/><p/>
* @author Narasimha
**/
({
    
/*
*  method for clearing form Inputs.
* 
*/ 
	ClearFields : function(component, event, helper) 
    {
        //Clear form inputs.
        component.find('StatusContainer').set("v.value","None");
        component.find('OriginContainer').set("v.value","None");
        component.find('caseCommentContainer').set("v.value","");
    },
/*
*  method to create new Case.
* 
*/    
    createNewCase : function(component,event,helper)
    {  
        //Initialize variables.
        var caseComment = component.find("caseCommentContainer");
        var status = component.find("StatusContainer");
        var origin = component.find("OriginContainer");
        
        // Display error message on validation
        status.showHelpMessageIfInvalid();
        origin.showHelpMessageIfInvalid();
        caseComment.showHelpMessageIfInvalid();
        
        //call helper method after validation
        if(status.get("v.validity").valid && origin.get("v.validity").valid && caseComment.get("v.validity").valid )
        {            
            helper.createCaseHelper(component,event,helper);
        }        
    } 
})