@isTest
private class AvaControllerTest {
    @testSetup
    static void setup() {
        // conta de teste
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

     
        Avaliacao__c avaliacao1 = new Avaliacao__c(
            Name = 'Avaliacao 1',
            Descricao__c = 'Descrição 1',
            nota__c = 2.0,
            Account__c = testAccount.Id
        );
        Avaliacao__c avaliacao2 = new Avaliacao__c(
            Name = 'Avaliacao 2',
            Descricao__c = 'Descrição 2',
            nota__c = 4.0,
            Account__c = testAccount.Id
        );
        insert new List<Avaliacao__c>{avaliacao1, avaliacao2};
    }

    @isTest
    static void testInserirAvaliacao() {
     
        Account testAccount = [SELECT Id FROM Account WHERE Name = 'Test Account' LIMIT 1];

        // chama inserirAvaliacao
        Id novoIdAvaliacao = AvaController.inserirAvaliacao('Título de Teste', 'Descrição de Teste', 1, testAccount.Id);

        // verifica se deu certo
        System.assertNotEquals(null, novoIdAvaliacao);

        //consulta resgistro de av inserida
        Avaliacao__c avaliacaoInserida = [SELECT Id, Name, Descricao__c, nota__c, Account__c FROM Avaliacao__c WHERE Id = :novoIdAvaliacao LIMIT 1];

        // verifica os detalhes 
        System.assertEquals('Título de Teste', avaliacaoInserida.Name);
        System.assertEquals('Descrição de Teste', avaliacaoInserida.Descricao__c);
        System.assertEquals(1, avaliacaoInserida.nota__c);
        System.assertEquals(testAccount.Id, avaliacaoInserida.Account__c);
    }

    @isTest
    static void testGetAvaliacoes() {
       
        Account testAccount = [SELECT Id FROM Account WHERE Name = 'Test Account' LIMIT 1];

        // chama o método
        List<AvaVO> avaliacoesList = AvaController.getAvaliacoes(testAccount.Id);

        // verifica se não está vazio
        System.assertNotEquals(null, avaliacoesList);
    }


    @isTest
    static void testGetMediaNotas() {
        // obtém a conta de teste
        Account testAccount = [SELECT Id FROM Account WHERE Name = 'Test Account' LIMIT 1];

        // chama o método getMediaNotas
        Test.startTest();
        Decimal mediaNotas = AvaController.getMediaNotas(testAccount.Id);
        Test.stopTest();

        // verifica se a média de notas é 3.0
        System.assertEquals(3.0, mediaNotas, 'A média de notas deve ser 3.0');
    }
}