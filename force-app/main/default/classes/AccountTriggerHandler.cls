public class AccountTriggerHandler {

	public static void CreateAccounts(List<Account> accs) {
		for (Account acc : accs) {
			if (acc.ShippingState != acc.BillingState) {
				acc.ShippingState = acc.BillingState;
			}
		}
	}
}