trigger SendMessage on Send_Message__e (after insert) {

    List<Account> accounts = new List<Account>();
    
    for (Send_Message__e event : Trigger.New) {
        if (event.Message__c.contains('Hello')) {
            accounts.add(new Account(Name = 'Test ' + event.Message__c));
        }
    }
    
    if (!accounts.isEmpty()) {
        insert accounts;
    }
}