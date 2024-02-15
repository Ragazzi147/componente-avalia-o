@isTest
private class AvaControllerTest {
    @isTest
    static void testInserirAvaliacao() {
        // Cria uma conta de teste
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        // Chama o método inserirAvaliacao
        Id novoIdAvaliacao = AvaController.inserirAvaliacao('Título de Teste', 'Descrição de Teste', 1, testAccount.Id);

        // Verifica se a nova avaliação foi criada com sucesso
        System.assertNotEquals(null, novoIdAvaliacao);

        // Consulta o registro de Avaliação inserido
        Avaliacao__c avaliacaoInserida = [SELECT Id, Name, Descricao__c, nota__c, Account__c FROM Avaliacao__c WHERE Id = :novoIdAvaliacao LIMIT 1];

        // Verifica os detalhes da Avaliação inserida
        System.assertEquals('Título de Teste', avaliacaoInserida.Name);
        System.assertEquals('Descrição de Teste', avaliacaoInserida.Descricao__c);
        System.assertEquals(1, avaliacaoInserida.nota__c);
        System.assertEquals(testAccount.Id, avaliacaoInserida.Account__c);

        // Limpa os dados de teste
        delete testAccount;
    }
    


    @isTest
    static void testGetAvaliacoes() {
       
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        // Chama o metodo
        List<AvaVO> avaliacoesList = AvaController.getAvaliacoes(testAccount.Id);

        // verifica se é vazio
        System.assertNotEquals(null, avaliacoesList);

        delete testAccount;
    }

    @isTest
    static void testGetMediaNotas() {
       
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
    
       
        Decimal mediaNotas = AvaController.getMediaNotas(testAccount.Id);
    
        System.assertEquals(null, mediaNotas, 'A média de notas deve ser nula');
    
       
        delete testAccount;
    }
    
}