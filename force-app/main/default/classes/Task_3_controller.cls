public class Task_3_controller {
    public List<Contact> con {get;set;}
    public List<Account> acc {get;set;}
    public String render{get;set;}
    public Task_3_controller() {
        acc = [SELECT Name FROM Account];
        con = [SELECT FirstName FROM Contact];
      
    }     
}