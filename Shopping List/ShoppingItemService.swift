//
//  ShoppingItemService.swift
//  MyFirstTableViewProject
//
//  Created by Ben Smith on 09/02/17.
//  Copyright © 2017 Ben Smith. All rights reserved.
//

import Foundation

class ShoppingItemService {
    
    
    //{
    //    "ShoppingItems": [
    //        {
    //        "name": "Coffee",
    //        "price": 5.50
    //        },
    //        {
    //        "name": "Milk",
    //        "price": 1
    //        },
    //        {
    //        "name": "Sugar",
    //        "price": 1.2
    //        },
    //        {
    //        "name": "Lemons",
    //        "price": 0.5
    //        },
    //        {
    //        "name": "Turnips",
    //        "price": 0.5
    //        },
    //        {
    //        "name": "Carrots",
    //        "price": 2
    //        },
    //        {
    //        "name": "Shampoo",
    //        "price": 5
    //        },
    //        {
    //        "name": "Chicken",
    //        "price": 1.5
    //        },
    //        {
    //        "name": "Meditation Mat",
    //        "price": 10
    //        },
    //        {
    //        "name": "Cream",
    //        "price": 2
    //        },
    //        {
    //        "name": "Frogs Legs",
    //        "price": 14.5
    //        },
    //        {
    //        "name": "Bitter Ballen",
    //        "price": 3.5
    //        },
    //        {
    //        "name": "Beard Trimmer",
    //        "price": 14
    //        }
    //    ]
    //}
    
    class func getData() -> NSDictionary {
        //Here is the escaped string...just imagine this is our data retrieved from a server! Like for real!!!
        let itemsJSONString = "{\r\n    \"ShoppingItems\": [\r\n        {\r\n        \"name\": \"Coffee\",\r\n        \"price\": \"5.50\"\r\n        },\r\n        {\r\n        \"name\": \"Milk\",\r\n        \"price\": \"1\"\r\n        },\r\n        {\r\n        \"name\": \"Sugar\",\r\n        \"price\": \"1.2\"\r\n        },\r\n        {\r\n        \"name\": \"Lemons\",\r\n        \"price\": \"0.5\"\r\n        },\r\n        {\r\n        \"name\": \"Turnips\",\r\n        \"price\": \"0.5\"\r\n        },\r\n        {\r\n        \"name\": \"Carrots\",\r\n        \"price\": \"2\"\r\n        },\r\n        {\r\n        \"name\": \"Shampoo\",\r\n        \"price\": \"5\"\r\n        },\r\n        {\r\n        \"name\": \"Chicken\",\r\n        \"price\": \"1.5\"\r\n        },\r\n        {\r\n        \"name\": \"Meditation Mat\",\r\n        \"price\": \"10\"\r\n        },\r\n        {\r\n        \"name\": \"Cream\",\r\n        \"price\": \"2\"\r\n        },\r\n        {\r\n        \"name\": \"Frogs Legs\",\r\n        \"price\": \"14.5\"\r\n        },\r\n        {\r\n        \"name\": \"Bitter Ballen\",\r\n        \"price\": \"3.5\"\r\n        },\r\n        {\r\n        \"name\": \"Beard Trimmer\",\r\n        \"price\": \"14\"\r\n        }\r\n    ]\r\n}\r\n"
        
        return itemsJSONString.parseJSONString as! NSDictionary
    }
    
    class func getTheDataFromShoppingService() -> [ShoppingItem] {
        var shoppingItemArray: [ShoppingItem] = []
        let JSONDictionary = ShoppingItemService.getData() as NSDictionary
        let arrayOfDictionaries = JSONDictionary["ShoppingItems"] as! NSArray //Array<String>
        
        for shoppingItemDictionary in arrayOfDictionaries {
            let aShoppingItemDictionary = shoppingItemDictionary as! NSDictionary
            let aShoppingItemDictionaryName = aShoppingItemDictionary["name"] as! String
            let aShoppingItemDictionaryPrice = aShoppingItemDictionary["price"] as! String
            let shopItem = ShoppingItem.init(name: aShoppingItemDictionaryName, price: aShoppingItemDictionaryPrice)
            shoppingItemArray.append(shopItem)
            
        }
        
        return shoppingItemArray
    }
    
}

//The clever parsed, it deserialises the JSON, don't worry about it too much lot of complicated things here
extension String {
    
    var parseJSONString: AnyObject? {
        
        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
        
        if let jsonData = data {
            do {
                let message = try JSONSerialization.jsonObject(with: jsonData, options:.mutableContainers)
                return message as AnyObject?
            }
            catch let error as NSError
            {
                print("An error occurred: \(error)")
                return nil
            }
            
            // Will return an object or nil if JSON decoding fails
        } else {
            // Lossless conversion of the string was not possible
            return nil
        }
    }
    
}

