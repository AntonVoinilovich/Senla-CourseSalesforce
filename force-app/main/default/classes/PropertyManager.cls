public with sharing class PropertyManager {
    // public class PropertyWrapper {
    //     public String name {get; set;}
    //     public String name {get; set;}
    //     public String name {get; set;}
    //     public String name {get; set;}
    //     public String name {get; set;}

    // }

    public static Property__c createProperty(String propertyOwnerId, String address, Decimal rentalPrice, Decimal sellingPrice, Boolean serialize) {
        Property__c newProperty = new Property__c();
        newProperty.Property_Owner__c = propertyOwnerId;
        newProperty.Address__c = address;
        newProperty.Rental_price__c = rentalPrice;
        newProperty.Selling_price__c = sellingPrice;
        if (serialize) insert newProperty;
        return newProperty;
    }

    public static List<Property__c> getPropertiesById(List<Id> ids, String fields) {
        return Database.query('SELECT ' + fields + ' FROM Property__c WHERE Id IN :ids');
    }

    public static Property__c updateProperty(String id, String address, Decimal rentalPrice, Decimal sellingPrice, Boolean serialize) {
        Property__c updateProperty = [SELECT Address__c, Rental_price__c, Selling_price__c FROM Property__c WHERE Id = :id ];
        updateProperty.Address__c = address;
        updateProperty.Rental_price__c = rentalPrice;
        updateProperty.Selling_price__c = sellingPrice;
        if (serialize) update updateProperty;
        return updateProperty;
    }
    
    public static void deleteProperty(String name) {
        delete [SELECT Id FROM Property__c WHERE Name = :name];
    }
}    