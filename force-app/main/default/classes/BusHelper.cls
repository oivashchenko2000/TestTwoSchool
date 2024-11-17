public class BusHelper {

	public static List<Models.Bus> buildBuses(Id recordId) {
		List<Models.Bus> buses = new List<Models.Bus>();
		Map<Id, List<Models.Line>> busIdToLines = new Map<Id, List<Models.Line>>();

		for (Bus_Line__c busLine : BusLineDAO.findBusLineByAccount(recordId)) {
			if (!busIdToLines.containsKey(busLine.Bus__c)) {
				busIdToLines.put(busLine.Bus__c, new List<Models.Line>());
			}
			busIdToLines.get(busLine.Bus__c).add(new Models.Line(busLine.Line__r.Name));
		}

		for (Bus__c bus : BusLineDAO.findBusesBySetId(busIdToLines.keySet())) {
			buses.add(new Models.Bus(bus, busIdToLines.get(bus.Id)));
		}
		return buses;
	}
}