public class CatFactsDaily {
    
      public CatFactsDaily(){
        toGetFacts();
    }
    
     public String catFact3{get;set;}
    
    public void toGetFacts() {
        String requestEndPoint = 'https://catfact.ninja/fact';
        
        Http http=new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(requestEndPoint);
        request.setMethod('GET');
        HttpResponse response=http.send(request);
        
        if(response.getStatusCode()==200){
            
            Map<String, Object> results=(Map<String, Object>) JSON.deserializeUntyped(response.getBody());
             catFact3=String.valueOf(results.get('fact'));           
            
        }
        
        else {
            ApexPages.Message myMsg=new ApexPages.Message(ApexPages.Severity.ERROR, 'There was an error in reading Data');
            ApexPages.addMessage(myMsg);
        }
        
    }

}