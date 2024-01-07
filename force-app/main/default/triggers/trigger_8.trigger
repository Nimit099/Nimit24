trigger trigger_8 on Account (before insert) {
    Account ac = Trigger.new[0];
    ac.Name = 'Mr.'+ ac.Name;
}