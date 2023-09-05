public class DuplicateLeadAction {

	@InvocableMethod(label='Get Related Leads' description='Find any duplicate lead records whenever a new interaction is created.' category='Lead')
 	public static List<Lead> checkForDupeLeads (List<Interaction__c> intnsToCreate) {
        List<SObject> duplicates = new List<Lead>();
        List<SObject> dupes = new List<SObject>();
        for(Interaction__c intn : intnsToCreate) {
            Lead lead = new Lead();
                lead.FirstName = intn.First_Name__c;
            	lead.LastName  = intn.Last_Name__c;
            	lead.Phone     = intn.Phone__c;
                lead.Email     = intn.Email__c;
            	lead.Company   = intn.Company__c;
            
            duplicates = findDuplicateRecords(lead);
            
            if(duplicates.size() == 0 ){
                dupes.add(null);
            } else {
                dupes.add(duplicates[0]);
            }
        }
        
        System.debug(dupes.size());
        
        return dupes;
    }
    
    public static List<SObject> findDuplicateRecords(Lead lead){
        List<Lead> leadsList = new List<Lead>();
        leadsList.add(lead);
               
        List<Datacloud.FindDuplicatesResult> findDuplicatesResult = Datacloud.FindDuplicates.findDuplicates(leadsList);
        
        System.debug('TC:findDuplicateResult: ' + findDuplicatesResult);
        
        Datacloud.DuplicateResult duplicateResult = findDuplicatesResult.get(0).getDuplicateResults().get(0);
        
        System.debug('TC:duplicateResult: ' + duplicateResult);
        Datacloud.MatchResult matchResult = duplicateResult.getMatchResults()[0];
        
        System.debug('TC:matchResult: ' + matchResult);
        List<Datacloud.MatchRecord> matchRecords = matchResult.getMatchRecords();
        
        List<SObject> duplicates = new List<SObject>();
        for(Datacloud.MatchRecord matchRecord : matchRecords){
            SObject duplicate = matchRecord.getRecord();
            System.debug('Match Record: ' + duplicate);
            duplicates.add(duplicate);
        }
        return duplicates;
    }
}