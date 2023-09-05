@RestResource(urlMapping = '/Interactions/*')
global with sharing class InteractionToolsRest {
    @HttpPost
    global static ID createInteraction(String fname, String lname, String email,
                                       String phone, String street, String city, String stateAbb, String postalCode, String product, String src, String cmpy) {
                                           Interaction__c thisIntn = new Interaction__c(
                                               First_Name__c=fname,
                                               Last_Name__c=lname,
                                               Email__c=email,
                                               Phone__c=phone,
                                               Street__c=street,
                                               City__c=city,
                                               State__c=stateAbb,
                                               Postal_Code__c=postalCode,
                                               Product_of_Interest__c=product,
                                               Company__c=cmpy,
                                               Source__c=src
                                           );
                                           
                                           try {
                                               System.debug(thisIntn);
                                               insert thisIntn;
                                           } catch(Exception ex) {
                                               System.debug(ex);
                                           }
                                           
                                           return thisIntn.Id;
                                           
                                       }
}