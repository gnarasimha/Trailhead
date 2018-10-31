/**
* Wrapper class for Knowledge Articles Lightning component.
* <p/><p/>
* @author - Narasimha
**/
public class ArticleWrapper 
{
    //Initialize variables
    @auraEnabled public string strArticleId {get; set;} 
    @auraEnabled public string strArticleTitle {get; set;}
    @auraEnabled public string strCaseComments {get; set;}
    @auraEnabled public string strErrorLogName {get; set;}
    

/*
*  Constructor
* 
*/      
    public ArticleWrapper(string strArticleId,string strArticleTitle ,string strCaseComments,string strErrorLogName)
    {
       this.strArticleId =  strArticleId;
       this.strArticleTitle = strArticleTitle; 
       this.strCaseComments = strCaseComments;
       this.strErrorLogName =  strErrorLogName;
        
    }
    
}