public with sharing class Opportunityhandler {
    public Opportunity opp;
    public Opportunity op;

    public static void invoke(Opportunity op){
        future(op.Id);
    }
    
    @future (callout = true)
    public static void future(Id ids){

        String TestImageUrl='https://api.unsplash.com/photos/random/?client_id=7buh_DQcbfeESCH7k4N_P1nHQ_hQ1FhGCR9iM4Fd7lY';
        HttpRequest req = new HttpRequest();
        req.setEndpoint(TestImageUrl);
        req.setMethod('GET');        
        Http binding = new Http();
        HttpResponse response = binding.send(req);
        String r = String.Valueof(response.getBody()).replace('[','');
        r = r.substring(r.indexOf('full'),r.indexOf('=80'));
        r = r.replace('full":"','');

        HttpRequest req1 = new HttpRequest();
        req1.setEndpoint(r);
        req1.setMethod('GET');        
        Http binding1 = new Http();
        HttpResponse response1 = binding1.send(req1);


        ContentVersion cv = new ContentVersion();
        cv.ContentLocation ='S';
        cv.Title = 'Test Image';
        cv.PathOnClient = 'Image.jpg'; 
        cv.VersionData = response1.getBodyAsBlob(); 
        insert cv;
 
        Id conDocument = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cv.Id].ContentDocumentId;
 
        ContentDocumentLink cDocLink = new ContentDocumentLink();
        cDocLink.ContentDocumentId = conDocument;
        cDocLink.LinkedEntityId = ids;
        cDocLink.ShareType='V';
        cDocLink.Visibility='AllUsers';
        Insert cDocLink;
        
    }
    public static void changeStage(List<Opportunity> opp){
        for(Opportunity op: opp){
            if(op.StageName != 'Prospecting'){
                op.StageName = 'Prospecting';
                }
        }
    }
    public static void changedate(List<Opportunity > opp){
        for(Opportunity op : opp){
        Date d = op.CloseDate;
        op.CloseDate =  d.addDays(15);
        }
    }

// ----------------------------- LWC Task-3 -----------------------------------------------
@AuraEnabled
    public static List<Opportunity> opportunity(Id AccountId){
        try {
            if(AccountId != null){
                return[SELECT Id, Name FROM Opportunity WHERE AccountId =: AccountId];
            }
            else{
                return null;
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
// =========================================================================================

    public static void changetypeup(List<Opportunity> opp){
        for(Opportunity op : opp){
            if(op.Type!= 'New Customer'){
                op.Type ='New Customer';
        }
    }
    update opp;
}
    public static void changetypein(List<Opportunity> opp){
        for(Opportunity op : opp){
        op.Type ='New Customer';
        }
        update opp;
    }
    public static void createtask(Opportunity oppo , Opportunity oppn){
        if(oppo.Name != oppn.Name){
            Task t = new Task();
            t.WhatID          = Oppn.Id;
            t.Ownerid         = oppn.Ownerid;
            t.subject 	      = 'This is the Subject';
            t.Status	      = 'In Progress';
            t.Description     = 'This is the Description';
            insert t;
    }
}
}