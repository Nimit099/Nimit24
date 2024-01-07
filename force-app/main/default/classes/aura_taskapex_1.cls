public with sharing class aura_taskapex_1 {

    public integer OffsetSize = 0;
    public integer LimitSize = 5; 

    @AuraEnabled
    public static List<Account> getAccounts(integer size, String searchKeywords) {
        try{
            List<Account> acc = new List<Account>();

            if(searchKeywords.equals('')){
            acc = [SELECT ID, Name,(SELECT Id, FirstName,LastName,Email FROM Contacts) FROM Account Order By Name Limit: size];
            }
            else{
                acc = [SELECT ID, Name,(SELECT Id, FirstName,LastName,Email FROM Contacts) FROM Account WHERE Name LIKE:'%'+searchKeywords+'%' Order By Name Limit: size];

            }
        return acc;
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static Integer getcount(){
        try {
            integer count = [SELECT Count() FROM Account];
            return count;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled  
    public static List<Account> nextacc(Integer limitsize, Integer OffsetSize, String searchKey){
        try {

            List<Account> acc = new List<Account>();
            if(searchKey.equals('')){
            acc = [SELECT ID, Name,(SELECT Id, FirstName,LastName,Email FROM Contacts) FROM Account Order By Name Limit: limitsize Offset: OffsetSize];
            }
            else{
            acc = [SELECT ID, Name,(SELECT Id, FirstName,LastName,Email FROM Contacts) FROM Account WHERE Name Like : '%'+searchKey +'%'  Order By Name Limit: limitsize Offset: OffsetSize];  
            }
            return acc;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<Account> previousacc(Integer limitsize, Integer OffsetSize, String searchKey){
        try {
            List<Account> acc = new List<Account>();
            if(searchKey.equals('')){
            acc = [SELECT ID, Name,(SELECT Id, FirstName,LastName,Email FROM Contacts) FROM Account Order By Name Limit: limitsize OFFSET: OffsetSize];
            }
            else{
            acc = [SELECT ID, Name,(SELECT Id, FirstName,LastName,Email FROM Contacts) FROM Account WHERE Name Like : '%'+searchKey +'%'  Order By Name Limit: limitsize Offset: OffsetSize];    
            }
            return acc;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled 
    public static List<Account> searchAccount(String searchKeywords,Integer limitsize){
        try {
            if(searchKeywords != null){
            List<Account> acc = [SELECT ID, Name,(SELECT Id, FirstName,LastName,Email FROM Contacts) FROM Account WHERE Name Like : '%'+searchKeywords +'%' order by Name Limit: limitsize];
            return acc;
            }
            else {
                List<Account> acc = [SELECT ID, Name,(SELECT Id, FirstName,LastName,Email FROM Contacts) FROM Account];
                return acc;
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static Integer searchCount(String searchKeywords){
        try {
            Integer acc = [SELECT Count() FROM Account WHERE Name Like : '%'+searchKeywords +'%'];
            return acc;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

}