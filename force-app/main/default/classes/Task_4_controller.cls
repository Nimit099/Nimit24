public  class Task_4_controller {
    public List<Contact> con{get;set;}
    public List<Contact> cont{get;set;}
    public Integer counts{get;set;}
    public Integer count{get;set;}
    public String searchKey{get;set;}
    public integer OffsetSize = 0;
    public integer LimitSize = 10;
    
    public String page{get;set;}

    public Task_4_controller() {
       
        con = [SELECT FirstName,LastName FROM Contact  LIMIT:LimitSize OFFSET:OffsetSize];
        counts= [SELECT count() FROM Contact];
       
    }

    
    public void search(){
        page = '';
        OffsetSize = 0;
        string searchquery='select FirstName,LastName from Contact where FirstName like \'%'+searchKey+'%\' Limit 10';
        con= Database.query(searchquery);
        if(searchKey.equals('')){
            count = null;
        }
        else{
            count = [SELECT count() FROM Contact WHERE FirstName =:searchKey];
        }
    }
    public void previous(){
        OffsetSize = OffsetSize - LimitSize;
        if(searchKey.equals('')){
            if(OffsetSize>=0){
                page='';
            con = [SELECT FirstName,LastName FROM Contact  LIMIT:LimitSize OFFSET:OffsetSize];
            }
            else {
                OffsetSize = 0;
                page = 'Reach its limits';
            }
        }
        else{
            if(OffsetSize>=0){
                page='';
                con = [SELECT FirstName,LastName FROM Contact WHERE FirstName =:searchKey LIMIT:LimitSize OFFSET:OffsetSize];
            }
            else{OffsetSize = 0;
                page = 'Reach its limits';}
        }
    }
    public void next(){
        OffsetSize = OffsetSize + LimitSize;  
        if(searchKey.equals('')){
        if(OffsetSize < counts){
        page = '';
        con = [SELECT FirstName,LastName FROM Contact  LIMIT:LimitSize OFFSET:OffsetSize];
        }
        else{
            OffsetSize = OffsetSize - LimitSize;
            page='Reach its Limits';
        }
    }
    else{
        if(OffsetSize < count){
            page = '';
            con = [SELECT FirstName,LastName FROM Contact  WHERE FirstName =:searchKey LIMIT:LimitSize OFFSET:OffsetSize];
            }
            else{
                OffsetSize = OffsetSize - LimitSize;
                page='Reach its Limits';
            }
    }
    }
}