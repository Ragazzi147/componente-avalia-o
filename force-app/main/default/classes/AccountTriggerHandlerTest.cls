@isTest
private class AccountTriggerHandlerTest {

    @isTest
    static void testAtualizarNotaConta() {
        // Criação de Avaliações de Teste
        List<Avaliacao__c> avaliacoesTeste = new List<Avaliacao__c>();
        for (Integer i = 1; i <= 3; i++) {
            Avaliacao__c av = new Avaliacao__c(
                Name = 'Test Avaliacao ' + i,
                nota__c = 3.0 + i
                // Adicione outros campos necessários
            );
            // Ajuste para garantir que a nota esteja no intervalo permitido
            if (av.nota__c > 5) {
                av.nota__c = 5.0;
            }
            if (av.nota__c < 1) {
                av.nota__c = 1.0;
            }
            avaliacoesTeste.add(av);
        }
        insert avaliacoesTeste;

        // Obtém a conta associada às avaliações de teste
        Id accountId = avaliacoesTeste[0].Account__c;

        // Executa a lógica que precisa ser testada
        Test.startTest();
        // Chama o método estático da classe de trigger handler
        AccountTriggerHandler.atualizarNotaConta(avaliacoesTeste, new Map<Id, Avaliacao__c>());
        Test.stopTest();

        // Verifica se a média da nota da conta foi atualizada corretamente
        Account contaAtualizada = [SELECT Id, Nota_da_Conta__c FROM Account WHERE Id = :accountId LIMIT 1];

        // Certifica-se de que a conta foi encontrada e a nota foi calculada corretamente
        System.assertNotEquals(null, contaAtualizada, 'A conta não foi encontrada.');
        Decimal mediaEsperada = (3.0 + 4.0 + 5.0) / 3; // Média das notas de teste
        System.assertEquals(mediaEsperada, contaAtualizada.Nota_da_Conta__c, 'A média de notas não está correta.');
    }
}
