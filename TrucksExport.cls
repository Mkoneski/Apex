public class TrucksExport implements Schedulable {
    
    public void execute (SchedulableContext ctx) {
        
        String csv = 'Id,Truck Pictures,Name\n';
for ( List<Truck__c> trucks : [ Select Description__c, Status__c, Fuel_Tank_Size__c, Id, Name, OwnerId, Price__c, State__City__s, State__PostalCode__s, State__c, TruckId__c, Truck_Pictures__c, Type__c FROM Truck__c ] ) {
  for ( Truck__c truck : trucks ) {
    csv += truck.id + ','+ truck.Truck_Pictures__c + ',' + truck.name.escapeCsv() + '\n';
  }
}
 
ContentVersion file = new ContentVersion(
  title = 'TrucksWithPics.csv',
  versionData = Blob.valueOf( csv ),
  pathOnClient = '/Trucks.csv'
);
 
insert file;
System.debug( file );
        
    }

}