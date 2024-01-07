trigger trigger_10 on Account (after insert) {
    Account a = Trigger.new[0];
    Account ainserted = [SELECT Id FROM Account WHERE Id =: a.Id];
    Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
    req.setComments('Submitted for approval. Please approve.');
    req.setObjectId(ainserted.Id);
    Approval.ProcessResult result = Approval.process(req);
}