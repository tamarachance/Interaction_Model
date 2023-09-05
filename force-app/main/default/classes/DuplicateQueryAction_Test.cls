@isTest
public class DuplicateQueryAction_Test {
    @testSetup
    public static void insertTestData (){
        Contact contact = new Contact();
        contact.FirstName = 'Test';
        contact.LastName  = 'Tester';
        contact.Email     = 'test@testdata.com';
        
        insert contact;
    }
    
    public static testMethod void testWithDupeContacts(){
        List<Interaction__c> testList = new List<Interaction__C>();
        for(Integer i=1; i<11; i++){
            Interaction__c intn = new Interaction__c();
            intn.First_Name__c = 'Test';
            intn.Last_Name__c = 'Tester';
            intn.Email__c = 'test@testdata.com';
            
            testList.add(intn);
        }
        
        test.startTest();
        List<Contact> duplicates = DuplicateQueryAction.checkForDupeContacts(testList);
        test.stopTest();
        
        System.assert(duplicates.size() > 0);

    }
    
    public static testMethod void testWithoutDupeContacts(){
        List<Interaction__c> testList2 = new List<Interaction__C>();
        for(Integer i=2; i<12; i++){
            Interaction__c intn = new Interaction__c();
            intn.First_Name__c = 'Test' + i;
            intn.Last_Name__c = 'Tester'+ i;
            intn.Email__c = i +'test@testdata.com';
            
            testList2.add(intn);
        }
        
        test.startTest();
        List<Contact> duplicates = DuplicateQueryAction.checkForDupeContacts(testList2);
        test.stopTest();
        
        System.assertEquals(null, duplicates[0]);

    }
}