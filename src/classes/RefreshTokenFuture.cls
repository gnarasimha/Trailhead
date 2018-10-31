public class RefreshTokenFuture {
    
    @future(callout = true)
    public static void futureRefreshToken()
    {
        AccessToken__mdt ObjAccessToken = [Select AccessExpiryTime__c,AccessToken__c,AccessTokenUrl__c from AccessToken__mdt where DeveloperName = 'MuleSoftPoc' ];
        HttpRequest Request = new HttpRequest();
        Request.setEndpoint(ObjAccessToken.AccessTokenUrl__c);
        Request.setMethod('GET');
        Http http = new Http();
        HTTPResponse Response = http.send(Request);
        
        System.debug('****'+ Response.getBody());
        
        Map<string,object> StrMap = (Map<string,object>)json.deserializeUntyped(Response.getBody());
        String strAccessToken = (String)StrMap.get('access_token');
        
        Metadata.CustomMetadata customMetadata =  new Metadata.CustomMetadata();
        customMetadata.fullName = 'AccessToken.MuleSoftPoc';
        customMetadata.label = 'MuleSoftPoc';
        
        Metadata.CustomMetadataValue customField = new Metadata.CustomMetadataValue();
        customField.field = 'AccessToken__c';
        customField.value = strAccessToken ;
        
        Metadata.CustomMetadataValue customField2 = new Metadata.CustomMetadataValue();
        customField2.field = 'AccessExpiryTime__c';
        customField2.value = system.now().addSeconds(integer.valueOf(StrMap.get('expires_in')));
        
        customMetadata.values.add(customField);
        customMetadata.values.add(customField2);
        
        
        Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();
        mdContainer.addMetadata(customMetadata);
        Metadata.DeployCallback callback = new MetadataDeployCallBack();
        Id jobId = Metadata.Operations.enqueueDeployment(mdContainer,callback);
        
        
    }

}