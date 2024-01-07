public with sharing class Accounthandler{

// ------------------ LWC Task-4 and LWC Task-3 ----------------------------------
@AuraEnabled(cacheable=true)
    public static List<Account> accounts(){
        return[SELECT Id,Name,Email__c FROM Account];
    }

@AuraEnabled
    public static void sendEmail( List<String> email, String Subject, String Mail ){
        try {          
            System.debug(email);
            Messaging.SingleEmailMessage mails = new Messaging.SingleEmailMessage();
                mails.setToAddresses(email);
                mails.setSubject(Subject);
                mails.setHtmlBody(Mail);
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mails });  
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
// ===============================================================================



// ------------------ LWC Task-5 ------------------------------------------------
@AuraEnabled
    public static List<List<SObject>> sosl(List<String> obj, String keyword){
        try {
            String searchquery = 'FIND :keyword IN ALL FIELDS RETURNING';

            for(integer i = 0; i < obj.size(); i++){

                if(obj[i] == 'Account'){
                    if(i == 0){
                    searchquery += ' Account(Id,Name)';
                    }
                    else{
                    searchquery += ', Account(Id,Name)';
                    }
                }
                
                else if(obj[i] == 'Contact'){
                    if(i == 0){
                        searchquery += ' Contact(Id,FirstName)';
                        }
                        else{
                        searchquery += ', Contact(Id,FirstName)';
                        }                    
                }
                else if(obj[i] == 'Opportunity'){
                    if(i == 0){
                        searchquery += ' Opportunity(Id,Name)';
                        }
                        else{
                        searchquery += ', Opportunity(Id,Name)';
                        }
                }
                else if(obj[i] == 'Lead'){
                    if(i == 0){
                        searchquery += ' Lead(Id,FirstName)';
                        }
                        else{
                        searchquery += ', Lead(Id,FirstName)';
                        }
                }
            }  
            List<List<SObject>> ListOfResults = search.query(searchquery);
            return ListOfResults;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
// ===============================================================================



public static void createcon(List<Account> acc){
    List<Contact> con = new List<Contact>();
    for(Account ac : acc){
        con.add(new Contact( LastName = ac.Name ,AccountId = ac.Id, email = 'nimitshah240@gmail.com'));
    }
    insert con;
}

   
public static void createac(List<Account> acc){
    List<Account> accounts = new List<Account>(); 
        for(Account a : acc){
            Account ac = new Account(Name = a.Name+''+a.Name);
            accounts.add(ac);
        }
        insert accounts;
        try{
        Account a = new Account();
        insert a;
        }
        catch(Exception e){
            CatchException ce = new CatchException();
            ce.createrecord(e);
        }
    }

    public static void deleteac(List<Account> acc){
        if(acc.size() > 0){
            delete acc;
            }
    }

    public static void Ratings(List<Account> acc , List<Account> ac){
        List<AccountShare> acs = new List<AccountShare>();
        for(Account accf: acc){
            if(accf.Rating!= 'Hot'){
                for(Account accs : ac){
                    if(accs.Rating == 'Hot'){
                        AccountShare a = new AccountShare();
                        a.UserOrGroupID = '0055g00000FwqQ6';
                        a.AccountId = accs.Id;
                        a.AccountaccessLevel = 'Edit';
                        a.OpportunityAccessLevel = 'Read';
                        a.ContactAccessLevel = 'Edit';
                        a.CaseAccessLevel = '';
                        acs.add(a);
                    }
                }
            }
        }
                insert acs;
            }
    
        public static void change(Account neew ,Account old){
            if(neew.Name != old.Name){
                Contact con = [SELECT email FROM Contact WHERE AccountId=: neew.Id];
  
                List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
                List<String> address = new List<String>{};
                address.add(con.email);
                    
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setSubject('Your Account name has been change');
                mail.setplaintextbody('Account owner has changed account name');
                mail.setToAddresses(address);
                emailList.add(mail);
                
                if(!emailList.isEmpty()){
                    Messaging.sendEmail(emailList);
                }
            }
        }


    public static void approval(Account acc){
        
            Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
            req.setComments('Submitted for approval. Please approve.');
            req.setObjectId(acc.Id);
            Approval.ProcessResult result = Approval.process(req);
        
    }

    public static void prefix(List<Account> acc){
        for(Account a :  acc){
        a.Name = 'Mr.'+ a.Name;
        }
    }
    public static void publics(List<Account> acc){
        for(Account ac : acc )
        ac.OwnerId = ac.LastModifiedById;
    }

}