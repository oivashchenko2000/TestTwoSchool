trigger BusAvailableTrigger on Bus_Line__c (before insert, before update, before delete) {

	if (Trigger.isInsert || Trigger.isUpdate) {
		BusAvailableTriggerHelper.checkDuplicate(Trigger.new);
	}
	BusAvailableTriggerHelper.setBusAvailable(Trigger.old, Trigger.new);
}