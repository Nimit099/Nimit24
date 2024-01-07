public with sharing class Leadhandler {
   
    public static void changerating(List<Lead> leads){
        for(Lead l : [SELECT Id, Rating FROM Lead WHERE Id = :leads]){
            // Lead upd=[SELECT Id FROM Lead WHERE Id = :leads.Id];
            l.Rating = 'Hot';
            update l;
        }
    }
}