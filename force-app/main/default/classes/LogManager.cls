public with sharing class LogManager {
    
    public static Log__c createLog(String type, String message, Boolean serialize) {
        Log__c newLog = new Log__c();
        newLog.Type__c = type;
        newLog.Message__c = message;
        if (serialize) insert newLog;
        return newLog;
    }

    public static List<Log__c> getLogsById(List<id> ids, String fields) {
        return Database.query('SELECT ' + fields + ' FROM Log__c WHERE Id IN :ids');
    }

    public static Log__c updateLog(String id, String type, String message, Boolean serialize) {
        Log__c updateLog = [SELECT Type__c, Message__c FROM Log__c WHERE Id = :id];
        updateLog.Type__c = type;
        updateLog.Message__c = message;
        if (serialize) update updateLog;
        return updateLog;
    }

    public static void deleteLog(String id) {
        delete [SELECT Id FROM Log__c WHERE Id = :id];
    }
}