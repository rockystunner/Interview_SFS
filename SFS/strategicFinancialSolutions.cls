public with sharing class strategicFinancialSolutions {
    @AuraEnabled(cacheable=true)
    public static List<Object> fetchDataFromGithub(){
        HttpRequest req = new HttpRequest();
        Http http = new Http();
        HTTPResponse res = new HTTPResponse();
        req.setHeader('Content-Type', 'application/json');
        req.setMethod('GET');
        // Hardcoding endpoint here but should be using NamedCredentials for any key based or basic authentication.
        // Custom Metadata could be used to refer the endpoint so we have sandbox/prod endpoints.
        req.setEndpoint('https://raw.githubusercontent.com/StrategicFS/Recruitment/master/data.json'); 
        res = http.send(req);
        // For Best practices, we should be logging all the invocations so we can track service metrics
        // Platform events can be used to send async logs.
        if(res.getStatusCode()==200){
            return (List<Object>)JSON.deserializeUntyped(res.getbody());
        }
        else{
            return null;
        }
    }
}
