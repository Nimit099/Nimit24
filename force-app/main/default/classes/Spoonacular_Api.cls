public class Spoonacular_Api {

    // This method is use to callout spoonacular api to get reciepe, resturant and food related details.
    // apikey = e1036ba26dd64f61bde51b545cd2a998
    // https://spoonacular.com/food-api/docs In this link you will find document for the spoonacular api 
    @future(callout = TRUE)
    public static void apicallout(){
        String endpoints = 'https://api.spoonacular.com/recipes/complexSearch';
        String apikey = '?apiKey=e1036ba26dd64f61bde51b545cd2a998';
        String body = '&query=pasta&maxFat=25&number=2';
        String url = endpoints + apikey + body;
        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
        request.setHeader('Content-Type', 'application/json');
        request.setMethod('GET');
        Http http = new Http();
        HttpResponse response = new HttpResponse();
        response = http.send(request);
        Map<String, Object> mapofresponse = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
        Object result =  mapofresponse.get('results');
        List<Object> mapofresults = (List<Object>)mapofresponse.get('results');
        String mapp = String.valueOf(mapofresults[0]);
        Map<String, Object> mapofreciepe = new Map<String,Object>();
        String[] keyValuePairs = mapp.substring(1, mapp.length() - 1).split(', ');
        for (String pair : keyValuePairs) {
            String[] parts = pair.split('=');
            if (parts.size() == 2) {
                String key = parts[0];
                String value = parts[1];
                mapofreciepe.put(key, value);
            }
        }
        String imageurl = String.valueOf(mapofreciepe.get('image'));
        HttpRequest request1 = new HttpRequest();
        request1.setEndpoint(imageurl);
        request1.setMethod('GET');
        Http http1 = new Http();
        HttpResponse response1 = new HttpResponse();
        response1 = http1.send(request1);
        ContentVersion cv = new Contentversion();
        cv.PathOnClient = String.valueOf(mapofreciepe.get('title') + '.' + String.valueOf(mapofreciepe.get('imageType')));
        cv.title = String.valueOf(mapofreciepe.get('title'));
        cv.versionData = response1.getBodyAsBlob();
        insert cv;
    }
}