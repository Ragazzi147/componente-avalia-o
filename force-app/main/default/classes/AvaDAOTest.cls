@isTest
private class AvaDAOTest {

    @isTest
    static void testAvaDAO() {
        // Crie uma conta de teste
        Account contaTeste = new Account(Name = 'Conta de Teste');
        insert contaTeste;

        // Crie uma avaliação associada à conta de teste
        Avaliacao__c avaliacaoTeste = new Avaliacao__c(
            Name = 'Avaliacao de Teste',
            Descricao__c = 'Descrição Teste',
            nota__c = 4.0,
            Account__c = contaTeste.Id
        );
        insert avaliacaoTeste;

        // Execute o método da AvaDAO para obter avaliações associadas à conta de teste
        List<Avaliacao__c> avaliacoesObtidas = AvaDAO.AvaDAO(contaTeste.Id);

        // Verifique se a avaliação de teste está presente na lista
        System.assertEquals(1, avaliacoesObtidas.size());
        System.assertEquals(avaliacaoTeste.Id, avaliacoesObtidas[0].Id);

        // Limpe os dados de teste
        delete contaTeste;
    }
}
