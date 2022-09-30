@isTest
private class LogManagerTest {
    
    @TestSetup
    static void makeData() {
        TestDataFactory.createLogTest();
    }

    @isTest
    static void testCreateLog() {
        Log__c createLogTest = LogManager.createLog(
            'ERROR',
            'Test error',
            false
        );
        Test.startTest();
            Database.SaveResult result = Database.insert(createLogTest);
        Test.stopTest();
        System.assert(result.isSuccess());
    }

    @isTest
    static void testGetLogsById() {
        List<Id> ids = new List<Id>();
        for(Log__c a: [SELECT Id FROM Log__c]){
            ids.add(a.id);
        }
        System.assertEquals(1, LogManager.getLogsById(ids, 'id').size(), 'Expected test to find a single Log');
    }

    @isTest
    static void testUpdateLog() {
        String logId = [SELECT Id FROM Log__c].Id;
        Log__c updateLogTest = LogManager.updateLog(
            logId,
            'WARNING',
            'Test warning',
            false
        );
        Test.startTest();
            Database.SaveResult result = Database.update(updateLogTest);
        Test.stopTest();
        System.assert(result.isSuccess());
    }

    @isTest
    static void testDeleteLog() {
        String logId = [SELECT Id FROM Log__c].Id;
        LogManager.deleteLog(logId);
        System.assertEquals(0, [SELECT Id FROM Log__c].size(), 'Log deleted');
    }
}
