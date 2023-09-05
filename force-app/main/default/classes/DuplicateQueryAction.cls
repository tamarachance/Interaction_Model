public class DuplicateQueryAction {
	@InvocableMethod(label='Get Related Contacts' description='Find any duplicate contact records whenever a new interaction is created.' category='Contact')
 	public static List<Contact> checkForDupeContacts (List<Interaction__c> intnsToCreate) {
        List<SObject> duplicates = new List<Contact>();
        List<SObject> dupes = new List<SObject>();
        for(Interaction__c intn : intnsToCreate) {
            Contact contact = new Contact();
                contact.FirstName = intn.First_Name__c;
            	contact.LastName  = intn.Last_Name__c;
            	contact.Email     = intn.Email__c;
            duplicates = findDuplicateRecords(contact);
            
            if(duplicates.size() == 0 ){
                dupes.add(null);
            } else {
                dupes.add(duplicates[0]);
            }
        }
        
        System.debug(dupes.size());
        
        return dupes;
       
    }
    
    public static List<SObject> findDuplicateRecords(Contact contact){
        
        List<SObject> contactList = new List<SObject>();
        contactList.add(contact);
               
        List<Datacloud.FindDuplicatesResult> findDuplicatesResult = Datacloud.FindDuplicates.findDuplicates(contactList);
        
        Datacloud.DuplicateResult duplicateResult = findDuplicatesResult.get(0).getDuplicateResults().get(0);
        Datacloud.MatchResult matchResult = duplicateResult.getMatchResults()[0];
        List<Datacloud.MatchRecord> matchRecords = matchResult.getMatchRecords();
        
        List<SObject> duplicates = new List<SObject>();
        for(Datacloud.MatchRecord matchRecord : matchRecords){
            SObject duplicate = matchRecord.getRecord();
            System.debug('Match Record: ' + duplicate);
            duplicates.add(duplicate);
        }
        System.debug(duplicates.size());
        return duplicates;
    }
}