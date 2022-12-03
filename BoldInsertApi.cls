@RestResource(urlMapping='/Contacts/bold/*')
global class BoldInsertApi {
    
     @HttpPost
    global static void doPost(String Lastname,
        String phone, string attachmentName, string blobString) {
        Account acc = [Select Id, Name From Account Where Name = 'Bold' Limit 1];
        Contact contact = new Contact();
        contact.LastName = Lastname;
        contact.phone = phone;
        contact.AccountId = acc.id; 
        
        insert contact;
        
    // Creating a csv file  
    ContentVersion contentVer = new ContentVersion();
       contentVer.ContentLocation = 'S'; 
       contentVer.PathOnClient = attachmentName;
       contentVer.Title = attachmentName;
       contentVer.VersionData = blob.valueOf(blobString); 
       contentVer.FirstPublishLocationId  = contact.Id;

        insert contentVer ;
            
            
    }

}