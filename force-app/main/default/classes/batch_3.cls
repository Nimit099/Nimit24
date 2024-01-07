global class batch_3 implements Database.Batchable<sObject>,Database.Stateful{
    global Integer counts = 0;
    global Database.QueryLocator start(Database.BatchableContext bc){
        return  Database.getQueryLocator([SELECT Name FROM Account WHERE Name =: 'NimitBatchupdate']);
    }
    global void execute(Database.BatchableContext bc, List<Account> accounts){
        for(Account a : accounts){
            a.OwnerId = '0055g00000FvUkh';
            counts++;
        }
        update accounts;
    }
    global void finish(Database.BatchableContext bc){
        User u = [SELECT Email FROM User WHERE Id =:'0055g00000FvUkh'];
        String [] user =new String[]{u.email};
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(user);
        email.setSubject('Test Mail');
        email.setPlainTextBody('Hey User We are assigning you some account and its counts are '+ counts); 
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email}); 
    }
}