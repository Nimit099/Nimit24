trigger Sheet3_Task1 on Contact (before insert, before update, before delete) {
    if(Trigger.isInsert){
        Sheet3_Task1.inserting(Trigger.new);
    }
    else if(Trigger.isUpdate){
        for(Integer i =0; i < Trigger.new.size();i++){
        Sheet3_Task1.updating(Trigger.new[i], Trigger.old[i]);
        }
    }
    else if(Trigger.isDelete){
        Sheet3_Task1.deleting(Trigger.old);
    }
}