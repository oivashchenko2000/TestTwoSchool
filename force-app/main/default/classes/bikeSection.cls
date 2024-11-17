public class bikeSection {
    @AuraEnabled(cacheable=true)
        public static User getUserDetails() {
            String recId=UserInfo.getUserId();
            return  [Select Id , Name ,Email from User where Id =:recId];
        }
    }