public  class AccountController {
    
    @AuraEnabled
    public static List<Account> getAccounts() {
        return [
            SELECT Id, Name, Industry, Rating
            FROM Account
            ORDER BY Name
            LIMIT 10
        ];
    }
}