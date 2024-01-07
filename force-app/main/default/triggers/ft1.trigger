trigger ft1 on Transfer__c (after insert) {
    ft.transfertrigger(Trigger.new);
}