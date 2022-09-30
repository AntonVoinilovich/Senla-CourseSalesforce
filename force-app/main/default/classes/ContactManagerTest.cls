@isTest
private class ContactManagerTest {
    
    @TestSetup
    static void makeData() {
        TestDataFactory.createContactTest('ForContact');
    }

    @isTest 
    static void testCreateContact() {
        ContactManager.ContactWrapper contactWrapperTest = new ContactManager.ContactWrapper();
            contactWrapperTest.firstName = 'FirstNameTest';
            contactWrapperTest.lastName = 'LastNameTest';
            contactWrapperTest.email = 'emailtest@test.com';
            contactWrapperTest.phone = '12345678';
            contactWrapperTest.description = 'Test Contact';
        Contact createContactTest = ContactManager.createContact(contactWrapperTest, false);
        Test.startTest();
            Database.SaveResult result = Database.insert(createContactTest);
        Test.stopTest();
        System.assert(result.isSuccess());
    }

    @isTest
    static void testGetContactsById() {
        List<Id> ids = new List<Id>();
        for(Contact a: [SELECT Id FROM Contact]){
            ids.add(a.id);
        }
        System.assertEquals(1, ContactManager.getContactsById(ids, 'id').size(), 'Expected test to find a single Contact');
    }

    @isTest
    static void testUpdateContact() {
        Contact contactListTest = [SELECT Id FROM Contact];
        String contactId = contactListTest.id;
        ContactManager.ContactWrapper contactWrapperUpdateTest = new ContactManager.ContactWrapper();
        contactWrapperUpdateTest.firstName = 'FirstNameTestUpdate';
        contactWrapperUpdateTest.lastName = 'LastNameTestUpdate';
        contactWrapperUpdateTest.email = 'emailtestUpdate@test.com';
        contactWrapperUpdateTest.phone = '87654321';
        contactWrapperUpdateTest.description = 'Test ContactUpdate';
        Contact updateContactTest = ContactManager.updateContact(contactId, contactWrapperUpdateTest, false);
        Test.startTest();
            Database.SaveResult result = Database.update(updateContactTest);
        Test.stopTest();
        System.assert(result.isSuccess());
    }

    @isTest
    static void testDeleteContact() {
        Contact contactListTest = [SELECT LastName FROM Contact];
        String lastName = contactListTest.LastName;
        ContactManager.deleteContact(lastName);
        System.assertEquals(0, [SELECT LastName FROM Contact].size(), 'Contact deleted');
    }
}
