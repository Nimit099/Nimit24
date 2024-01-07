trigger Opportunity on Opportunity (before update, after insert, after update) {
    if(Trigger.isBefore){
        Opportunityhandler.changeStage(Trigger.new);
        Opportunityhandler.changedate(Trigger.new);
        for(Integer i =0 ; i< Trigger.new.size(); i++){
        Opportunityhandler.createtask(Trigger.old[i],Trigger.new[i]);
        }
    }
    else{
        if(Trigger.isInsert){
            Opportunityhandler.changetypein(Trigger.new);
        }
        else if(Trigger.isUpdate){
            Opportunityhandler.invoke(Trigger.new[0]);
        }
    }
}