/**
* JS controller class for contact search Lightning component.
* <p/><p/>
* @author - Narasimha
**/

({
    /**
     * Method that gets executed on page loading.
     * 
     * @param Component Component object to access the DOM.
     * @param Event Current event handler.
     * @param Helper Helper class.
     */
    
    doInit: function(component, event, helper) {
        
        component.find('CreateBtn').set("v.disabled", true);
    },
    
    /**
     * Validate Last name and Search for contacts.
     * 
     * @param Component Component object to access the DOM.
     * @param Event Current event handler.
     * @param Helper Helper class.
     */
    
    SearchContact : function(component, event, helper) {
        
        var LName = component.find("LastName");
        if(component.find("LastName").get("v.value") == '' || component.find("LastName").get("v.value") == null )
        {   LName.set("v.errors", [{
            message: "Please enter last name."
        }]);
        }
        else
        {
            
            LName.set("v.errors",null);    
            helper.searchHelper(component, event);
            component.find('CreateBtn').set("v.disabled", false);
        }
        
        
    }
    ,
    /**
     * Create new contact.
     * 
     * @param Component Component object to access the DOM.
     * @param Event Current event handler.
     * @param Helper Helper class.
     */
    
    CreateContact : function(component, event, helper) {
        
        var LName = component.find("LastName");
        if(component.find("LastName").get("v.value") == '' || component.find("LastName").get("v.value") == null )
        {   LName.set("v.errors", [{
            message: "Please enter last name."
        }]);
        }
        else
        {
            LName.set("v.errors",null);    
            helper.createContactHelper(component, event,helper);
        }
        
    },
    /**
     * Generates URL to navigate.
     * 
     * @param Component Component object to access the DOM.
     * @param Event Current event handler.
     * @param Helper Helper class.
     */
    ContactUrl : function(component, event, helper) {
         
        var viewRecordEvent = $A.get("e.force:navigateToSObject");
    	viewRecordEvent.setParams({
            
        "recordId": event.target.id
    });
    	viewRecordEvent.fire();
    } 
    
    
})