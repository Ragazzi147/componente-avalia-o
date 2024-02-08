@isTest
private class AvaControllerTest {
    @isTest
    static void testInserirAvaliacao() {
       
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

  
        Id novoIdAvaliacao = AvaController.inserirAvaliacao('Título de Teste', 'Descrição de Teste', 1, testAccount.Id);

        // Verifica se foi criada corretamente
        System.assertNotEquals(null, novoIdAvaliacao);

        Avaliacao__c avaliacaoInserida = [SELECT Id, Name, Descricao__c, nota__c, Account__c FROM Avaliacao__c WHERE Id = :novoIdAvaliacao LIMIT 1];

        // verifica a Avaliação 
        System.assertEquals('Título de Teste', avaliacaoInserida.Name);
        System.assertEquals('Descrição de Teste', avaliacaoInserida.Descricao__c);
        System.assertEquals(1, avaliacaoInserida.nota__c);
        System.assertEquals(testAccount.Id, avaliacaoInserida.Account__c);

        
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
