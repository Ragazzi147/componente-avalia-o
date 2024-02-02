public class AccountTriggerHandler {
    public static void atualizarNotaConta(List<Avaliacao__c> novasAvaliacoes, Map<Id, Avaliacao__c> avaliacoesAntigas) {
        Set<Id> accountIds = new Set<Id>();

        for (Avaliacao__c avaliacao : novasAvaliacoes) {
            accountIds.add(avaliacao.Account__c);
        }

        for (Id accountId : accountIds) {
            calcularEAtualizarNota(accountId);
        }
    }

    private static void calcularEAtualizarNota(Id accountId) {
        List<Avaliacao__c> avaliacoes = [SELECT Id, Nota__c FROM Avaliacao__c WHERE Account__c = :accountId];
        Decimal totalNotas = 0;
    
        for (Avaliacao__c avaliacao : avaliacoes) {
            totalNotas += avaliacao.Nota__c;
        }
    
        Decimal mediaNota = avaliacoes.isEmpty() ? 0 : totalNotas / avaliacoes.size();
    
        Account conta = new Account(Id = accountId, Nota_da_Conta__c = mediaNota.round());
        update conta;
    }
}
