@RestResource(urlMapping='/getBoard')
global class RestClass {


    @HttpGet
    global static void getAccount(){
        try{

            insert (new Account(Name = 'Blackbeards Coconut Milk Emporium', Description = 'The finest coconut milk in the seven seas.'));


            // ContentVersion a = [SELECT Id ,VersionData from ContentVersion WHERE Id =: '0685g00000CD61PAAT' LIMIT 1];
            // RestResponse response = RestContext.response;
            // RestRequest req = RestContext.request;
            // System.debug(req.headers.get('UniqueId'));
            // response.addHeader('Content-Type','image/jpg');
            // // response.responseBody = a.VersionData;
            // System.debug(response);
            // response.addHeader('Content-Disposition', 'attachment; filename="file.pdf"');
            // response.addHeader('Content-Type', 'application/pdf');
            // String s = EncodingUtil.base64Encode(a.VersionData);
            // response.responseBody = EncodingUtil.base64Decode(s);


            // RestRequest req = RestContext.request;
            // ContentVersion a = [SELECT ContentModifiedById,ContentDocumentId,FileExtension,FileType,ContentSize,ContentUrl,Id,VersionData,VersionNumber FROM ContentVersion where FileType = : 'PDF' LIMIT 1];
            // RestResponse res = RestContext.response;
            // res.addHeader('Content-Type',a.FileExtension);
            // res.addHeader('Content-Type','application/pdf');
            // String afterblob = EncodingUtil.base64Encode(a.VersionData);
            // res.responseBody =EncodingUtil.base64Decode(afterblob); 
            } catch(Exception e){
        System.debug(e);
        }
    }
}