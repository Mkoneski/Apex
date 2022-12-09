public class AccountTriggerHandler {
 
    public static void accountWithTwoRelatedContacts (List<Account> accountList) {
        
        // Да се креира trigger со кој при креирање на Account oд тип Prospect, се креираат 2 нови контакти поврзани со тој Account. 
    
        List<Contact> conToAdd = new List<Contact>();
        for (Account acc : accountList) {
            if (acc.Type == 'Prospect') {
                for (integer i = 0; i < 2; i++) {
                    Contact con = new Contact();
                    con.LastName = acc.Name + i;
                    con.AccountId = acc.Id;
                    conToAdd.add(con);
                    
                }
            }
        }
        if (conToAdd.size() > 0) {
            insert conToAdd;
        }
        
    }
    
    public static void accountWithOpp (List<Account> accountList) {

        // Да се креира trigger со кој на секој нов Account или Account кој се изменува да се креира и Opportunity само доколку веќе не е креирано претходно.

        List<Opportunity> oppList = new List<Opportunity>();
        Map<Id, Account> accWithOpps = new Map<Id, Account>([SELECT Id,(SELECT Id FROM Opportunities) FROM Account WHERE Id IN :accountList]);
        for (Account acc : accountList) {
            If(accWithOpps.get(acc.Id).Opportunities.size() == 0) {
                Opportunity opp = new Opportunity();
                opp.Name = acc.Name + 'Opportunity';
                opp.StageName = 'Prospecting';
                opp.CloseDate = date.today().addYears(1);
                opp.AccountId = acc.Id;
                oppList.add(opp);
            }
            
        }

        if (oppList.size() > 0) {
            insert oppList;
        }

    }


}