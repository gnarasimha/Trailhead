/**
* JS Helper class for KnowledgeArticle Lightning component.
* <p/><p/>
* @author Narasimha
**/
({
    
/*
*  method for to fetch articles.
* 
*/     
    showRelatedArticlesHelper : function(component, event, helper) {
        
        //listen to event and get attributes 
        var caseCommentsfrEvent = event.getParam("strCaseComment");
        
        //Initialize action.
        var getKnowledgeArticleAction = component.get("c.fetchknowledgeArticles");
        
        //set apex method paramaters.
        getKnowledgeArticleAction.setParams({
            strCaseComments: caseCommentsfrEvent
        });
        
        //Define call back for apex method.
        getKnowledgeArticleAction.setCallback(this, function (response) 
                                              {
                                                  var state = response.getState();
                                                  var ArticleWrapper = response.getReturnValue();
                                                  if (state === "SUCCESS" && ArticleWrapper != null && ArticleWrapper != 'undefined') {  
                                                      //set variables on error.
                                                      if(ArticleWrapper.length == 1 && ArticleWrapper.strArticleTitle == "No article found")
                                                      {
                                                          component.set('v.boolMessage', true);
                                                          
                                                      }
                                                      //set variables on success.
                                                      else
                                                      {
                                                          component.set('v.lstArticles', ArticleWrapper);
                                                      }
                                                  }
                                              });
        $A.enqueueAction(getKnowledgeArticleAction);
    }
})