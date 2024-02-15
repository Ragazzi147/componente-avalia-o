@isTest
private class AccountTriggerHandlerTest {

    @isTest
    static void testAtualizarNotaConta() {
        // criação de Avaliações 
        List<Avaliacao__c> avaliacoesTeste = new List<Avaliacao__c>();
        for (Integer i = 1; i <= 3; i++) {
            Avaliacao__c av = new Avaliacao__c(
                Name = 'Test Avaliacao ' + i,
                nota__c = 3.0 + i
                
            );

            // Ajuste para poder apenas notas de 1 a 5
            if (av.nota__c > 5) {
                av.nota__c = 5.0;
            }
            if (av.nota__c < 1) {
                av.nota__c = 1.0;
            }

            avaliacoesTeste.add(av);
        }
        insert avaliacoesTeste;

        // criação de uma Conta 
        Account contaTeste = new Account(Name = 'Test Account');
        insert contaTeste;

        // mapeia Avaliações para Conta de Teste
        Map<Id, Avaliacao__c> mapAvaliacoes = new Map<Id, Avaliacao__c>();
        for (Avaliacao__c av : avaliacoesTeste) {
            av.Account__c = contaTeste.Id;
            mapAvaliacoes.put(av.Id, av);
        }
        update avaliacoesTeste;

        
        Test.startTest();
        AccountTriggerHandler.atualizarNotaConta(avaliacoesTeste, mapAvaliacoes);
        Test.stopTest();

        // ve se a conta foi atualizada 
        Account contaAtualizada = [SELECT Id, Nota_da_Conta__c FROM Account WHERE Id = :contaTeste.Id LIMIT 1];
        System.assertNotEquals(null, contaAtualizada);
        
        // calculo media
        Decimal mediaEsperada = (3.0 + 4.0 + 5.0) / 3;

        // compara apenas o numero inteiro
        System.assertEquals(mediaEsperada.intValue(), contaAtualizada.Nota_da_Conta__c.intValue());

        
        delete contaTeste;
        delete avaliacoesTeste;
    }

  

}
