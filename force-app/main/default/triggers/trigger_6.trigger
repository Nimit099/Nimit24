trigger trigger_6 on Account (after update ) {
    Account oldac = Trigger.old[0];
    Account newac = Trigger.new[0];
    if(oldac.Name != newac.Name){
        if([SELECT Count() FROM Contact WHERE AccountId=: newac.Id] != 0){
        Contact con = [SELECT email FROM Contact WHERE AccountId=: newac.Id];
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

}