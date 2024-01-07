trigger trigger_12 on Account (after insert) {
    Account a = Trigger.new[0];
    Account ainserted = [SELECT Id, Name FROM Account WHERE Id =:a.Id];
    Contact con = new Contact();
    con.LastName = ainserted.Name;
    con.AccountId = ainserted.Id;
    insert con;
    
}