trigger trigger_7 on Opportunity (before update) {
    Opportunity before = Trigger.old[0];
    Opportunity after = Trigger.new[0];
    if(before.Name != after.Name){
        Task t = new Task();
        t.ownerId = after.ownerId;
        insert t;
    }
}