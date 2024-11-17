public class BusLineManagementHelper {
	
	public static List<Models.BusLine> buildLines(Id busId) {
		List<Models.BusLine> lines = new List<Models.BusLine>();

		for (Bus_Line__c busLine : BusLineDAO.findLinesByBus(busId)) {
			lines.add(new Models.BusLine(busLine));
		}
		return lines;
	}

	public static void deleteBusLine(Id busLineId) {
		if (!BusLineDAO.isBusLineExist(busLineId)) {
			throw new AuraHandledException('BusLine with current id does not exists');
		}
		Database.delete(busLineId);
	}

	public static List<Models.Line> setupModelForLines() {
		List<Models.Line> lines = new List<Models.Line>();

		for (Line__c line : BusLineDAO.findAllLines()) {
			lines.add(new Models.Line(line));
		}
		return lines;
	}

	public static Models.BusLine addNewBusLine(Id busId, Id lineId) {
		if (!BusLineDAO.findBusLineByBusAndLine(busId, lineId).isEmpty()) {
			throw new AuraHandledException('BusLine with current busId and lineId have duplicate');
		}

		Database.insert(new Bus_Line__c(Bus__c = busId, Line__c = lineId));
		return new Models.BusLine(BusLineDAO.findBusLineByBusAndLine(busId, lineId)[0]);
	}
}