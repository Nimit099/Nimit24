public with sharing class Sheet3_Task1 {
    public Sheet3_Task1() {
    }
    public static void inserting(List<Contact> con){
        for(Contact c:con){
            if([SELECT Count() FROM Account WHERE Id=: c.AccountId] != 0){
                Account acc = [SELECT Id,Total_Amount__c FROM Account WHERE Id=: c.AccountId];
                if(acc.Total_Amount__c == null ){
                    acc.Total_Amount__c = 0;
                }
                if(c.Amount__c == null){
                    c.Amount__c = 0;
                }
                acc.Total_Amount__c += c.Amount__c;
                update acc;
            }
        }
    }
    public static void deleting(List<Contact> con){
        for(Contact c:con){
            if([SELECT Count() FROM Account WHERE Id=: c.AccountId] != 0){
                Account acc = [SELECT Id,Total_Amount__c FROM Account WHERE Id=: c.AccountId];
                if(acc.Total_Amount__c == null ){
                    acc.Total_Amount__c = 0;
                }
                if(c.Amount__c == null){
                    c.Amount__c = 0;
                }
                acc.Total_Amount__c -= c.Amount__c;
                update acc;
            }
        }
    }

    public static void updating(Contact news, Contact con){
        Contact old = [SELECT Amount__c FROM Contact WHERE Id =: con.Id];
        if([SELECT Count() FROM Account WHERE Id=: news.AccountId] != 0){
            Account acc = [SELECT Id,Total_Amount__c,Name FROM Account WHERE Id=: news.AccountId];
            if(acc.Total_Amount__c == null ){
                acc.Total_Amount__c = 0;
            }
            if(news.Amount__c == null){
                news.Amount__c = 0;
            }
            if(old.Amount__c == null){
                old.Amount__c = 0;
            }
            old.Amount__c -= news.Amount__c;
            acc.Total_Amount__c -= old.Amount__c;
            update acc;
        }
    }
}