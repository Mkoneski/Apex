@RestResource(urlMapping='/Contact/*')
global class ToAddContactWithApi {
    
     @HttpPost
    global static String insertContactWithApi(String LastName,
        String phone, String dateInserted) {
            
            Account acc = [Select Id, Name From Account Where Name = 'Atlas' Limit 1];
            
        Contact contact = new Contact();
        contact.LastName = LastName;
        contact.phone = phone;
        contact.Inserted_Date__c = date.today();
        contact.AccountId = acc.id;    	
        
        insert contact;
        return contact.Id;
    }
    
    
    
}