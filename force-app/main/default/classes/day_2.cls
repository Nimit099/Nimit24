public class day_2  {
    public List<Contact> con {get;set;}
    public Contact cont{get;set;}
    public String alert{get;set;}
    public List<Account> acc {get;set;}
    public string firstname {get;set;}
    public string lastname {get;set;}
    public string email {get;set;}
    public string password {get;set;}
    public String accountsid {get;set;}
    public List<Opportunity> opt{get;set;}
    public integer OffsetSize = 0;
    public integer LimitSize = 10; 
    Integer counts;

    public day_2() {
        alert = '';
        acc = [SELECT Id, Name FROM Account];
    }

    public String getAccountsid(){
        return accountsid;
    }

    public void setAccountsid(String accountsid){
        this.accountsid = accountsid;
    }

    public List<SelectOption> getItems(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','None'));
        for(account ac:acc){
            options.add(new SelectOption(ac.Id,ac.Name));
        }
        return options;
    }

    public PageReference save(){
        if(firstname.equals('') || lastname.equals('') || email.equals('')|| password.equals('') || accountsid.equals('')){
            alert = 'Empty field';
        }
        else if(!Pattern.matches('[a-zA-Z0-9._-]+@[a-zA-Z]+.[a-zA-Z]{2,4}', email)){
       alert = 'Incorrect email';
        }
    
        else if(password.length()<6 ){
        alert = 'Password is small';
        }
        else{
        cont = new Contact(FirstName = firstname, LastName = lastname , Email = email,Password__c = password, AccountId = accountsid );
        insert cont;
        PageReference pg = new PageReference('/apex/Day_2_login');
                    pg.setRedirect(true);
                    return pg;
        }
        return null;
    }

    public PageReference login(){
        if( email.equals('')|| password.equals('')){
        alert = 'can\'t keep field empty';
        }
        else if (!Pattern.matches('[a-zA-Z0-9._-]+@[a-zA-Z]+.[a-zA-Z]{2,4}', email)){
            alert = 'incorrect email form';
        }
        else{
            try {
                cont = [SELECT AccountId, Password__c FROM Contact WHERE Email =: email ];
              
                if(String.ValueOf(cont.Password__c) == password){
                    con = [SELECT Id , FirstName, LastName FROM Contact WHERE AccountId =: cont.AccountId LIMIT:LimitSize OFFSET:OffsetSize ];
                    opt = [SELECT Id , Name FROM Opportunity WHERE AccountId=: cont.AccountId LIMIT:LimitSize OFFSET:OffsetSize ];
                     counts = 4;
                    return Page.Day_2_Dashboard;
                }
            } catch (Exception e) {
                alert = 'There is no such email in database';
            }
        }
        return null;
    }

    public void previouscon(){
        if(OffsetSize>=0){
           alert = 'reach its Limit';
        con = [SELECT FirstName,LastName FROM Contact WHERE AccountId=: cont.AccountId   LIMIT:LimitSize OFFSET:OffsetSize];
        opt = [SELECT Id , Name FROM Opportunity WHERE AccountId=: cont.AccountId  LIMIT:LimitSize OFFSET:OffsetSize ];
        }
        else {
            OffsetSize = 0; 
        }
    }
    public void nextcon(){
        if(OffsetSize < counts){
            alert = 'reach it limit';
            con = [SELECT FirstName,LastName FROM Contact  WHERE AccountId=: cont.AccountId  LIMIT:LimitSize OFFSET:OffsetSize];
            opt = [SELECT Id , Name FROM Opportunity WHERE AccountId=: cont.AccountId LIMIT:LimitSize OFFSET:OffsetSize ];
            }
            else{
                OffsetSize = OffsetSize - LimitSize;
            }    
    }
}