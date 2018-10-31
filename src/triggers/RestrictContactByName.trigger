trigger RestrictContactByName on Contact (before insert, before update) {	
    //check contacts prior to insert or update for invalid data
    List<contact> cList = new List<contact>();
    
    For (Contact c : Trigger.New) {
        if(c.LastName == 'INVALIDNAME') {	//invalidname is invalid
            c.AddError('The Last Name "'+c.LastName+'" is not allowed for DML');
        }
        if(c.Lastname == 'Test')
        cList.add(c);   
    }
    
    for(contact c : cList)
    {
        c.firstName = 'This works';
        
    }
}