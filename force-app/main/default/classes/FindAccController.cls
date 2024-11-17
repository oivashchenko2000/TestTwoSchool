public class FindAccController {
    
    @AuraEnabled
    public static List<String> getAccountOwner(String accountName){
    List<Account> leftJoinList=[Select Name, (Select Name From Contacts) 
    From Account Where Name=:accountName];
    List<String> contacts=new List<String>();

    for (Account account : leftJoinList) {
        for (Contact contact : account.Contacts) {
            contacts.add(contact.Name);
        }
    }
    return contacts;
}
}