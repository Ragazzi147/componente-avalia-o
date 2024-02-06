trigger AtualizarNotaConta on Avaliacao__c (after insert, after update, after delete) {
    AccountTriggerHandler.atualizarNotaConta(Trigger.new, Trigger.oldMap);
}