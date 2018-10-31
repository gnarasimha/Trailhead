/**
* controller class for contact search Page.
* <p/><p/>
* @author - Narasimha
**/
public class ContactSearchController_ACE
{
    //Public Variables
    public static List<Contact> lstcontacts { get; set; }
    public static String strFirstname { get; set; }
    public static String strLastname { get; set; }
    public static List<contactWrapper> lstConWrapper {get; set;}
    public static boolean boolSearched {get; set;}
    
    /*
*  method for searching Contacts.
* @param strFirstName Contact first name.
* @param strLastName Contact last name.
* @return The list of Matching Contacts as wrapper.
*/
    
    public void searchContacts()
        
    {
        //make searched boolean true
        boolSearched = true;
        
        //get the form input values from apex page
        strFirstname = ApexPages.currentPage().getParameters().get('FirstName') ;
        strLastname = ApexPages.currentPage().getParameters().get('LastName');
        
        //Build dynamic query
        string strDynamicQuery = 'select Id,FirstName,LastName,Name from Contact where ';
        if(strFirstname != null && strFirstname != '' && strLastname != '' && strLastname != null)
            strDynamicQuery = strDynamicQuery+'FirstName =\''+strFirstname +'\' And LastName =\''+strLastname+'\'';
        else if((strLastname != '' && strLastname != null) && (strFirstname == null || strFirstname == '') )
        {
            strDynamicQuery = strDynamicQuery+'LastName =\''+strLastname+'\'';
        }
        
        //query for contacts
        lstcontacts = database.query(strDynamicQuery);
        
        if(lstcontacts != null && !lstcontacts.isEmpty())
        {
            //Make callout to get additional info
            IntegrationWrapperClass_CF responseJson = IntegrationClass_CF.callout(false, 'JsonEcho', null, null, null, 5000, null, true, null);
            Map<string,object> mapAddInfo = (Map<string,object>)json.deserializeUntyped(responseJson.strResponseBody);
            String strAdditionalInfo = (String)mapAddInfo.get('key');
            
            //Initialize and populate wrapper
            lstConWrapper = new List<contactWrapper>();
            for(contact c : lstcontacts)
            {
                lstConWrapper.add(new contactWrapper(c,strAdditionalInfo));
            }    
        }       
    }
    
/*
*  method for creating Contact.
* 
*/
    
    
    Public void createCon()
    {
        //Get input from apex page
        strFirstname = ApexPages.currentPage().getParameters().get('FirstName') ;
        strLastname = ApexPages.currentPage().getParameters().get('LastName');
        
        //Create new contact
        Contact objContact = new Contact();
        objContact.Firstname = strFirstname;
        objContact.LastName = strLastname;
        DMLOperationResultClass_CF result =  DMLOperationsClass_CF.insertRecord(objContact);
        if(result.lstResults[0].boolIsSuccess)
        {
            //populate wrapper with new contact
            
            lstConWrapper = new List<contactWrapper>();
            lstConWrapper.add(new contactWrapper((Contact)result.lstRecords[0]));          
        }
    }   
}