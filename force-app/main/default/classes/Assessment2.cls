public with sharing class Assessment2 {
    public static void  sendemailaftercase(List<Case> cases){

        String body = 'This is testing for Send mass emails from your apex class in Salesforce';    
        List <Contact> cons = [SELECT Id, Email FROM Contact];

        List<String> sendTo = new List<String>();
        for(Case c: cases){
            sendTo.add(c.SuppliedEmail);
            for(Contact con : cons){
                if(c.ContactId == con.Id){
                    sendTo.add(con.Email);
                }
            }
        }
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(sendTo);
        email.setSubject('Case');
        email.setHtmlBody('Your case:<b> </b>has been created.<p>To view your case');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
    }

    @AuraEnabled
    public static wrap acccon(){
        try {
            List<Account> acc = [SELECT Id, Name FROM Account];
            List<Contact> con = [SELECT Id, FirstName FROM Contact];
            wrap w = new wrap();
            w.cons = con;
            w.acc = acc;
            return w;
        } catch (Exception e) {

            return null;
        }
    }

    public class wrap{

        @AuraEnabled
        public List<Contact> cons {get; set;}

        @AuraEnabled
        public List<Account> acc {get; set;}
    }
}