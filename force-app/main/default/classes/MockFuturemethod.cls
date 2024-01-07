@isTest 
public class MockFuturemethod implements HttpCalloutMock {
    public HttpResponse respond(HttpRequest req) {
        HttpResponse res = new HttpResponse();
        res.setBody('{"Status:success"}');
        res.setStatuscode(200);
        return res;
    }
}