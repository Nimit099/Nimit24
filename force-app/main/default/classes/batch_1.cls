global class batch_1 implements Database.Batchable<sObject>,Database.Stateful{
    global List<Account> idstopass = new List<Account>();

   global Database.QueryLocator start(Database.BatchableContext bc){
    return Database.getQueryLocator([SELECT Id, Name FROM Account WHERE Name = 'Nimit']);
   }
   global void execute(Database.BatchableContext bc, List<Account> acc){

    for(Account a : acc){
        a.Name = a.Name +'Batchupdate';
        idstopass.add(a);
    }
    update acc;
       }
   global void finish(Database.BatchableContext bc){

    // batch_2 batch = new batch_2(idstopass);
    // Id ids = Database.executeBatch(batch,2000);
   }
}