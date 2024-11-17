@isTest
private class BusLineTest {

	@testSetup
	static void setup() {
		Account acc = new Account(Name = 'TestAcc', State__c = 'TX');
		insert acc;
		Bus__c bus = new Bus__c(Color__c = 'black', Mark__c = 'KIA', Model__c = 'Kia Granbird',
		Count_of_seats__c = 4, Account__c = acc.Id, Available__c = true, RegistrationNumber__c = '1234', Series__c = 'AS');
		insert bus;
		Line__c testLine = new Line__c(Name = 'testLine');
		insert testLine;
		insert new Bus_Line__c(Bus__c = bus.Id, Line__c = testLine.Id);
	}
	@isTest
	static void getBusesTest() {
		List<Account> accs = [Select Id From Account Where Name = 'TestAcc'];
		System.assert(!accs.isEmpty(), 'Error! List is empty');

		List<Models.Bus> busModels = BusInfoController.getBuses(accs[0].Id);
		System.assert(!busModels.isEmpty(), 'Error! List is empty');

		List<Bus__c> buses = [Select Name, Color__c, Model__c, Mark__c From Bus__c Where Account__c = :accs[0].Id];
		System.assert(!buses.isEmpty(), 'Error! List is empty');

		List<Bus_Line__c> busLines = [Select Line__r.Name From Bus_Line__c Where Bus__r.Account__c = :accs[0].Id];
		System.assert(!busLines.isEmpty(), 'Error! List is empty');

		List<Models.Line> lines = new List<Models.Line>();
		Bus__c bus = buses[0];
		Models.Bus busModel = busModels[0];
		for (Bus_Line__c busLine : busLines) {
			lines.add(new Models.Line(busLine.Line__r.Name));
		}
		System.assertEquals(bus.Color__c, busModel.color, 'Error! The received value does not match the expected');
		System.assertEquals(bus.Model__c, busModel.model, 'Error! The received value does not match the expected');
		System.assertEquals(bus.Mark__c, busModel.mark, 'Error! The received value does not match the expected');
	}
	@isTest
	static void getBusesExceptionTest() {
		List<Account> accs = [Select Id From Account Where Name = 'TestAcc' LIMIT 1];
		System.assert(!accs.isEmpty(), 'Error! List is empty');
			
		System.runAs(createTestUser()) {
			try {
				BusInfoController.getBuses(accs[0].Id);
				System.assert(false, 'User without access received data. Exception was not appear.');
			} catch (AuraHandledException ex) {}
		}

		try {
			BusInfoController.getBuses(null);
			System.assert(false, 'Method works fine with null as parameter. Exception was not appear.');
		} catch (AuraHandledException ex) {}
	}

	private static User createTestUser() {
		String uniqueUserName = 'standarduser' + DateTime.now().getTime() + '@testorg.com';
		Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
		User testUser = new User(Alias = 'standt', Email = 'standarduser@testorg.com',
		EmailEncodingKey = 'UTF-8', LastName = 'Testing', LanguageLocaleKey = 'en_US',
		LocaleSidKey = 'en_US', ProfileId = p.Id,
		TimeZoneSidKey = 'America/Los_Angeles',
		UserName = uniqueUserName);
		return testUser;
	}
}