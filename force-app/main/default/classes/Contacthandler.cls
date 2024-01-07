public with sharing class Contacthandler {
    
    public static void deleteacc(List<Contact> con){
        for(Contact cont : con){
            if([SELECT Count() FROM Account WHERE Id =: cont.AccountId]!= 0){
                Account Ac = [SELECT Id FROM Account WHERE Id =: cont.AccountId];
                delete Ac;
            }
        }
    }


// ------------------ LWC Task-4 and LWC Task-3 ------------------------------------

 @AuraEnabled
    public static List<Lead> leads(){
        try {
            return[SELECT Id,FirstName,LastName,Email FROM Lead];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

@AuraEnabled
    public static List<Contact> contacts(Id AccountId){
        try {
            if(AccountId != null){
                return[SELECT Id,FirstName,LastName,Email FROM Contact WHERE AccountId=:AccountId];
            }
            else{
                return[SELECT Id,FirstName,LastName,Email FROM Contact];
            }
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

// ===============================================================================


    public static void createevent(List<Contact> con){
        if(con != null){
        for(Contact cont : con){
            Event eve = new Event();
            eve.ownerId = cont.ownerId;
            eve.WhoId = cont.Id;
            eve.IsAllDayEvent = true;
            eve.ActivityDate = System.Today();
            eve.Subject = 'Call';
            insert eve;
        }
        } 
            else{
              Account ac = new Account(Name = ' nimit');
                insert ac;
        }
    }
    
    public static void sheep(Map<Id,Contact> cold , Map<Id,Contact> cnew){
        List<Contact> con = new List<Contact>();
        for(Contact c: cnew.values()){
            if([SELECT Count() FROM Contact WHERE AccountId =:cold.get(c.Id).AccountId] != 0){
            con = [SELECT Name,AccountId FROM Contact WHERE AccountId =: cold.get(c.Id).AccountId ];
            for(Contact co : con){
                co.AccountId = c.AccountId;
            }
    }
}
update con;     
}

public static void great_problem(List<Contact> contactlist){
    Set<Id> accids = new Set<Id>();
    for(Contact con : contactlist){
        accids.add(con.AccountId);
    }
    Map<Id, Account> acc = new Map<Id, Account>([SELECT Id, Total_Amount__c FROM Account WHERE Id IN : accids]);
    List<Contact> c = new List<Contact>();
    
    for(Contact con : contactlist){
            while (con.Amount__c >acc.get(con.AccountId).Total_Amount__c) {
                Contact co = new Contact(LastName = con.LastName,Amount__c = acc.get(con.AccountId).Total_Amount__c, AccountId = con.AccountId);
                c.add(co);
                con.Amount__c -= acc.get(con.AccountId).Total_Amount__c;   
        }
    }
    insert c;
        
}



public static void update_great(List<Contact> contactlist){
 
Set<Id> accids = new Set<Id>();
for(Contact con : contactlist){
    accids.add(con.AccountId);
}
Map<Id, Account> acc = new Map<Id, Account>([SELECT Id, Total_Amount__c FROM Account WHERE Id IN : accids]);
List<Contact> c = new List<Contact>();

for(Contact con : contactlist){
        while (con.Amount__c >acc.get(con.AccountId).Total_Amount__c) {
            Contact co = new Contact(LastName = con.LastName,Amount__c = acc.get(con.AccountId).Total_Amount__c, AccountId = con.AccountId);
            c.add(co);
            con.Amount__c -= acc.get(con.AccountId).Total_Amount__c;   
    }
}
System.debug(c.size());
insert c;
    }

}