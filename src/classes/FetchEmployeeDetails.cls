public class FetchEmployeeDetails 
{
    public static string strEmployeeDetails {get; set;}
    
    public static pagereference getEmployeeDetails()
    {
        Map<String,String> mapHeaderValues = new Map<String,String>();
        string accessToken = ValidateAccessToken.getAccessToken();
        mapHeaderValues.put('access_token', accessToken);
        
        IntegrationWrapperClass_CF objIntegrationWrapperClass =  IntegrationClass_CF.synchronousCallout('MuleSoftAPI', null, true, mapHeaderValues, 10000);
        if(objIntegrationWrapperClass.intResponseStatusCode == 401)
        {  
            AccessTokenDetails__c ObjAccessToken = AccessTokenDetails__c.getInstance('MuleAccessToken');
            accessToken = ValidateAccessToken.getNewAccessToken(ObjAccessToken);
            mapHeaderValues.put('access_token', accessToken);
            IntegrationWrapperClass_CF objIntegrationWrapperClassRt =  IntegrationClass_CF.synchronousCallout('MuleSoftAPI', null, true, mapHeaderValues, 10000);
            
        }
        else if(objIntegrationWrapperClass.intResponseStatusCode == 200)
        {
            
            system.debug(JSON.deserializeUntyped(objIntegrationWrapperClass.strResponseBody));
            
        }
        strEmployeeDetails = string.valueOf(JSON.deserializeUntyped(objIntegrationWrapperClass.strResponseBody));
        return null;
    }
}