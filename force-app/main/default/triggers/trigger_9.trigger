trigger trigger_9 on Contact (after delete) {
    Contact con = Trigger.old[0];
    Account Ac = [SELECT Id FROM Account WHERE Id =: con.AccountId];
    delete Ac;
}