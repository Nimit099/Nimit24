@isTest
public with sharing class ftTest {
    @TestSetup
    static void makeData(){
        List<Person__c> persons = new List<Person__c>();
        persons.add( new Person__c(Name = 'Test A', Cash__c = 100, Bank__c = 100, Stock__c = 100));
        persons.add( new Person__c(Name = 'Test B', Cash__c = 100, Bank__c = 100, Stock__c = 100));
        insert persons;

        List<B_D_Account__c> account = new List<B_D_Account__c>();
        account.add(new B_D_Account__c(Name = 'Account A', Nimit__c = 100, Nisarg__c = 0));
        account.add(new B_D_Account__c(Name = 'Account B', Nimit__c = 0, Nisarg__c = 100));
        insert account;
    }

    @isTest 
    static void TransferTest(){
        List<Person__c> persons = [SELECT Id, Name, Cash__c, Bank__c, Stock__c FROM Person__c];
        List<B_D_Account__c> account = [SELECT Id,Name, Nimit__c, Nisarg__c FROM B_D_Account__c];
        List<Transfer__c> t = new List<Transfer__c>();
        t.add(new Transfer__c(From__c = persons[0].Id, To__c = persons[1].Id, Amount__c = 50, Date__c = System.Today(), Cash__c = true, Transaction_method__c = 'Cash Transfer'));
        t.add(new Transfer__c(From__c = persons[0].Id, To__c = persons[1].Id, Amount__c = 50, Date__c = System.Today(), Bank__c = true, Transaction_method__c = 'UPI'));
        insert t;
        System.debug(t);

        List<Person__c> person = [SELECT Id, Name, Cash__c, Bank__c, Stock__c FROM Person__c];
        System.debug(person[0]);
        System.debug(person[1]);

    }

}