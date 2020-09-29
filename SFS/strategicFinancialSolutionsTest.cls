@isTest
public with sharing class strategicFinancialSolutionsTest {
    
    @istest
    static void testGithubContentForSuccess(){
        test.startTest();
            Test.setMock(HttpCalloutMock.class, new test_success());
            List<Object> response_list = strategicFinancialSolutions.fetchDataFromGithub();
        test.stopTest();
        system.assertEquals(10, response_list.size());
        
    }
    @istest
    static void testGithubContentForFailure(){
        test.startTest();
            Test.setMock(HttpCalloutMock.class, new test_error());
            List<Object> response_list = strategicFinancialSolutions.fetchDataFromGithub();
        test.stopTest();
        system.assertEquals(null, response_list);
        
    }
    public class test_success implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HTTPResponse res = new HTTPResponse();
            res.setBody('[{"id":1,"creditorName":"CBNA","firstName":"Suman","lastName":"Tester79","minPaymentPercentage":2.00,"balance":1363.00},{"id":2,"creditorName":"AMEX","firstName":"Suman","lastName":"Tester79","minPaymentPercentage":2.00,"balance":2763.00},{"id":3,"creditorName":"AMEX","firstName":"Suman","lastName":"Tester79","minPaymentPercentage":2.00,"balance":429.00},{"id":4,"creditorName":"AMEX","firstName":"Suman","lastName":"Tester79","minPaymentPercentage":2.00,"balance":1363.00},{"id":5,"creditorName":"DISCOVERBANK","firstName":"Suman","lastName":"Tester79","minPaymentPercentage":2.00,"balance":2644.00},{"id":6,"creditorName":"CAPITAL ONE","firstName":"Suman","lastName":"Tester79","minPaymentPercentage":4.00,"balance":5464.00},{"id":7,"creditorName":"CAPITAL ONE","firstName":"Suman","lastName":"Tester79","minPaymentPercentage":4.00,"balance":2345.00},{"id":8,"creditorName":"CAPITAL ONE","firstName":"Suman","lastName":"Tester79","minPaymentPercentage":4.00,"balance":836.00},{"id":9,"creditorName":"CBNA","firstName":"Suman","lastName":"Tester79","minPaymentPercentage":3.50,"balance":687.00},{"id":10,"creditorName":"CBNA","firstName":"Suman","lastName":"Tester79","minPaymentPercentage":3.50,"balance":235.00}]');
            res.setStatusCode(200);
            return res;
        }
    }
    
    public class test_error implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"foo":"bar"}');
            res.setStatusCode(400);
            return res;
        }
    }
}
