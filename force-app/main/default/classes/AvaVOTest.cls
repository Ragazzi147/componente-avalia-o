@isTest
public class AvaVOTest {

    @testSetup
    static void setupTestData() {
       
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        // criacao de uma avaliação de Teste conta de teste
        Avaliacao__c avaliacaoTeste = new Avaliacao__c(
            Name = 'Test Avaliacao',
            Descricao__c = 'Descrição de Teste',
            nota__c = 4.5,
            Account__c = testAccount.Id,
            OwnerId = UserInfo.getUserId() 
        );
        insert avaliacaoTeste;
    }

    @isTest 
    static void testAvaVO() {
        //  Avaliação criada no método de setup
        Avaliacao__c ava = [SELECT Id, Name, Descricao__c, nota__c, Account__c, CreatedBy.Name FROM Avaliacao__c LIMIT 1];

        // Executa  classe AvaVO
        AvaVO avaVO = new AvaVO(ava);

        // ve se os campos estão corretos
        System.assertEquals(ava.Name, avaVO.titulo);
        System.assertEquals(ava.Descricao__c, avaVO.descricao);
        System.assertEquals(ava.nota__c, avaVO.nota);
        System.assertEquals(ava.Account__c, avaVO.accountId);
        System.assertEquals(ava.CreatedBy.Name, avaVO.userName);
    }
}
