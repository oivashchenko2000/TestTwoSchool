public class BusLineManagementController {

	@AuraEnabled
	public static List<Models.BusLine> getLinesInfo(Id busId) {
		if (busId == null || busId.getSobjectType() != Bus__c.getSobjectType()) {
			throw new AuraHandledException('Incorrect parameters provided');
		}
		try {
			return BusLineManagementHelper.buildLines(busId);
		} catch (Exceptions.PortalException ex) {
			throw new AuraHandledException(ex.getMessage());
		}
	}

	@AuraEnabled
	public static void deleteBusLine(Id busLineId) {
		if (busLineId == null || busLineId.getSobjectType() != Bus_Line__c.getSobjectType()) {
			throw new AuraHandledException('Incorrect parameters provided');
		}
		BusLineManagementHelper.deleteBusLine(busLineId);
	}

	@AuraEnabled
	public static List<Models.Line> getAllLines() {
		return BusLineManagementHelper.setupModelForLines();
	}

	@AuraEnabled
	public static Models.BusLine addNewBusLine(Id busId, Id lineId) {
		if (busId == null || busId.getSobjectType() != Bus__c.getSobjectType() || lineId == null || lineId.getSobjectType() != Line__c.getSobjectType()) {
			throw new AuraHandledException('Incorrect parameters provided');
		}
		return BusLineManagementHelper.addNewBusLine(busId, lineId);
	}
}