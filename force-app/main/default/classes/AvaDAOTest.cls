@isTest
private class AvaDAOTest {

    @testSetup
    static void setupTestData() {
        // criando conta de teste
        Account contaTeste = new Account(Name = 'Conta de Teste');
        insert contaTeste;

       
        Avaliacao__c avaliacaoTeste = new Avaliacao__c(
            Name = 'Avaliacao de Teste',
            Descricao__c = 'Descrição Teste',
            nota__c = 4.0,
            Account__c = contaTeste.Id
        );
        insert avaliacaoTeste;
    }

    @isTest
    static void testAvaDAO() {
        // pega a conta de testSetup
        Account contaTeste = [SELECT Id FROM Account WHERE Name = 'Conta de Teste' LIMIT 1];

        // executa o método da AvaDAO para obter avaliações associadas à conta de teste
        List<Avaliacao__c> avaliacoesObtidas = AvaDAO.AvaDAO(contaTeste.Id);

        // ve se avaliacao esta na lista
        System.assertEquals(1, avaliacoesObtidas.size());
        System.assertEquals('Avaliacao de Teste', avaliacoesObtidas[0].Name);
    }
}
