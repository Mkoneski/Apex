@RestResource(urlMapping='/Contacts/Clever/*')
global class CleverInsertApi {
    
    @HttpPost
    global static void doPost (String FirstName, String LastName, String phone, String familyPhone, String familyFirstName, String familyLastName, String certifications, String dateInserted) {
        
        Account acc = [Select Id, Name From Account Where Name = 'Clever' Limit 1];
        	Contact contact = new Contact();
        contact.LastName = Lastname;
        contact.phone = phone;
        contact.FirstName = FirstName;
        contact.Contact_First_Name__c = familyFirstName;
        contact.Contact_Last_Name__c = familyLastName;
        contact.Contact_Family_Phone__c = familyPhone;
        contact.Certifications__c = certifications;
        contact.Inserted_Date__c = date.today();
        contact.AccountId = acc.id; 
        
        insert contact;
        
        
    }

}