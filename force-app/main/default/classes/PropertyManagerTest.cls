@isTest
private class PropertyManagerTest {
    
    @TestSetup
    static void makeData() {
        TestDataFactory.createPropertyTest();
    }

    @isTest
    static void testCreateProperty() {
        String propertyOwnerId = [SELECT Property_Owner__c FROM Property__c].Property_Owner__c;
        Property__c createPropertyTest = PropertyManager.createProperty(
            propertyOwnerId,
            'Test district Test city Test street',
            450000.50,
            2400.00,
            false
        );
        Test.startTest();
            Database.SaveResult result = Database.insert(createPropertyTest);
        Test.stopTest();
        System.assert(result.isSuccess());
    }

    @isTest
    static void testGetPropertiesById() {
        List<Id> ids = new List<Id>();
        for(Property__c a: [SELECT Id FROM Property__c]){
            ids.add(a.id);
        }
        System.assertEquals(1, PropertyManager.getPropertiesById(ids, 'id').size(), 'Expected test to find a single Property');
    }

    @isTest
    static void testUpdatePropety() {
        String propertyId = [SELECT Id FROM Property__c].Id;
        Property__c updatePropertyTest = PropertyManager.updateProperty(
            propertyId,
            'TestUpdate district TestUpdate city TestUpdate street',
            680000.50,
            3100.00,
            false
        );
        Test.startTest();
            Database.SaveResult result = Database.update(updatePropertyTest);
        Test.stopTest();
        System.assert(result.isSuccess());
    }

    @isTest
    static void testDeleteProperty() {
        String name = [SELECT Name FROM Property__c].Name;
        PropertyManager.deleteProperty(name);
        System.assertEquals(0, [SELECT Name FROM Property__c].size(), 'Property deleted');
    }
}