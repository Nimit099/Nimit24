trigger trigger_11 on Account (after update) {
    Account before = Trigger.old[0];
    Account after = Trigger.new[0];
    Account accafter = [SELECT Rating, Id FROM Account WHERE Id=: before.Id];
    if(before.Rating != 'Hot'){
        if(accafter.Rating.equals('Hot')){
            // Organization org = [SELECT Id FROM Organization WHERE Email =: 'ceo@gmail.com'];
            List<User> uid = [SELECT Id,Name FROM User WHERE Name = 'ceo' Limit 1 ];
            System.debug(uid);
            AccountShare a = new AccountShare();
            a.UserOrGroupID = '0055g00000FwqQ6';
            a.AccountId = accafter.Id;
            a.AccountaccessLevel = 'Edit';
            a.OpportunityAccessLevel = 'Read';
            a.ContactAccessLevel = 'Edit';
            a.CaseAccessLevel = '';
            insert a;
        }
    }
}