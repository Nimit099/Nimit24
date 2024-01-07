trigger trigger_5 on Account (before update) {
    Account ac = Trigger.new[0];    
    ac.OwnerId = ac.LastModifiedById;
}