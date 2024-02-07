Avaliacao__c[] doomedAccts = [SELECT Name From Avaliacao__c ]; 
try {
    delete doomedAccts;
} catch (DmlException e) {
    // Process exception here
}