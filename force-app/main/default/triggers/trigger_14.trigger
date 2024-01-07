trigger trigger_14 on Account (before insert) {
    Account a = Trigger.new[0];
    public List<Account> acc {get;set;}
    acc = [SELECT Id,Name FROM Account WHERE Name =:a.Name];
    delete acc;
}