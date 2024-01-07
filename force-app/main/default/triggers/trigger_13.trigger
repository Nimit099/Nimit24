trigger trigger_13 on Contact (after insert) {
    Contact con = Trigger.new[0];
    Contact c = [SELECT Id, ownerId FROM Contact WHERE Id =: con.Id];
    Event eve = new Event();
    eve.ownerId = c.ownerId;
    eve.WhoId = c.Id;
    eve.IsAllDayEvent = true;
    eve.ActivityDate = System.Today();
    eve.Subject = 'Call';
    insert eve;
}