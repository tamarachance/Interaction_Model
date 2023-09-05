@isTest
public class DuplicateLeadAction_Test {
    @testSetup
    public static void insertTestData (){
        Lead lead = new Lead();
        lead.FirstName = 'Timothy';
        lead.LastName  = 'Test';
        lead.Email     = 'tim@testdata.com';
        lead.Company   = 'Tim & Company';
        
        insert lead;
    }
    
    public static testMethod void testWithDupeLeads(){
        List<Interaction__c> testList = new List<Interaction__c>();
        for(Integer i=1; i<2; i++){
            Interaction__c intn = new Interaction__c();
            intn.First_Name__c = 'Tim';
            intn.Last_Name__c  = 'Test';
            intn.Email__c      = 'tim@testdata.com';
            intn.Company__c    = 'Tim & Company';
            
            testList.add(intn);
        }
        
        test.startTest();
        List<Lead> duplicates = DuplicateLeadAction.checkForDupeLeads(testList);
        test.stopTest();
        
        System.assert(duplicates.size() > 0);

    }
    
    public static testMethod void testWithoutDupeLeads(){
        List<Interaction__c> testList2 = new List<Interaction__C>();
        for(Integer i=1; i<2; i++){
            Interaction__c intn = new Interaction__c();
            intn.First_Name__c = 'Test' + 1;
            intn.Last_Name__c = 'Tester'+1;
            intn.Email__c = 1+'test@testdata.com';
            
            testList2.add(intn);
        }
        
        test.startTest();
        List<Lead> duplicates = DuplicateLeadAction.checkForDupeLeads(testList2);
        test.stopTest();
        
        System.assertEquals(null, duplicates[0]);

    }
}