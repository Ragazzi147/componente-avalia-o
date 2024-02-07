public with sharing class AvaDAO {
    public static List<Avaliacao__c> AvaDAO(Id accountId) {
        return [SELECT Id, Account__c, Name, Descricao__c, nota__c, CreatedBy.Name FROM Avaliacao__c WHERE Account__c = :accountId];
    }
}