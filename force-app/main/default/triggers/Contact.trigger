trigger Contact on Contact (after insert, before update,after delete, before insert) {
    
    if(Trigger.isBefore){
        if(Trigger.isInsert){
         Contacthandler.great_problem(Trigger.new);
        }
        else if(Trigger.isUpdate){
            // for(Integer i =0; i<Trigger.new.size(); i++){
            //     Sheet3_Task1.updating(Trigger.new[i], Trigger.old[i]);
            // }
            Contacthandler.update_great(Trigger.new);
        }
    }
    else{
        if(Trigger.isDelete){
            Sheet3_Task1.deleting(Trigger.old);
            // Contacthandler.deleteacc(Trigger.old);
        }
        else{
            // Sheet3_Task1.inserting(Trigger.new);
            // Contacthandler.createevent(Trigger.new);
        }
    }



}