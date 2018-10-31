global class ErrorHandlerBatch implements database.Batchable<sObject>
{
     global Database.QueryLocator start(Database.BatchableContext BC) {
        // collect the batches of records or objects to be passed to execute
         
        String query = 'SELECT Id,Name FROM Account';
        return Database.getQueryLocator(query);
    }
     
    global void execute(Database.BatchableContext BC, List<Account> accList) {
        
        // process each batch of records
       contact objContact;
         
        for(Account acc : accList)
        {        
            objContact = new contact();
            objContact.accountid = acc.id;
        }
        
            // Update the Account Record
            DMLOperationResultClass_CF result =  DMLOperationsClass_CF.insertRecord(objContact);
         
         
         
    }   
     
    global void finish(Database.BatchableContext BC) {
        // execute any post-processing operations
  }
}