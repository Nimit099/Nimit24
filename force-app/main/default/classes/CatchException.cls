public class CatchException extends Exception {
    
    public static void catchexception(Exception e){
        
    }
    public void createrecord(Exception e){
        try{
            String stackTrace = e.getStackTraceString().substringBefore('\n');
            String className = stackTrace.substringAfter('.').substringBefore('.');	
            String methodName = stackTrace.substringBefore(':').substringAfter(className).substringAfter('.');

            Error_Log__c err = new Error_Log__c();
            err.Class_Name__c = className;
            err.Method_Name__c	= methodName;
            err.Exception_Msg__c = e.getMessage();
            err.Exception_type__c = e.getTypeName();
            err.Line_Number__c = e.getLineNumber();
            err.OwnerID = UserInfo.getUserId();
            err.CreatedById = UserInfo.getUserId();
            System.debug(err);
            insert err;
        }
        finally{

        }
    }
}