@isTest
public with sharing class TestContacthandler {
   
    @TestSetup
    static void makeData(){
        Account acc = new Account(Name = 'Nimit', Total_Amount__c = 1000);
        insert acc;

        List<Contact> conlist = new List<Contact>();
        for(Integer i = 0 ; i<20; i++){
            conlist.add(new Contact(LastName = 'Shah', AccountId = acc.Id, Amount__c = 1000));
        }
        insert conlist;
    }
    @isTest static void testdelacc(){
        List<Contact> conlist = new List<Contact>([SELECT Id, AccountId FROM Contact]);
        Contacthandler.deleteacc(conlist);
        System.assertEquals(0, [SELECT Count() FROM Account]);
    }
    @isTest static void testcreateevent(){
        // Negative testing 
       
        // Positive testing         
        List<Contact> conlist = new List<Contact>([SELECT Id, AccountId,ownerId FROM Contact]);
        Contacthandler.createevent(conlist);
        Integer eve = [SELECT Count() FROM Event];
        System.debug(eve);
        System.assertEquals(21,eve);
        //Negative testing 
         Contacthandler.createevent(null);
    }
    @isTest static void testgreatproblem(){
        List<Contact> conlist = new List<Contact>([SELECT Id, AccountId,LastName, Amount__c FROM Contact]);
        Contacthandler.great_problem(conlist);
        Integer no = [SELECT Count() FROM Contact WHERE Amount__c = 100];
        System.debug(no);
        System.assertEquals(0, no);
    }

    @isTest static void testupdate_great(){
        List<Contact> conlist = new List<Contact>();
        Account acc =[SELECT Id FROM Account];
        for(Integer i = 0 ; i<20; i++){
            conlist.add(new Contact(LastName = 'Shah', AccountId = acc.Id, Amount__c = 1100));
        }
        insert conlist;
        Contacthandler.update_great(conlist);
        Integer no = [SELECT Count() FROM Contact WHERE Amount__c = 100];
        System.debug(no);
        System.assertEquals(0, no);
    }
}