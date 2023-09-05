@isTest
public class TestInteractionToolsRest {
    @isTest static void testCreateInteraction(){
       // Call the method to test
       ID thisIntnId = InteractionToolsRest.createInteraction('myName','myLastName','myname.mylastname@email.com',
                                                              '337-373-7733', '373 thisStreet', 'thisCity', 'ST', '37373','Placeholder','Web','thisCmpy');
       // Verify results
       System.assert(thisIntnId != null);
        
       Interaction__c thisIntn = [SELECT Id, Email__c, Source__c FROM Interaction__c WHERE Id=:thisIntnId];
       System.assert(thisIntn != null);
       System.assertEquals(thisIntn.Email__c, 'myname.mylastname@email.com');
       System.assertNotEquals(thisIntn.Source__c, 'Phone');
    }
    
}