public  class AccountController {
    
    @AuraEnabled
    public static List<Account> getAccounts() {
        System.debug('Hello world');
        return [
            SELECT Id, Name, Industry, Rating
            FROM Account
            ORDER BY Name
            LIMIT 10
        ];
    }

    @AuraEnabled
    public static void deleteAccounts(Id recordId) {
        Database.delete(recordId);
    }
}