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

    public static void calcularEAtualizarNota(Id accountId) {
        // TODO: Substituir a chamada direta para o DAO
        List<Avaliacao__c> avaliacoes = AvaDAO.AvaDAO(accountId);
        Decimal totalNotas = 0;

        for (Avaliacao__c avaliacao : avaliacoes) {
            totalNotas += avaliacao.nota__c;
        }

        Decimal mediaNota = avaliacoes.isEmpty() ? 0 : totalNotas / avaliacoes.size();

        // Atualizar a conta com a média das notas no campo Nota_da_Conta__c
        Account conta = new Account(Id = accountId, Nota_da_Conta__c = mediaNota);

        try {
            update conta;
        } catch (Exception e) {
            // Lida com exceções ao atualizar a conta, se necessário.
            System.debug('Error updating account: ' + e.getMessage());
        }
    }
}
