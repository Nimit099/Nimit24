public class Signin {
  
    public String username{get;set;}
    public String useremail{get;set;}
    public String userpassword{get;set;}
    public String trial{get;set;}
    public Signin__c name {get;set;}
    public Signin__c email {get;set;}
    public String regex;
    public String newpassword{get;set;}
    public String confirmpassword{get;set;}

    public Signin() {      
    }

    public PageReference login(){
        try {
            name = [SELECT Name__c , Password__c FROM Signin__c WHERE Name__c =: username];
        if(String.valueOf(name.Name__c) == username && String.valueOf(name.Password__c) == userpassword){
            return Page.All_Task;
        }
        else{
            trial = 'Password is wrong';
        }
    
        } catch (Exception e) {
                trial = 'Username does not exists';   
            }
            return null;
    }

    public PageReference Forget_Password(){

        return Page.Forgetpasswrod;
    }

    public void getemail(){
        try {
            Map<String, Object> Params = new Map<String, Object>();
            Params.put('email',useremail);
            Flow.Interview.forget_password stage = new Flow.Interview.forget_password(Params);
            stage.start();
            trial= 'email has been send to '+ useremail;
        } catch (Exception e) {
            trial = 'There is no such email in database' ;
        }
    }

    public void signup(){
        if(username.equals('') || useremail.equals('') || userpassword.equals('')){
            trial = ' you cant keep any field empty';
        }
        else if(!Pattern.matches('[a-zA-Z0-9._-]+@[a-zA-Z]+.[a-zA-Z]{2,4}', useremail)){
            trial = 'wrong email';
        }
        else{
        try{
            email = [SELECT Name__c , Password__c, Email__c FROM Signin__c WHERE  Email__c =: useremail];
            trial = ' Email Already exists ,try to log in';
            signinpage();
            }
        catch(Exception e){
            names();
        }
    }
    }
    
    public PageReference names(){
        try {
            name = [SELECT Name__c , Password__c, Email__c FROM Signin__c WHERE  Name__c =: username];
            trial = 'Username already in use';
            return null;

        } catch (Exception e) {
            name = new Signin__c(Name__c = username, Email__c = useremail, Password__c = userpassword);
            insert name;
            return Page.Login;
    }
    }
    public PageReference signinpage(){
        return Page.Login;
    }
    public PageReference signuppage(){
        return Page.Signup;
    }
    public PageReference changepassword(){
        try {
            name = [SELECT Email__c , Password__c FROM Signin__c WHERE Email__c =: useremail];
            if(newpassword == confirmpassword){
                name.Password__c = confirmpassword;
                update name;
                trial = 'Password has been changed';
                return Page.Login;
            }
            else{
                trial = 'Password does not match';

            }
        } catch (Exception e) {
            trial = 'there is no such email';
        }
        return null;
    }
}