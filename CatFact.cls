public class CatFact {
    
    public String catFact1{get;set;}
     public String catFact2{get;set;}
    
    
    public catFact(ApexPages.StandardController stdController){
        
        Account account = (Account)stdController.getRecord();
        account=[select id from Account where Id=:account.Id];
        
        String requestEndPoint = 'https://catfact.ninja/fact';
        
        Http http=new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(requestEndPoint);
        request.setMethod('GET');
        HttpResponse response=http.send(request);
        
        if(response.getStatusCode()==200){
            
            Map<String, Object> results=(Map<String, Object>) JSON.deserializeUntyped(response.getBody());
             catFact1=String.valueOf(results.get('fact'));           
            
        }
        
        else {
            ApexPages.Message myMsg=new ApexPages.Message(ApexPages.Severity.ERROR, 'There was an error in reading Data');
            ApexPages.addMessage(myMsg);
        }
        
        
    }

}