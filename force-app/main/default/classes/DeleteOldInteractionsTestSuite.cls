@isTest
private class DeleteOldInteractionsTestSuite {
    public static String CRON_EXP = '0 0 0 * * ? 2022';
    
    @testSetup
    static void setup() {
        List<Interaction__c> intns = new List<Interaction__c>();
        // insert 10 interactions with a created date of over one week ago
        for (Integer i=1;i<11;i++) {
            intns.add(new Interaction__c(First_Name__c='Demo' + i,Last_Name__c='Interaction '+ i, Email__c= i+'demo@demo.com', Company__c='MyDemoCompany', createdDate=Date.today().addDays(-14)));
        }
        
        System.debug(intns.size());
        
        insert intns;
        
        System.assertEquals(10, 
                            [Select count() From Interaction__c Where Id In :intns], 
                            'Whoops...No Records Found.'
                           );
        
    }
    
    @isTest static void test() {
        Test.startTest();
        DeleteOldInteractions doi = new DeleteOldInteractions();
        Id batchId = Database.executeBatch(doi);
        Test.stopTest();
        
        // after the testing stops, assert records were updated properly
        System.assertEquals(9, 
                            [Select count() From Interaction__c Where createdDate= :Date.today().addDays(-14)], 
                            'Sorry, couldn\'\t delete that record for you.'
                           );
    }    
    
    @isTest static void testScheduledJob() {
        
        Test.startTest();
        // Schedule the test job
        DailyInteractionDeleteAction dida = new DailyInteractionDeleteAction();
        String jobId = System.schedule('ScheduledApexTest',
            CRON_EXP,
            dida);
       
        dida.execute(null);
        
        // Verify the scheduled job has not run yet.
        
        System.assertEquals(10, 
                            [Select count() From Interaction__c Where createdDate = :Date.today().addDays(-14)], 
                            'Nah bruh, there most definitely are not 10 records here.'
                           );
        // Get the information from the CronTrigger API object
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, 
                          NextFireTime
                          FROM CronTrigger WHERE id = :jobId];
        
        // Verify the expressions are the same
        System.assertEquals(DailyInteractionDeleteActionTest.CRON_EXP, 
                            ct.CronExpression);
        
        // Verify the job has not run
        System.assertEquals(0, ct.TimesTriggered);
        
        // Verify the next time the job will run
        System.assertEquals('2022-05-06 00:00:00', 
                            String.valueOf(ct.NextFireTime));
        
        
        // Stopping the test will run the job synchronously
        Test.stopTest();
        // Now that the scheduled job has executed,

        System.assertEquals(9, 
                            [Select count() From Interaction__c Where createdDate = :Date.today().addDays(-14)], 
                            'The oldest record was not deleted.'
                          );
    }
    
}