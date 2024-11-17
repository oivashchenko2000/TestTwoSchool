public with sharing class BusAvailableTriggerHelper {
	
	public static void setBusAvailable(List<Bus_Line__c> oldBusLines, List<Bus_Line__c> newBusLines) {
		Map<Id, Bus__c> idWithBuses = new Map<Id, Bus__c>();

		if (oldBusLines != null) {
			Set<Id> busIds = new Set<Id>();
			for (Bus_Line__c busLine : oldBusLines) {
				busIds.add(busLine.Bus__c);
			}
			for (AggregateResult bus : BusLineDAO.findBusCountByBusIds(busIds)) {
				String busId = (String) bus.get('busId');
				if ((Integer) bus.get('busCount') == 1) {
					idWithBuses.put(busId, new Bus__c(Id = busId, Available__c = true));
				}
			}
		}

		if (newBusLines != null) {
			for (Bus_Line__c busLine : newBusLines) {
				idWithBuses.put(busLine.Bus__c, new Bus__c(Id = busLine.Bus__c, Available__c = false));
			}
		}
		update idWithBuses.values();
	}

	public static void checkDuplicate(List<Bus_Line__c> newBusLines) {
		Set<Id> busIds = new Set<Id>();
		for (Bus_Line__c newBusLine : newBusLines) {
			busIds.add(newBusLine.Bus__c);
		}

		Map<Id, Set<Id>> busLineIds = new Map<Id, Set<Id>>();
		for (Bus_Line__c busLine : BusLineDAO.findAllBusLinesByBusId(busIds)) {
			Id busId = busLine.Bus__c;

			if (!busLineIds.containsKey(busId)) {
				busLineIds.put(busId, new Set<Id>());
			}
			Set<Id> lineIds = busLineIds.get(busId);
			lineIds.add(busLine.Line__c);	
		}
		
		for (Bus_Line__c newBusLine : newBusLines) {
			Id newBusId = newBusLine.Bus__c;
	
			if (busLineIds.keySet().contains(newBusId) && busLineIds.get(newBusId).contains(newBusLine.Line__c)) {
				newBusLine.addError('Duplicate records. Please change Bus or Line value and try again.');
			}
		}
	}
}