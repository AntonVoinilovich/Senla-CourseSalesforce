@isTest
public class TestDataFactory {

    public static Contact createContactTest(String addText) {
        Contact contactTest = new Contact (
            FirstName = 'FirstNameTest' + addText,
            LastName = 'LastNameTest' + addText,
            Email = 'emailtest' + addText + '@test.com',
            Phone = '12345678',
            Description = 'Test Contact' + addText
        );
        insert contactTest;
        return contactTest;
    }

    public static Property__c createPropertyTest() {
        Contact contactTest = createContactTest('ForProperty');
        Property__c propertyTest = new Property__c (
            Property_Owner__c = contactTest.Id,
            Address__c = 'City Test Street Test',
            Rental_price__c = 2600.50,
            Selling_price__c = 340000.40
        );
        System.debug(contactTest);
        System.debug(propertyTest);
        insert propertyTest;
        return propertyTest;
    }

    public static Deal__c createDealTest() {
        Property__c propertyTest = createPropertyTest();
        Contact contactTest = createContactTest('ForDeal');
        Deal__c dealTest = new Deal__c (
            Property__c = propertyTest.Id,
            Custommer__c = contactTest.Id,
            Status__c = 'Open'
        );
        System.debug(dealTest);
        insert dealTest;
        return dealTest;
    }

    public static Log__c createLogTest() {
        Log__c logTest = new Log__c (
            Type__c = 'ERROR',
            Message__c = 'TestError'
        );
        System.debug(logTest);
        insert logTest;
        return logTest;
    }
}
