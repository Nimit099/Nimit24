public with sharing class aura_task_5 {
    
    @AuraEnabled
    public static string methodName(){
        try {
            String userProfileName = [Select Name from profile where id =: userinfo.getProfileId()].Name;
            System.debug(userProfileName);
            if(userProfileName == 'System Administrator'){
                System.debug(userProfileName);
                return userProfileName;
            }
            else {
                return null;
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}