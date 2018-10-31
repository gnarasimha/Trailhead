/**
 * Controller component for Physician Search module.
 * <p /><p />
 * @author Raymundo Rodriguez Sansores
 */
({
    
    /**
     * Method that gets executed on page loading.
     * 
     * @param objComponent Component object to access the DOM.
     * @param objEvent Current event handler.
     * @param objHelper Helper class.
     */
	doInit : function(objComponent, objEvent, objHelper) {
		
        //Now we call the Search method on the Helper class.
        objHelper.doInit(objComponent);
	},
    
    /**
     * Method that shows the Advanced Search fields.
     * 
     * @param objComponent Component object to access the DOM.
     * @param objEvent Current event handler.
     * @param objHelper Helper class.
     */
	showAdvancedSearch : function(objComponent, objEvent, objHelper) {
		
        //Now we call the Search method on the Helper class.
        objHelper.showAdvancedSearch(objComponent);
	},
    
    /**
     * Method that executes the Physician search.
     * 
     * @param objComponent Component object to access the DOM.
     * @param objEvent Current event handler.
     * @param objHelper Helper class.
     */
	search : function(objComponent, objEvent, objHelper) {
		
        //Now we call the Search method on the Helper class.
        objHelper.search(objComponent);
	},
    
    /**
     * Executes the search process if the key pressed was Enter.
     * 
     * @param objComponent Component object to access the DOM.
     * @param objEvent Current event handler.
     * @param objHelper Helper class.
     */
    executeSearchFromKeyboard: function(objComponent, objEvent, objHelper) {
        
        //Now we call the Search method on the Helper class.
        if(objEvent.getParams().keyCode === 13) {
        	objHelper.search(objComponent);
    	}
	},
    
    /**
     * Shows UI messages for child components.
     * 
     * @param objComponent Component object to access the DOM.
     * @param objEvent Current event handler.
     * @param objHelper Helper class.
     */
    showMessageEvent: function(objComponent, objEvent, objHelper) {
        objHelper.showMessage(objComponent, objEvent.getParam('strMessage'), objEvent.getParam('strMessageTypeClass'));
	},
   
	/**
     * Method that shows the Time Slots modal.
     * 
     * @param objComponent Component object to access the DOM.
     * @param objEvent Current event handler.
     * @param objHelper Helper class.
     */
	showTimeSlots : function(objComponent, objEvent, objHelper) {
		
        //Now we call the Search method on the Helper class.
        objHelper.showTimeSlots(objComponent, objEvent);
	},
	
	/**
     * Method that shows the next or previous week on the Time Slots modal.
     * 
     * @param objComponent Component object to access the DOM.
     * @param objEvent Current event handler.
     * @param objHelper Helper class.
     */
	changeWeekTimeSlotTo : function(objComponent, objEvent, objHelper) {
		
        //Now we call the Search method on the Helper class.
        objHelper.changeWeekTimeSlotTo(objComponent, objEvent);
	},
    
    /**
     * Opens the selected Physician profile.
     * 
     * @param objComponent Component object to access the DOM.
     * @param objEvent Current event handler.
     * @param objHelper Helper class.
     */
    openPhysicianProfile: function(objComponent, objEvent, objHelper) {
        objHelper.openPhysicianProfile(objComponent, objEvent);
	},
    
    /**
     * Method that opens the Physician record page and updates the Case accordingly.
     * 
     * @param objComponent Component object to access the DOM.
     * @param objEvent Current event handler.
     * @param objHelper Helper class.
     */
    selectPhysician: function(objComponent, objEvent, objHelper) {
        objHelper.selectPhysician(objComponent, objEvent);
	},
    
    /**
     * Method that shows the Additional Locations of a Physician.
     * 
     * @param objComponent Component object to access the DOM.
     * @param objEvent Current event handler.
     * @param objHelper Helper class.
     */
	showAdditionalLocations : function(objComponent, objEvent, objHelper) {
		
        //Now we call the Search method on the Helper class.
        objHelper.showAdditionalLocations(objComponent, objEvent);
	}
})