@isTest
public with sharing class TestAllTrigger {
   
   // @isTest static void testtrigger(){

   //  List<Account> acc = new List<Account>();
   //  for(Integer i = 0; i < 200; i++){
   //     acc.add(new Account(Name = 'Nimit'+i));
   //  }   
   //  insert acc;
   //  Account accou = [SELECT Name FROM Account WHERE Name =: 'Mr.Nimit0' Limit 1]; 
   //  System.assertEquals('Mr.Nimit0',accou.Name);
   

   //  List <Account> acc1 = [SELECT Name,Rating ,LastModifiedById,OwnerId FROM Account ];
   //  List<Contact> con = [SELECT LastName, Email FROM Contact];
   //  for(Account ac : acc1){
   //      ac.Name = 'Shah';
   //      ac.Rating = 'Hot';
   //  }
   //  update acc1;
   //  System.assertEquals(400,[SELECT Count() FROM Account]);

   // }

   @IsTest static void testemailservice(){
      EmailServicesAddress esa = [SELECT Id, EmailDomainName, IsActive, LocalPart FROM EmailServicesAddress WHERE Function.FunctionName =: 'QuickFormemailservice' Limit 1];         
         List<String> toAddresses = new List<String>();
         Messaging.InboundEmail email = new Messaging.InboundEmail() ;
         Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
         // setup the data for the email
         email.subject = 'Test Job Applicant';
         email.fromname = 'FirstName1 LastName1';
         env.fromAddress = 'nimit.s@mvclouds.com';
         RestClass emailProcess = new RestClass();
         emailProcess.handleInboundEmail(email, env);
      }

   
}