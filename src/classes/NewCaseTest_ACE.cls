/**
* Test class for NewCaseController.
* <p/><p/>
* @author - Narasimha
**/
@IsTest(SeeAllData=false)
public class NewCaseTest_ACE 
{
    public static user ObjAdminUser;
    
/*
* method to create testData  .
* 
*/     
    @testsetup
    public static void createTestData()
    {
        ObjAdminUser = TestUtilitiesClass_CF.createTestUser('System Administrator', true); 
        System.runAs(ObjAdminUser) {
			Contact ObjContact = TestUtilitiesClass_CF.createContact('LastName', true);
		}
    }
/*
*  test method for testing createCase method positive case.
* 
* 
*/      
    public static testMethod void TestCreateCasePositive()
    {
        //Run as Admin User.
        system.runAs(ObjAdminUser){
        //query the contact.    
        Contact ObjContact = [select id,lastName from contact Limit 1];
        //initialize contact Id.   
        String strContactId = string.valueOf(ObjContact.id);
        
        test.startTest();
        //Call the target method with parameters.    
        NewCaseController_ACE.createCase(strContactId, 'New', 'Mail', 'TestTitle');
        test.stopTest();
        
        //Query for the case and Case Comment.
        case ObjCase = [select id,status,origin from case Limit 1];
        CaseComment objCaseComment = [SELECT Id, CommentBody, ParentId FROM CaseComment LIMIT 1];
        
        //Assert test results.
        system.assertEquals('New', ObjCase.status);
        system.assertEquals('Mail', ObjCase.origin);
        system.assertEquals(objCaseComment.ParentId, ObjCase.Id);
        }  
            
    }
/*
*  test method for testing createCase method Negative case.
* 
* 
*/ 
    public static testMethod void TestCreateCaseNegative()
    {
        //Run as Admin User.
        system.runAs(ObjAdminUser){
            
        //query the contact. 
        Contact ObjContact = [select id,lastName from contact Limit 1];
            
        //initialize contact Id.    
        String strContactId = string.valueOf(ObjContact.id);
        
        test.startTest();
        //Call the target method with parameters.  
        NewCaseController_ACE.createCase(strContactId, 'New', 'Mail', 'TestTitle');
        test.stopTest();
        
        //Query for the case and Case Comment.
        List<case> lstCase = [select id,status,origin from case];
        List<CaseComment> lstCaseComment = [SELECT Id, CommentBody, ParentId FROM CaseComment];
        
        //Assert test results.    
        system.assertEquals(true, lstCase.isempty());
        system.assertEquals(true, lstCaseComment.isempty());
        }
    }
/*
*  test method for testing fetchknowledgeArticles method Negative case.
* 
* 
*/    
    public static testMethod void TestFetchArticleNegative()
    {
        //Run as Admin User.
        system.runAs(ObjAdminUser){
        test.startTest();
            
        //Call the target method with parameters.    
        List<ArticleWrapper> lstArticleWrapper = NewCaseController_ACE.fetchknowledgeArticles('Test Comment');
        test.stopTest();
        
        //Assert test results.        
        system.assertEquals('No article found', lstArticleWrapper[0].strArticleTitle);
        }
        
    }
/*
*  test method for testing fetchknowledgeArticles method Positive case.
* 
* 
*/     
     public static testMethod void TestFetchArticlePositive()
    {
        //Run as Admin User.
        system.runAs(ObjAdminUser){
        
        //create knowledge article and publish
        knowledge__kav objKav = TestUtilitiesClass_CF.createKnowledgeArticle('Test Title','Url',true);
        
        test.startTest();
            
        //Call the target method with parameters.    
        List<ArticleWrapper> lstArticleWrapper = NewCaseController_ACE.fetchknowledgeArticles('Test Comment');
        test.stopTest();
        
        //Assert test results.
        system.assertEquals('Test Title', lstArticleWrapper[0].strArticleTitle);
        }
    }    
}