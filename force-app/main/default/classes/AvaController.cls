public with sharing class AvaController {
    public class AvaliacaoWrapper {
        @AuraEnabled public String titulo;
        @AuraEnabled public String descricao;
        @AuraEnabled public Decimal nota;
        @AuraEnabled public Id AccountId;
    }

    @AuraEnabled
    public static Id inserirAvaliacao(String titulo, String descricao, Decimal nota, Id AccountId ) {

         Avaliacao__c novoRegistro = new Avaliacao__c(
                 Name = titulo,
                 Descricao__c = descricao,
                 Nota__c = nota,
                 Account__c =AccountId
                 );
        
        try {
            insert novoRegistro;
            return novoRegistro.Id;
        } catch (Exception e) {
            return 'Erro ao cadastrar avaliação: ' + e.getMessage();
        }
    }
     @AuraEnabled(cacheable=true)
      public static List<Avaliacao__c> getAvaliacoes(Id accountId) {
          return [SELECT Id, Name, Descricao__c, Nota__c FROM Avaliacao__c WHERE Account__c = :accountId];
      }
}
