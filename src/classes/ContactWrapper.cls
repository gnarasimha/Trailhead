/**
* Wrapper class for contact search Lightning component.
* <p/><p/>
* @author - Narasimha
**/

public class ContactWrapper 
{
    // Initialize variables.
    @AuraEnabled
    public contact objcontact{get; set;}
    @AuraEnabled
    public string strAdditionalInfo {get; set;}
    
    
    //Constructor. 
    public ContactWrapper(contact objContact,string strAdditionalInfo)
    {
        
        //Assign variables.
        this.objcontact = objContact;
        this.strAdditionalInfo = strAdditionalInfo;
       
    }
    // Constructor with only contact as parameter.
    public ContactWrapper(contact objContact)
    {
        
        //Assign variables.
        this.objcontact = objContact;
       
    }
    
}