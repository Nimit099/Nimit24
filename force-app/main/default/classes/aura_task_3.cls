public with sharing class aura_task_3 {

    @AuraEnabled
    public static String getsaveacc(String accountName,String accountPhone, String accountRating){
        try {
            Account acc = new Account(Name = accountName ,Phone = accountPhone, Rating = accountRating);
            insert acc;
            return acc.Id;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static String savecon(String Firstname, String Lastname, String Phones, String AccountIds){
        try {
            Contact con = new Contact(FirstName = Firstname, LastName = Lastname, Phone = Phones, AccountId = AccountIds);
            insert con;
            return con.Id;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static String saveeve(String subject, Date startdate, Date enddate, String whoid){
        try {

                Event eve = new Event(Subject = subject, StartDateTime = startdate ,EndDateTime = enddate, Whoid = whoid, OwnerId = '0055g00000FvUkhAAF',IsAllDayEvent = true);
                insert eve;
                System.debug(eve);
                return null;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}