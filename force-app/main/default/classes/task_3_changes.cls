public class task_3_changes {
    public List<Contact> con {get;set;}
    public List<Account> acc {get;set;}
    public String render{get;set;}
    public task_3_changes(ApexPages.StandardSetController controller) {
        acc = [SELECT    Name FROM Account];
        con = [SELECT FirstName FROM Contact];
      render = 'true';
    }
    public PageReference  rendering(){
        if(ApexPages.currentPage().getParameters().get('id') != null){
        if(render.equals('true')){
            render = 'false';
        }
        else {
            render = 'true';
        }
    }
        return null;
    }        
}