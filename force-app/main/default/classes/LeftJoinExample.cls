public  class LeftJoinExample {

    public static void getLeftResult(){
        List<Account> leftJoinList=[Select Name, (Select Name, Email, Phone From Contacts) From Account];

       for(Account account : leftJoinList){
            System.debug('Account name is '+account.Name);
            for (Contact con : account.contacts) {
                System.debug('Contact name is' + con.Name);
                System.debug('Contact phone is' + con.Phone);
                System.debug('Contact email is' + con.Email);
            }
       }       
    }
}