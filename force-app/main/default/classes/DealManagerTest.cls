@isTest
private class DealManagerTest {
    
    @TestSetup
    static void makeData(){
        TestDataFactory.createDealTest();
    }

    @isTest
    static void testCreateDeal() {
        Deal__c dealList = [SELECT Property__c, Custommer__c FROM Deal__c];
        String propertyId = dealList.Property__c;
        String custommerId = dealList.Custommer__c;
        Deal__c createDealTest = DealManager.createDeal(
            propertyId,
            custommerId,
            'Open',
            false
        );
        Test.startTest();
            Database.SaveResult result = Database.insert(createDealTest);
        Test.stopTest();
        System.assert(result.isSuccess());
    }
    
    @isTest
    static void testGetDealById() {
        List<Id> ids = new List<Id>();
        for(Deal__c a: [SELECT Id FROM Deal__c]){
            ids.add(a.id);
        }
        System.assertEquals(1, DealManager.getDealById(ids, 'id').size(), 'Expected test to find a single Deal');
    }

    @isTest
    static void testUpdateDeal() {
        Deal__c dealList = [SELECT Id, Property__c, Custommer__c FROM Deal__c];
        String dealId = dealList.Id;
        String propertyId = dealList.Property__c;
        String custommerId = dealList.Custommer__c;
        Deal__c updateDealTest = DealManager.updateDeal(
            dealId,
            propertyId,
            custommerId,
            'Awaiting Approval',
            false
        );
        Test.startTest();
            Database.SaveResult result = Database.update(updateDealTest);
        Test.stopTest();
        System.assert(result.isSuccess());
    }

    @isTest
    static void testDeleteDeal() {
        String propertyId = [SELECT Property__c FROM Deal__c].Property__c;
        DealManager.deleteDeal(propertyId);
        System.assertEquals(0, [SELECT Property__c FROM Deal__c].size(), 'Deal deleted');
    }    
}
