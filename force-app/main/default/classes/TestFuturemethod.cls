@isTest class TestFuturemethod {
    @isTest static void TestFuturemethod() {
        Test.setMock(HttpCalloutMock.class, new MockFuturemethod());
        Test.startTest();
        Opportunityhandler.future('0065g00000TJHuEAAX');
        Test.stopTest();
        // ContentDocumentLink cd = [SELECT Id FROM ContentDocumentLink WHERE LinkedEntityId = '0065g00000TJHuEAAX'];
        HttpResponse res = new HttpResponse();
        // System.assertEquals('success', String.valueof(res.getBody()));
        
    }
}