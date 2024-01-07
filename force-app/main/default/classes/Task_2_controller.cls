public class Task_2_controller {
    public Contact con {get;set;}
    public Task_2_controller() {
    con = new Contact();
    }
    public void save(){
        insert con;
        con = new Contact();
    }
}