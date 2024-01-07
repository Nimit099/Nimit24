trigger trigger_task_4 on Opportunity (after insert, after update) {
    if(Trigger.isInsert){
        Opportunity op =Trigger.new[0];
        Opportunity opUp = [SELECT Id FROM Opportunity WHERE Id =: op.Id];
        opUp.Type ='New Customer';
        update opUp;
        }
        else{
            Opportunity op =Trigger.new[0];
            Opportunity opUp = [SELECT Id,Type FROM Opportunity WHERE Id =: op.Id];
            if(opUp.Type!= 'New Customer'){
            opUp.Type ='New Customer';
            update opUp;
            }
        }
}