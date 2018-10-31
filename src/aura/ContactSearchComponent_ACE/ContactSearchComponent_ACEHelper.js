/**
* JS Helper class for contact search Lightning component.
* <p/><p/>
* @author - Narasimha
**/

({
    
    /**
     * Method to search contacts based on FirstName and LastName.
     * 
     * @param Component Component object to access the DOM.
     * @param Event Current event handler.
     * @param Helper Helper class.
     */
    
    searchHelper : function(component, event, helper) {
        this.logExecution(true, 'searchHelper');
        var action = component.get("c.fetchContacts");
        //Set Method Parameters.
        action.setParams({
            'strFirstName': component.find("FirstName").get("v.value"),
            'strLastName' : component.find("LastName").get("v.value")
        });
        
        //Define CallBack action.
        action.setCallback(this, function(response) {
            this.logExecution(true, 'searchHelper-callback');
            var state = response.getState();
            if (state === "SUCCESS") {
                	
                var storeResponse = response.getReturnValue();
                
                if (storeResponse.length == 0) {
                    component.set("v.infoMessage", true);
                } else {
                    component.set("v.infoMessage", false);
                }
                component.set("v.lstContactResult", storeResponse);
                
            }
            this.logExecution(false, 'searchHelper-callback');
        });
        $A.enqueueAction(action);
        this.logExecution(false, 'searchHelper');
    },
    /**
     * Method to create new contact.
     * 
     * @param Component Component object to access the DOM.
     * @param Event Current event handler.
     * @param Helper Helper class.
     */
    
    createContactHelper : function(component, event, helper){
        this.logExecution(true, 'createContactHelper');
        var action = component.get("c.createContact");
        
        //Set Method Parameters.
        action.setParams({
            'strFirstName': component.find("FirstName").get("v.value"),
            'strLastName' : component.find("LastName").get("v.value")
        });
        //Define CallBack action.
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") 
            {
                
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title: 'Success Message',
                    message: 'Contact Created successfully',
                    duration: '5000',
                    key: 'info_alt',
                    type: 'success',
                    mode: 'pester'
                });
                toastEvent.fire(); 
            }
        });
        $A.enqueueAction(action);
        this.logExecution(false, 'createContactHelper');
    },
    /**
     * Method that logs the execution time between methods.
     * 
     * @param boolIsStart Defines if the operation should log and starting point or ending point.
     * @param strMethod Name of the current method.
     */
	logExecution : function(boolIsStart, strMethod) {
		var strOperation = 'Stopping execution: ';
        var objCurrentDateTime = new Date();
        var strTabs = '';
        for(var intCounter = 0; intCounter < 35 - strMethod.length; intCounter++) {
        	strTabs += ' ';
        }
        var strHours = objCurrentDateTime.getHours();
        var strMinutes = objCurrentDateTime.getMinutes();
        var strSeconds = objCurrentDateTime.getSeconds();
        var strMilliseconds = objCurrentDateTime.getMilliseconds();
        if(strHours < 10) {
        	strHours = '0' + strHours;
        }
        if(strMinutes < 10) {
        	strMinutes = '0' + strMinutes;
        }
        if(strSeconds < 10) {
        	strSeconds = '0' + strSeconds;
        }
        if(strMilliseconds < 100) {
        	strMilliseconds = '0' + strMilliseconds;
        }
		var strDatetime = strTabs + strHours + ":" + strMinutes + ":" + strSeconds + ":" + strMilliseconds;
		if(boolIsStart != null && boolIsStart) {
			strOperation = 'Starting execution: ';
		}
		console.log(strOperation + strMethod + strDatetime);
	} 
})