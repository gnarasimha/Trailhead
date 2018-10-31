({
    ClearFields : function(component, event, helper) 
    {
        
        component.find('StatusContainer').set("v.value","None");
        component.find('OriginContainer').set("v.value","None");
        component.find('caseCommentContainer').set("v.value","");
    },
    
    createNewCase : function(component,event,helper)
    {  
        
        var caseComment = component.find("caseCommentContainer");
        var status = component.find("StatusContainer");
        var origin = component.find("OriginContainer");
        
        status.showHelpMessageIfInvalid();
        origin.showHelpMessageIfInvalid();
        caseComment.showHelpMessageIfInvalid();
        
        if(status.get("v.validity").valid && origin.get("v.validity").valid && caseComment.get("v.validity").valid )
            
        { 
           
            helper.createCaseHelper(component,event,helper);
        }
        
        
        
        
    } 
})