public with sharing class AvaVO { // TODO: faltou classe de teste
    
    public AvaVO(Avaliacao__c ava) {
        this.titulo = ava.Name;
        this.descricao = ava.Descricao__c;
        this.nota = ava.nota__c;
        this.accountId = ava.Account__c;
        this.userName = ava.CreatedBy.Name;
    }

    @AuraEnabled public String titulo {get; set;}
    @AuraEnabled public String descricao {get; set;}
    @AuraEnabled public Decimal nota {get; set;}
    @AuraEnabled public Id accountId {get; set;}
    @AuraEnabled public String userName {get; set;}
}