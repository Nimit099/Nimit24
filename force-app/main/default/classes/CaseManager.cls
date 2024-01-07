@RestResource(urlMapping='/Account/*')
global with sharing class CaseManager {
    @HttpGet
    global static List<Case> getCaseById() {
        // RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        // String caseId = request.requestURI.substring(
        //   request.requestURI.lastIndexOf('/')+1);
        List<Case> result =  [SELECT CaseNumber,Subject,Status,Origin,Priority
                        FROM Case];
        return result;
    }
    @HttpPost
    global static ID createCase(String subject, String status,
        String origin, String priority) {
        Case thisCase = new Case(
            Subject=subject,
            Status=status,
            Origin=origin,
            Priority=priority);
        insert thisCase;
        return thisCase.Id;
    }   
    @HttpDelete
    global static void deleteCase() {
        // RestRequest request = RestContext.request;
        // String caseId = request.requestURI.substring(
        //     request.requestURI.lastIndexOf('/')+1);
        List<Case> thisCase = [SELECT Id FROM Case];
        delete thisCase;
    }     
    @HttpPut
    global static ID upsertCase(String subject, String status,
        String origin, String priority, String id) {
        Case thisCase = new Case(
                Id=id,
                Subject=subject,
                Status=status,
                Origin=origin,
                Priority=priority);
        upsert thisCase;
        return thisCase.Id;
    }
}