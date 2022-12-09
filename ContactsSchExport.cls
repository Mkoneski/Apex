public with sharing class ContactsSchExport implements Schedulable {

    public void execute (SchedulableContext sch) {

        String csv = 'Id, Lead Source, Name \n';
        for (List<Contact> cons : [SELECT Id, Name, LeadSource  FROM Contact]) {
            for (Contact con : cons) {
       csv += con.id + ','+ con.LeadSource + ',' + con.name.escapeCsv() + '\n';
            }
            
        }

        ContentVersion file = new ContentVersion(
            title = 'Contacts.csv',
            VersionData = blob.valueOf(csv),
            PathOnClient = '/contacts.csv'
        );
        
        insert file;

        ContentVersion conVer = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id = :file.Id LIMIT 1];

        ContentWorkspace ws = [SELECT Id, RootContentFolderId FROM ContentWorkspace WHERE Name = 'Salesforce' LIMIT 1];

        ContentDocumentLink cdl = new ContentDocumentLink(); cdl.ContentDocumentId = conVer.ContentDocumentId; cdl.ShareType = 'I'; cdl.Visibility = 'AllUsers'; cdl.LinkedEntityId = ws.Id;

        insert cdl;
        
    }
    
}