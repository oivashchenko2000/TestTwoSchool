public with sharing class BusLineDAO {

	public static List<Bus_Line__c> findBusLineByAccount(Id recordId) {
		try {
			return [Select Bus__c, Line__r.Name From Bus_Line__c  Where Bus__r.Account__c = :recordId WITH SECURITY_ENFORCED];
		} catch (Exception ex) {
			throw new Exceptions.NoAccessException(ex.getMessage());
		}
	}

	public static List<Bus__c> findBusesBySetId(Set<Id> recordIds) {
		try {
			return [Select Name, Color__c, Mark__c, Model__c From Bus__c Where Id IN :recordIds WITH SECURITY_ENFORCED];
		} catch (Exception ex) {
			throw new Exceptions.NoAccessException(ex.getMessage());
		}
	}

	public static List<Bus_Line__c> findLinesByBus(Id busId) {
		try {
			return [Select Id, Line__r.Name, Line__r.Id, LastModifiedDate From Bus_Line__c Where Bus__r.Id = :busId WITH SECURITY_ENFORCED];
		} catch (Exception ex) {
			throw new Exceptions.NoAccessException(ex.getMessage());
		}
	}

	public static Boolean isBusLineExist(Id busLineId) {
		return [Select Count() From Bus_Line__c Where Id = :busLineId] != 0;
	}

	public static List<Line__c> findAllLines() {
		return [Select Id, Name From Line__c Where isActive__c = true];
	}

	public static List<Bus_Line__c> findBusLineByBusAndLine(Id busId, Id lineId) {
		try {
			return [Select Id, Line__r.Name, Line__r.Id, LastModifiedDate From Bus_Line__c Where Bus__c = :busId AND Line__c = :lineId WITH SECURITY_ENFORCED];
		} catch (Exception ex) {
			throw new Exceptions.NoAccessException(ex.getMessage());
		}
	}

	public static List<Bus_Line__c> findAllBusLinesByBusId(Set<Id> busIds) {
		return [Select Bus__c, Line__c From Bus_Line__c Where Bus__c IN :busIds];
	}

	public static List<AggregateResult> findBusCountByBusIds(Set<Id> busIds) {
		return [Select Bus__c busId, COUNT(Id) busCount From Bus_Line__c Where Bus__c IN :busIds Group By Bus__c];
	}
}