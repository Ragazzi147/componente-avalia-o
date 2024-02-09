public with sharing class AvaController {
    public class AvaliacaoWrapper {
        @AuraEnabled public String titulo;
        @AuraEnabled public String descricao;
        @AuraEnabled public Decimal nota;
        @AuraEnabled public Id accountId;
    }

    @AuraEnabled
    public static String getUserDetails(){
        return UserInfo.getName();
    }

    @AuraEnabled
    public static Id inserirAvaliacao(String titulo, String descricao, Decimal nota, Id accountId ) {
        system.debug(accountId);
        
         Avaliacao__c novoRegistro = new Avaliacao__c(
                 Name = titulo,
                 Descricao__c = descricao,
                 nota__c = nota,
                 Account__c = accountId
                 
                 
                 );
        System.debug(novoRegistro);
        try {
            insert novoRegistro;
            return novoRegistro.Id;
        } catch (Exception e) {
            return 'Erro ao cadastrar avaliação: ' + e.getMessage();
        }
    }
     @AuraEnabled
      public static List<AvaVO> getAvaliacoes(Id accountId) {
        List<Avaliacao__c> avaliacoes = AvaDAO.AvaDAO(accountId);
        List<AvaVO> avaliacoesVO = new List<AvaVO>();
        for (Avaliacao__c av  : avaliacoes) {
            AvaVO listAva = new  AvaVO(av);
            avaliacoesVO.add(listAva);
        }
        
        return avaliacoesVO;
    }

      @AuraEnabled
    public static Decimal getMediaNotas(Id accountId) {
        AggregateResult result = [
            SELECT AVG(nota__c) averageNota
            FROM Avaliacao__c
            WHERE Account__c = :accountId
        ];

        return (Decimal)result.get('averageNota');
    }
   
}