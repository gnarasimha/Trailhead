/**
* JS controller class for KnowledgeArticle Lightning component.
* <p/><p/>
* @author Narasimha
**/
({
    
/*
*  method to fetch articles.
* 
*/     
    displayRelatedArticles : function(component, event, helper) {
        
        helper.showRelatedArticlesHelper(component, event, helper);
        
    },
    
/*
*  method to redirect url.
* 
*/    
    ArticleUrl : function(component, event, helper) {
        
        var viewRecordEvent = $A.get("e.force:navigateToSObject");
        viewRecordEvent.setParams({
            
            "recordId": event.target.id
        });
        viewRecordEvent.fire();
    } 
})