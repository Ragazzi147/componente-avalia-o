public with sharing class AvaController {
    public class AvaliacaoWrapper {
        @AuraEnabled public String titulo;
        @AuraEnabled public String descricao;
        @AuraEnabled public Decimal nota;
    }

    @AuraEnabled
    public static String inserirAvaliacao(AvaliacaoWrapper avaliacao) {
        try {

            Avaliacao__c novoRegistro = new Avaliacao__c(
                Titulo__c = avaliacao.titulo,
                Descricao__c = avaliacao.descricao,
                Nota__c = avaliacao.nota
            );

            List<Avaliacao__c> listaParaInserir = new List<Avaliacao__c>{novoRegistro};


            insert listaParaInserir;

            return 'Sucesso';
        } catch (Exception e) {
            return 'Erro: ' + e.getMessage();
        }
    }
}
