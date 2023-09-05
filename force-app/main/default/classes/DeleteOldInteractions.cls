public class DeleteOldInteractions implements Database.Batchable<sObject> {
    
       
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return  Database.getQueryLocator(
        	[Select Id From Interaction__c Where createdDate < :Date.today().addDays(-3)]
        );
        
    }
    
    public void execute(Database.BatchableContext bc, List<Interaction__c> scope){
        
        Batch_Job_Setting__mdt batchJobSetting = [Select Number_To_Delete__c From Batch_Job_Setting__mdt Limit 1];
                
        Integer num = Integer.valueOf(batchJobSetting.Number_To_Delete__c);
                
        List<Interaction__c> intns = new List<Interaction__c>();
        for(Integer i = 0; i < num; i++){
            intns.add(scope[i]);
        }
              
        delete intns;
        
    }
    public void finish(Database.BatchableContext bc){
        
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors,
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
    }
}