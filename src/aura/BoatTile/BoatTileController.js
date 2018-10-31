({

    onBoatClick : function(component, event, helper) {

        var BoatSelectEvent = component.getEvent('BoatSelect');

        var boat = component.get('v.boat');

        BoatSelectEvent.setParams({

            "boatId" : boat.Id

        });

        BoatSelectEvent.fire();

        var createEvent = $A.get("e.c:PlotMapMarker");

        createEvent.setParams({'sObjectId' : boat.id});

        createEvent.fire();

        //var BoatSelectedEvt = component.getEvent('boatselected');

        var BoatSelectedEvt = $A.get('e.c:BoatSelected');

        BoatSelectedEvt.setParams({

            "boat" : boat

        });     

        BoatSelectedEvt.fire();

    }

})