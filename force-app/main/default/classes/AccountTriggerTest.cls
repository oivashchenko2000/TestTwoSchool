@IsTest
private class AccountTriggerTest {

	@IsTest
	static void accountTriggerBlunkTest() {
		List<Account> accs = new List<Account>();

		for (Integer i = 0; i < 200; ++i) {
			Account acc = new Account(Name = 'Test Account' + i, BillingState = 'CA');
			accs.add(acc);
		}
		Test.startTest();
		insert accs;
		Test.stopTest();
		List<Account> newAccs = [Select ShippingState From Account];
		for (Account acc: newAccs) {
			System.assertEquals('CA', acc.ShippingState, 'Error');
		}

	}
}