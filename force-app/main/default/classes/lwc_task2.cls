public with sharing class lwc_task2 {


    @AuraEnabled
    public static List<ContentVersion> uploadFile(String base64, String filename, String recordId) {
      
          ContentVersion cv = createContentVersion(base64, filename);
          ContentDocumentLink cdl = createContentLink(cv.Id, recordId);
          return first(recordId);
    }
    
    public static ContentVersion createContentVersion(String base64, String filename) {
      ContentVersion cv = new ContentVersion();
      cv.VersionData = EncodingUtil.base64Decode(base64);
      cv.Title = filename;
      cv.PathOnClient = filename;
      try {
        insert cv;
        return cv;
      } catch(DMLException e) {
        return null;
      }
    }
  
   
    public static ContentDocumentLink createContentLink(String contentVersionId, String recordId) {
      if (contentVersionId == null || recordId == null) { return null; }
      ContentDocumentLink cdl = new ContentDocumentLink();
      cdl.ContentDocumentId = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =: contentVersionId].ContentDocumentId;
      cdl.LinkedEntityId = recordId;
      try {
        insert cdl;
        return cdl;
      } catch(DMLException e) {
        return null;
      }
    }
    
    // @AuraEnabled
    // public static List<ContentVersion> upload(String Recordid, String docid) {
    //     ContentDocumentLink cDocLink = new ContentDocumentLink();
    //     cDocLink.ContentDocumentId = docid;
    //     cDocLink.LinkedEntityId = Recordid;
    //     cDocLink.ShareType='V';
    //     cDocLink.Visibility='AllUsers';
    //     Insert cDocLink;
    //     return first(Recordid);
    // }

    @AuraEnabled
    public static List<ContentVersion> first(String Recordid){

        List<ContentDocumentLink> cdlink = [SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId =: Recordid];
        List<ContentVersion> cvid = new List<ContentVersion>();
        for(ContentDocumentLink cd : cdlink){
        cvid.add([SELECT Id FROM ContentVersion WHERE ContentDocumentId =:cd.ContentDocumentId]);
        }
        if(cvid.size()> 0){
        return cvid;
        }
        else{
          return null;
        }
    }
}