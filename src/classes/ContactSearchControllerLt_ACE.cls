/**
* controller class for contact search Lightning component.
* <p/><p/>
* @author - Narasimha
**/
public class ContactSearchControllerLt_ACE 
{
    
    
/*
*  method for searching Contacts.
* @param strFirstName Contact first name.
* @param strLastName Contact last name.
* @return The list of Matching Contacts as wrapper.
*/
    @AuraEnabled
    public static List<contactWrapper> fetchContacts(String strFirstName,String strLastName)
    {
        //Initialize wrapper.
        List<contactWrapper> lstConWrapper = new List<contactWrapper>();
        
        //create dynamic query.
        string strDynamicQuery = 'select Id,FirstName,LastName,Name from Contact where ';
        
        if(strFirstName != null && strFirstName != '' && strLastName != '' && strLastName != null)
            strDynamicQuery = strDynamicQuery+'FirstName =\''+strFirstName +'\' And LastName =\''+strLastName+'\'';
        
        else if((strLastName != '' && strLastName != null) && (strFirstName == null || strFirstName == '') )
        {
            strDynamicQuery = strDynamicQuery+'LastName =\''+strLastName+'\'';
        }
        
         //Query for contacts.
         List<contact> lstContact = database.query(strDynamicQuery);
        
        
        if(lstContact != null && !lstContact.isEmpty())
        {
            //Make callout to get additional info.
           /* IntegrationWrapperClass_CF cf = IntegrationClass_CF.callout(false, 'JsonEcho', null, null, null, 5000, null, true, null);
            Map<string,object> StrMap = (Map<string,object>)json.deserializeUntyped(cf.strResponseBody); 
            String strAdditionalInfo = (String)StrMap.get('key');*/
            String strAdditionalInfo = 'Test';
            
            //populate wrapper.
            for(contact c : lstContact)
            {
                lstConWrapper.add(new contactWrapper(c,strAdditionalInfo));
            }
        }
        return lstConWrapper;
    }
    
/*
*  method for creating Contact.
* @param strFirstName Contact first name.
* @param strLastName Contact last name.
* @return boolean  true - If contact is successfully created.
*/
    
    @AuraEnabled
    public static boolean createContact(String strFirstName,String strLastName)
    {
        
        List<contactWrapper> lstConWrapper = new List<contactWrapper>();
        
        //Create new contact.
        Contact objContact = new contact();
        objContact.FirstName = strFirstName;
        objContact.LastName = strLastName;
       // DMLOperationResultClass_CF result =  DMLOperationsClass_CF.insertRecord(objContact);
        insert objContact;
        //return result.lstResults[0].boolIsSuccess;
        return true;
       
    }
}