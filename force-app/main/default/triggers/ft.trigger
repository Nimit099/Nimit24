trigger ft on Transaction__c (after insert, after update, after delete) {
    if(Trigger.isInsert){
        ft.insertTransaction(Trigger.new);
    }
    else if(Trigger.isDelete){
        ft.deleteTransaction (Trigger.old);
    }

}