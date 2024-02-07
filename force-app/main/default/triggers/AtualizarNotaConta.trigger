trigger AtualizarNotaConta on Avaliacao__c (after insert, after update) {
    AccountTriggerHandler.atualizarNotaConta(Trigger.new, Trigger.oldMap);
}