public class BusInfoController {

	@AuraEnabled
	public static List<Models.Bus> getBuses(Id recordId) {
		if (String.isBlank(recordId)) {
			throw new AuraHandledException('String exception');
		}
		try {
			return BusHelper.buildBuses(recordId);
		} catch (Exceptions.PortalException ex) {
			throw new AuraHandledException(ex.getMessage());
		}
	}
}