public with sharing class schoolportal {

    @AuraEnabled
    public static void registration(String firstname, String lastname, String email, String mobile, String role){
        try{
        Contact con = new Contact(FirstName = firstname, LastName = lastname, Email = email, Phone = mobile);
        Database.insert(con);

        Profile portalProfile = new Profile();

        if(role == 'teacher'){
        portalProfile = [SELECT Id FROM Profile WHERE Name='Teacher' Limit 1];
        }
        else{
        portalProfile = [SELECT Id FROM Profile WHERE Name='Student' Limit 1];
        }

        User user1 = new User(
            UserName = con.FirstName+con.LastName+'@schoolportal.com',
            FirstName = con.FirstName,
            LastName = con.LastName,
            Alias = firstname+lastname,
            email = con.Email,
            ContactId = con.Id,
            ProfileId = portalProfile.Id
        );
        Database.insert(user1);

        }catch(Exception e){}
    }
}