@isTest
private class BusAvailableTriggerTest {

	@TestSetup
	static void setup(){
		Account acc = new Account(Name = 'TestAcc', State__c = 'TX');
		insert acc;
		Bus__c bus = new Bus__c(Color__c = 'black', Mark__c = 'KIA',
		Count_of_seats__c = 4, Account__c = acc.Id, Available__c = true, RegistrationNumber__c = '1234', Series__c = 'AS');
		insert bus;
		Line__c line = new Line__c(Name = 'testLine');
		insert line;
		Bus_Line__c busline = new Bus_Line__c(Bus__c = bus.Id, Line__c = line.Id);
		insert busline;
	}

	@isTest
	static void testInsertBusLine() {
		List<Bus_Line__c> busLines = [Select Bus__c From Bus_Line__c];
		System.assert(!busLines.isEmpty(), 'List of BusLines is empty');

		checkBusAvailable(busLines[0].Bus__c, false);
	}

	@isTest
	static void testDeleteBusLine() {
		List<Bus_Line__c> busLines = [Select Id, Bus__c From Bus_Line__c];
		System.assert(!busLines.isEmpty(), 'List of BusLines is empty');
		Bus_Line__c busLine = busLines[0];

		Test.startTest();
		Database.DeleteResult result = Database.delete(busLine.Id);
		System.assert(result.isSuccess(), 'Delete result operation is not finished successfully');
		Test.stopTest();
		checkBusAvailable(busLine.Bus__c, true);
	}

	@isTest
	static void testUpdateBusLine() {
		List<Bus_Line__c> busLines = [Select Id, Bus__c From Bus_Line__c];
		System.assert(!busLines.isEmpty(), 'List of BusLines is empty');
		Bus_Line__c busLine = busLines[0];

		Account acc = new Account(Name = 'TestAccs', State__c = 'TX');
		insert acc;
		Bus__c busNew = new Bus__c(Color__c = 'white', Mark__c = 'KIA',
		Count_of_seats__c = 4, Account__c = acc.Id, Available__c = true, RegistrationNumber__c = '1234', Series__c = 'AS');
		insert busNew;
		Id busOldId = busLine.Bus__c;

		Test.startTest();
		busLine.Bus__c = busNew.Id;
		update busLine;
		Test.stopTest();

		checkBusAvailable(busOldId, true);
		checkBusAvailable(busNew.Id, false);
	}

	@isTest
	static void checkDuplicateTest() {
		List<Bus_Line__c> busLines = [Select Bus__c, Line__C From Bus_Line__c];
		System.assert(!busLines.isEmpty(), 'List of BusLines is empty');
		Bus_Line__c busLine = busLines[0];

		try {
			insert new Bus_Line__c(Bus__c = busLine.Bus__c, Line__c = busLine.Line__c);
			System.assert(false, 'Duplicate record has been inserted');
		} catch (Exception ex) {}
	}

	private static void checkBusAvailable(Id busId, Boolean expected) {
		List<Bus__c> buses = [Select Available__c From Bus__c Where Id = :busId];
		System.assert(!buses.isEmpty(), 'Error! List is empty');

		System.assertEquals(expected, buses[0].Available__c, 'Available field does not match expected value');
	}
}