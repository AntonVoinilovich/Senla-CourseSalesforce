public with sharing class DealManager {

    public static Deal__c createDeal(String propertyId, String custommerId, String status, Boolean serialize) {
        Deal__c newDeal = new Deal__c();
        newDeal.Property__c = propertyId;
        newDeal.Custommer__c = custommerId;
        newDeal.Status__c = status;
        if (serialize) insert newDeal;
        return newDeal;
    }

    public static List<Deal__c> getDealById(List<Id> ids, String fields) {
        return Database.query('SELECT ' + fields + ' FROM Deal__c WHERE Id IN :ids');
    }

    public static Deal__c updateDeal(String id, String propertyId, String custommerId, String status, Boolean serialize) {
        Deal__c updateDeal = [SELECT Property__c, Custommer__c, OwnerId, Status__c FROM Deal__c WHERE Id = :id];
        updateDeal.Property__c = propertyId;
        updateDeal.Custommer__c = custommerId;
        updateDeal.Status__c = status;
        if (serialize) update updateDeal;
        return updateDeal;
    }

    public static void deleteDeal(String propertyId) {
        delete [SELECT Id FROM Deal__c WHERE Property__c = :propertyId];
    }
}

