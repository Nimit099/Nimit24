trigger Account on Account (before insert,after insert,before update,after update) {
    
    if(Trigger.isBefore){
        if(Trigger.isUpdate){
            AccountHandler.publics(Trigger.new);//done
        }
        else if(Trigger.isInsert){
            
            AccountHandler.deleteac(Trigger.new);//done
            AccountHandler.prefix(Trigger.new);// done
            
        }
    }
    else{
        if(Trigger.isUpdate){
            
            AccountHandler.Ratings(Trigger.old, Trigger.new);//done
            

            
            AccountHandler.change(Trigger.new[0], Trigger.old[0]);
            
            Accounthandler.createac(Trigger.new);
        }


        else if (Trigger.isInsert){
            AccountHandler.approval(Trigger.new[0]);//done
            
            AccountHandler.createcon(Trigger.new);//done
        }

    }
}