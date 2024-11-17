@isTest
private class BusLineManagementTest {

	@testSetup
	static void setup() {
		Account acc = new Account(Name = 'TestAcc', State__c = 'TX');
		insert acc;
		Bus__c bus = new Bus__c(Color__c = 'black', Mark__c = 'KIA',
		Count_of_seats__c = 4, Account__c = acc.Id, Available__c = true, RegistrationNumber__c = '1234', Series__c = 'AS');
		insert bus;
		Line__c testLine = new Line__c(Name = 'testLine', IsActive__c = true);
		insert testLine;
		insert  new Bus_Line__c(Bus__c = bus.Id, Line__c = testLine.Id);
	}

	@isTest
	static void checkNullException() {
		try {
			BusLineManagementController.getLinesInfo(null);
			System.assert(false, 'Method works fine with null as parameter. Exception was not appear.');
		} catch (AuraHandledException ex) {}

		try {
			BusLineManagementController.deleteBusLine(null);
			System.assert(false, 'Method works fine with null as parameter. Exception was not appear.');
		} catch (AuraHandledException ex) {}

		try {
			BusLineManagementController.addNewBusLine(null, null);
			System.assert(false, 'Method works fine with null as parameter. Exception was not appear.');
		} catch (AuraHandledException ex) {}
	}

	@isTest
	static void checkObjectTypeException() {
		Account acc = [Select Id From Account Where Name = :'TestAcc' LIMIT 1];
		System.assert(acc != null, 'Account object is null');

		try {
			BusLineManagementController.getLinesInfo(acc.Id);
			System.assert(false, 'Method works fine with other sObject type. Exception was not appear.');
		} catch (AuraHandledException ex) {}

		try {
			BusLineManagementController.deleteBusLine(acc.Id);
			System.assert(false, 'Method works fine with other sObject type. Exception was not appear.');
		} catch (AuraHandledException ex) {}

		try {
			BusLineManagementController.addNewBusLine(acc.Id, acc.Id);
			System.assert(false, 'Method works fine with other sObject type. Exception was not appear.');
		} catch (AuraHandledException ex) {}
	}

	@isTest
	static void checkDeleteBusLine() {
		List<Bus_Line__c> busLineObjects = [Select Id From Bus_Line__c];
		System.assert(!busLineObjects.isEmpty(), 'List of BusLine objects is empty.');
		Id busLineId = busLineObjects[0].Id;

		BusLineManagementController.deleteBusLine(busLineId);
		List<Bus_Line__c> busLines = [Select Id From Bus_Line__c Where Id = :busLineId];
		System.assert(busLines.isEmpty(), 'The deletion was not performed. List of BusLines is not empty');
		
		try {
			BusLineManagementController.deleteBusLine(busLineId);
			System.assert(false, 'BusLine with current id does exists');
		} catch (AuraHandledException ex) {}
	}

	@isTest
	static void getLinesInfoTest() {
		List<Bus_Line__c> busLineObjects = [Select Id, Bus__c, Line__r.Name, LastModifiedDate From Bus_Line__c];
		System.assert(!busLineObjects.isEmpty(), 'List of BusLine objects is empty.');
		Bus_Line__c busLineObject = busLineObjects[0];
		System.assert(busLineObject != null, 'List of BusLines is empty');

		Models.BusLine busLine = new Models.BusLine(busLineObject);
		Models.BusLine currentBusLine = BusLineManagementController.getLinesInfo(busLineObject.Bus__c)[0];
		System.assertEquals(busLine.line.name,currentBusLine.line.name,'The received value Line Name does not match the expected');
		System.assertEquals(busLine.id,currentBusLine.id,'The received value BusLine Id does not match the expected');
		System.assertEquals(busLine.lastModifiedDate,currentBusLine.lastModifiedDate,'The received value LastModifiedDate does not match the expected');
	}

	@isTest
	static void getLinesInfoException() {
		User testUser = createTestUser();
		System.runAs(testUser) {
			try {
				Account acc = new Account(Name = 'TestAcc', State__c = 'NY');
				insert acc;
				Bus__c bus = new Bus__c(Color__c = 'black', Mark__c = 'KIA',
				Count_of_seats__c = 4, Account__c = acc.Id, Available__c = true, RegistrationNumber__c = '2345', Series__c = 'SS');
				insert bus;

				BusLineManagementController.getLinesInfo(bus.Id);
				System.assert(false, 'BusLine with current busId does exist');
			} catch (AuraHandledException ex) {}
		}
	}

	@isTest
	static void addNewBusLineTest() {
		List<Account> accs = [Select Id From Account];
		System.assert(!accs.isEmpty(),'List of Account is empty');
		Bus__c bus = new Bus__c(Color__c = 'white', Mark__c = 'Volvo', Count_of_seats__c = 4, Account__c = accs[0].Id, RegistrationNumber__c = '2345', Series__c = 'SS');
		insert bus;
		Id busId = bus.Id; 
		Line__c line = new Line__c(Name = 'line');
		insert line;
		Id lineId = line.Id;

		Models.BusLine busLineModel = BusLineManagementController.addNewBusLine(busId, lineId);
		System.assertEquals(line.Name, busLineModel.line.name, 'The received value Line Name does not match the expected');
	}

	@isTest
	static void checkDuplicateException() {
		List<Account> accs = [Select Id From Account];
		System.assert(!accs.isEmpty(),'List of Account is empty');
		Bus__c bus = new Bus__c(Color__c = 'black', Mark__c = 'KIA', Count_of_seats__c = 4, Account__c = accs[0].Id, RegistrationNumber__c = '2345', Series__c = 'SS');
		insert bus;
		Id busId = bus.Id;
		Line__c testLine = new Line__c(Name = 'testLine');
		insert testLine;
		Id lineId = testLine.Id;
		insert new Bus_Line__c(Bus__c = busId, Line__c = lineId);

		try {
			BusLineManagementController.addNewBusLine(busId, lineId);
			System.assert(false, 'Duplicate record is not found.');
		} catch (AuraHandledException ex) {}
	}

	@isTest
	static void getAllLinesTest() {
		List<Line__c> lines = [Select Id, Name From Line__c];
		System.assert(!lines.isEmpty(), 'List of Line__c is empty');

		Line__c line = lines[0];
		Models.Line lineModel = BusLineManagementController.getAllLines()[0];

		System.assertEquals(line.Id, lineModel.id, 'The received value Line Id does not match the expected');
		System.assertEquals(line.Name, lineModel.name, 'The received value Line Name does not match the expected');
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