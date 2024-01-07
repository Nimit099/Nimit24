@isTest with sharing class TestLeadhandler {
   
    @TestSetup
    static void makeData(){
        List<Lead> leads = new List<Lead>();
        for(Integer i = 0; i<20; i++){
            leads.add(new Lead(LastName = 'Shah', Company = 'MV Clouds', Status = 'open'));
        }
        insert leads;
    }
    @isTest static void Testchangerating(){
        List<Lead> leads = new List<Lead>([SELECT ID,Rating FROM Lead]);
        Leadhandler.changerating(leads);
        System.assertEquals(20,[SELECT Count() FROM Lead WHERE Rating =: 'Hot']);
    }

}