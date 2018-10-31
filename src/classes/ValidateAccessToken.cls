/**
* Class to obtain access token and update custom setting for Mulesoft.
* <p/><p/>
* @author - Narasimha
**/
@RestResource(urlMapping='/getAccess')
global class ValidateAccessToken 
{
    public static boolean boolTokenActive;
    
    
    
    
/*
*  method for validating access token from custom setting.
* 
* @return string Accesstoken.
*/
    @httpGet
    global static string getAccessToken()
    {
        
        //current time
        dateTime dtNow  = system.now();
        //Add buffer of 20 seconds for timeout period of 120 secs
        dtNow.addSeconds(20);
        
        //Get the custom setting record
        AccessTokenDetails__c ObjAccessToken = AccessTokenDetails__c.getInstance('MuleAccessToken');
        
        //check if the access token is valid based on expiry time if valid return access token from CS else call getNewAccessToken method
        if(dtNow < ObjAccessToken.AccessExpiryTime__c)
            return ObjAccessToken.AccessToken__c;
        else 
            return getNewAccessToken(ObjAccessToken);
        
    }
    
    
    /*
*  method to obtain access token and update cs.
* @param instance of obj  AccessTokenDetails__c
* @return string Accesstoken.
*/    
    
    
    
    global static string getNewAccessToken(AccessTokenDetails__c objMuleAccessToken)
    {
        //create header with client Id and secret 
        Map<String,String> mapHeaderValues = new Map<String,String>();
        String strAccessToken;
        mapHeaderValues.put('client_secret', 'iMNR_xkBfvx4DWzef8DCURZ1Et4X_lA');
        mapHeaderValues.put('client_id', '0oag51h3ld9F87Rt90h7');
        
        // Make callout to get access token
        IntegrationWrapperClass_CF objIntegrationWrapperClass =  IntegrationClass_CF.synchronousCallout('MuleSoftJWT', null, true, mapHeaderValues, 10000);
        
        // if successful update the custom setting
        if (objIntegrationWrapperClass.intResponseStatusCode == 200)
        {
            Map<string,object> StrMap = (Map<string,object>)json.deserializeUntyped(objIntegrationWrapperClass.strResponseBody);
            strAccessToken = (String)StrMap.get('accessCode');         
        }   
        
        // Update the Custom setting record
        AccessTokenDetails__c ObjAccessToken = new AccessTokenDetails__c(name = objMuleAccessToken.name);
        ObjAccessToken.AccessToken__c =  strAccessToken;
        ObjAccessToken.AccessExpiryTime__c = system.now().addSeconds(120);
        
        // Update CS record via rest as further callout is not allowed after DML
        // Serialize object
        String strJSONBody = JSON.serialize(ObjAccessToken);
        mapHeaderValues.clear();
        mapHeaderValues.put('Authorization', 'Bearer '+ UserInfo.getSessionId());
        mapHeaderValues.put('Content-Type', 'application/json;charset=UTF-8');
        // mapHeaderValues.put('Content-Length','0');
        
        //Rest Callout to update custom setting record
        //IntegrationWrapperClass_CF objIntegrationWrapperClassUpdateCS =  IntegrationClass_CF.synchronousCallout('UpdateCS', '?_HttpMethod=PATCH', false, mapHeaderValues, 10000);
        
        
        HttpRequest objHTTPRequest = new HttpRequest();
        string strRestResouceURLForoAuth= URL.getSalesforceBaseUrl().toExternalForm() +'/services/data/v43.0/sobjects/AccessTokenDetails__c/'+objMuleAccessToken.id+'?_HttpMethod=PATCH';
        objHTTPRequest.setMethod('POST');
        objHTTPRequest.setEndPoint(strRestResouceURLForoAuth);
        objHTTPRequest.setHeader('Authorization', 'Bearer '+ UserInfo.getSessionId());
        objHTTPRequest.setHeader('Content-Type', 'application/json;charset=UTF-8');
        objHTTPRequest.setBody(strJSONBody);
        Http objHttp = new Http();
        HttpResponse objHttpResponse = new HttpResponse();
        objHttpResponse = objHttp.send(objHTTPRequest);
        
       
        
        //return accessToken
        return strAccessToken;
        
    }
    
}