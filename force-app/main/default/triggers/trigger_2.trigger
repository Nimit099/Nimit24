trigger trigger_2 on Lead (after insert) {

    Lead leads = Trigger.new[0];
    Lead upd=[SELECT Id FROM Lead WHERE Id = :leads.Id];

    upd.Rating = 'Hot';
    update upd;
}