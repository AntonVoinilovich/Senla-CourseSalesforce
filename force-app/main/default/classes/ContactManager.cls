public with sharing class ContactManager {

    public class ContactWrapper {
        public String firstName {get; set;}
        public String lastName {get; set;}
        public String email {get; set;}
        public String phone {get; set;}
        public String description {get; set;}
    }

    public static Contact createContact(ContactWrapper contactWrapper, Boolean serialize) {
        Contact newContact = new Contact();
        newContact.FirstName = contactWrapper.firstName;
        newContact.LastName = contactWrapper.lastName;
        newContact.Email = contactWrapper.email;
        newContact.Phone = contactWrapper.phone;
        newContact.Description = contactWrapper.description;
        if (serialize) insert newContact;
        return newContact;
    }

    public static List<Contact> getContactsById(List<Id> ids, String fields) {
        return Database.query('SELECT ' + fields + ' FROM Contact WHERE Id IN :ids');
    } 

    public static Contact updateContact(String id, ContactWrapper contactWrapper, Boolean serialize) {
        Contact updateContact = [SELECT FirstName, LastName, Email, Phone, Description FROM Contact WHERE Id = :id];
        updateContact.FirstName = contactWrapper.firstName;
        updateContact.LastName = contactWrapper.lastName;
        updateContact.Email = contactWrapper.email;
        updateContact.Phone = contactWrapper.phone;
        updateContact.Description = contactWrapper.description;
        if (serialize) update updateContact;
        return updateContact;
    }

    public static void deleteContact(String lastName) {
        delete [SELECT Id FROM Contact WHERE LastName = :lastName];
    }
}
