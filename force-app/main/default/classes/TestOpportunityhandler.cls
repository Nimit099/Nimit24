@isTest
public with sharing class TestOpportunityhandler {
 
    @TestSetup
    static void makeData(){
        List<Opportunity> opp = new List<Opportunity>();
        for(Integer i =0 ; i<20 ; i++ ){
            opp.add(new Opportunity(Name = 'Nimit', CloseDate = System.Today(), StageName = 'Qualification'));
        }
        insert opp;
    } 
        
    @isTest static void testchangestage(){
        List<Opportunity> opp = new List<Opportunity>([SELECT Id,StageName FROM Opportunity]);
        Opportunityhandler.changeStage(opp);
        Opportunity oppo = [SELECT Id,StageName FROM Opportunity LIMIT 1];
        System.assertNotEquals('Prospecting', oppo.StageName);
    }
    @isTest static void testchangedate(){
        List<Opportunity> opp = new List<Opportunity>([SELECT Id,StageName,CloseDate FROM Opportunity]);
        Opportunityhandler.changedate(opp);
        Opportunity oppo = [SELECT Id,StageName,CloseDate FROM Opportunity LIMIT 1];
        System.assertEquals(System.today(), oppo.CloseDate);
    }
    @isTest static void testchangetypeup(){
        List<Opportunity> opp = new List<Opportunity>([SELECT Id,StageName,CloseDate,Type FROM Opportunity]);
        Opportunityhandler.changetypeup(opp);
        Opportunity oppo = [SELECT Id,StageName,CloseDate,Type FROM Opportunity LIMIT 1];
        System.assertEquals('New Customer', oppo.Type);
    }

    @isTest static void testchangetypein(){
        List<Opportunity> opp = new List<Opportunity>([SELECT Id,StageName,CloseDate,Type FROM Opportunity]);
        Opportunityhandler.changetypein(opp);
        Opportunity oppo = [SELECT Id,StageName,CloseDate,Type FROM Opportunity LIMIT 1];
        System.assertEquals('New Customer', oppo.Type);
    }

    @isTest static void testcreatetask(){
        Opportunity opp = new Opportunity(Name = 'Nimit', CloseDate = System.Today(), StageName = 'Qualification');
        Opportunity oppn = new Opportunity(Name = 'Shah', CloseDate = System.Today(), StageName = 'Qualification', Ownerid='0055g00000FwqQ6');
        System.debug(System.Today());
        insert opp;
        insert oppn;
        Opportunityhandler.createtask(opp,oppn);
        Opportunity oppo = [SELECT Id,StageName,CloseDate FROM Opportunity WHERE Id =: oppn.ID];
        Integer tasks = [SELECT Count() FROM Task WHERE WhatId =: oppo.Id];
        System.assertEquals(1, tasks);
    }
}