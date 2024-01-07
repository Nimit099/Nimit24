public with sharing class aura_task_2 {

    @AuraEnabled (cacheable=true)
    public static List<Account> aclist(){
        try {
            List<Account> acc = new List<Account>();
            acc = [SELECT ID, Name,(SELECT Id, FirstName,LastName,Email FROM Contacts ) FROM Account Order By Name];
            return acc;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled (cacheable=true)
    public static List<Account> acclist1(String searchkey){
        List<Account> acc = new List<Account>();
        acc = [SELECT ID, Name,(SELECT Id, FirstName,LastName,Email FROM Contacts) FROM Account WHERE Name LIKE: '%'+searchkey+'%' Order By Name ];
        return acc;
   }

   @AuraEnabled (cacheable=true)
   public static List<Account> acclist2(String searchkey){
    List<Account> acc = new List<Account>();
    acc = [SELECT ID, Name,(SELECT Id, FirstName,Email FROM Contacts) FROM Account WHERE Name LIKE: '%'+searchkey+'%' Order By Name ];
    return acc;  
 }

    @AuraEnabled (cacheable=true)
    public static void getIds(Integer i){
        try {
           
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled 
    public static List<Account> change(String contactid, String accountid){
        Contact con = [SELECT Id, AccountId FROM Contact WHERE Id =: contactid];
        con.AccountId = accountid;
        update con;
        List<Account> acc = new List<Account>();
        acc = [SELECT ID, Name,(SELECT Id,LastName, FirstName,Email FROM Contacts) FROM Account Order By Name ];
        return acc;  
 
    }
}