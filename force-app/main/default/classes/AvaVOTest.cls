@isTest
public class AvaVOTest {
    @isTest static void testAvaVO() {

        Avaliacao__c ava = new Avaliacao__c(
            Name = 'Teste',
            Descricao__c = 'Descrição de teste',
            nota__c = 5.0,
            Account__c = '001aj000000vSGRAA2' 
        );
        insert ava;

        AvaVO avaVO = new AvaVO(ava);

        // ve se os campos estao corretos
        System.assertEquals(ava.Name, avaVO.titulo);
        System.assertEquals(ava.Descricao__c, avaVO.descricao);
        System.assertEquals(ava.nota__c, avaVO.nota);
        System.assertEquals(ava.Account__c, avaVO.accountId);
        System.assertEquals(ava.CreatedBy.Name, avaVO.userName);
    }
}