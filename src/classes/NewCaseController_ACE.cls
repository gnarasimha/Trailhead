/**
* controller class for contact search Lightning component.
* <p/><p/>
* @author - Narasimha
*/
public class NewCaseController_ACE 
{ 
    
    @AuraEnabled public static string strError {get; set;}
    

    /**
     *  method for creating case.
     *
     * @param strStatus Case status.
     * @param strOrigin Case Origin.
     * @param strComment Case comment.
     * @param strContactId Contact Id.
     * @return The list of String with case comments and error log name.
     */    
    @AuraEnabled
    public static List<string> createCase(string strStatus,string strOrigin,string strComment,string strContactId)
    {
        
        List<sObject> lstInsertObjs = new List<sObject>();
        List<string> lstRetString = new List<string>();
        string strExtId = createUniqueString();
        
        // Create Case reference with unique string to insert case and case comments in single DML.
        case objCaseReference = new case(ExternalID__c = strExtId);
        
        //Create case comment object and assign case reference
        CaseComment objCaseCom = new CaseComment();
        objCaseCom.Parent = objCaseReference;
        
        // Create Actual case record and reference via external ID field - ExternalId.
        case objNewCase = new case();
        objNewCase.Status = strStatus;
        objNewCase.Origin = strOrigin;
        objNewCase.ContactId = id.valueOf(strContactId);
        objNewCase.ExternalID__c = strExtId;
        lstInsertObjs.add(objNewCase);
        lstInsertObjs.add(objCaseCom);
        
        //Using try catch to explicitally catch exception if any and insert ErrorLog record
        try{
            insert lstInsertObjs;
        }
        
        //Catch exception and create error log record and query the error log table to get Error log name.
        catch(Exception e){
            ErrorLog_CF__c objError =  new ErrorLog_CF__c();
            objError.StackTrace_CF__c = e.getStackTraceString();
            objError.Message_CF__c = e.getMessage();
            insert objError;
            
            objError = [select id,name from ErrorLog_CF__c where id=:objError.id];
            strError = objError.name;
        }
        
        //Add Comments to the return list of strings.
        lstRetString.add(strComment);
        
        //Add Error name in case of any exceptions.
        if(strError != null)
            lstRetString.add(strError);
        
        //Return list of strings with comments and error logs.
        return lstRetString;
    }
    
    /**
    *  method for creating Unique string.
    * 
    *  @return String Random Unique string.
    */   
    @AuraEnabled
    public static string createUniqueString()
    {
        //create string value of current time.
        string strTime = string.valueOf(system.now());
        Blob hash = Crypto.generateDigest('MD5', Blob.valueOf(strTime));
        String uniqueString = EncodingUtil.convertToHex(hash).substring(0,20);
        return uniqueString;
    }
    /**
    *  method for getting Knowledge Articles.
    * 
    * @param strCaseComments Case comments. 
    * @return ArticleWrapper  The list of ArticleWrapper with article Id and title.
    */       
    @AuraEnabled
    public static List<ArticleWrapper> fetchknowledgeArticles(string strCaseComments)
    {
        // Define list of articleWrapper.
        List<ArticleWrapper> lstArticleWrapper = new List<ArticleWrapper>();
        List<string>lstComments = new List<string>();
        
        //Process string to disect case comments to a list of strings.
        lstComments.addAll(strCaseComments.split(' '));
        
        // Initialize search string.
        string strSearch = '';
        
       // Form search string to be used in SOSL.
        if(lstComments != null)
        {
              strSearch ='"';
              strSearch += string.join(lstComments, '" OR "');
              strSearch += '"';
        }
        
        // Declare Search result and list of search results to hold the result of SOSL.
        Search.SearchResults objArticles;
        List<Search.SearchResult> lstArticleResults = new List<Search.SearchResult>();
        
        
        // SOSL to search Knowledge articles based on case comments.
        if(strSearch != '')
        {
            objArticles = Search.find('FIND :strSearch IN ALL FIELDS RETURNING KnowledgeArticleVersion(Id, Title, UrlName' + ' WHERE PublishStatus = \'Online\' ORDER BY CreatedDate DESC LIMIT 3)');
            lstArticleResults = objArticles.get('KnowledgeArticleVersion');
        }
        
        // create Article wrapper from SOSL results.
        if (!lstArticleResults.isEmpty()) {
            for (Search.SearchResult searchResult : lstArticleResults) {
                KnowledgeArticleVersion objArticle = (KnowledgeArticleVersion) searchResult.getSObject();
                lstArticleWrapper.add(new ArticleWrapper(String.valueOf(objArticle.Id), objArticle.Title, null,null));
            }
        } 
        // Create article wrapper for no results
        else {
            lstArticleWrapper.add(new ArticleWrapper(null,'Label.NoArticle_ACE', null, null));
        }
        
        
        //Return list of ArticleWrapper.
        return lstArticleWrapper;
    }
}