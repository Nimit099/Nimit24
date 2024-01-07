trigger trigger_3 on Opportunity (before update) {
    Opportunity op = Trigger.new[0];
    Date d = op.CloseDate;
    op.CloseDate =  d.addDays(15);
    // Opportunity opUp = [SELECT Id,StageName, CloseDate FROM Opportunity WHERE Id =: op.Id];
    if(op.StageName != 'Prospecting'){
        op.StageName = 'Prospecting';
        // Date d = opUp.CloseDate;
        // opUp.CloseDate =  d.addDays(15);
        // update opUp;
        }
        
    }