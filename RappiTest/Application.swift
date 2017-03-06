//
//  Application.swift
//  RappiTest
//
//  Created by Jhon Villalobos on 9/25/16.
//  Copyright © 2016 Jhon Villalobos. All rights reserved.
//

import Foundation
import UIKit
import KeychainAccess

var keyChain: Keychain = Keychain()
let shared = Keychain(service: "com.jlvillalobos.RappiTest", accessGroup: "12ABCD3E4F.shared")

class Application {
    var id:          String?
    var name:        String?
    var title:       String?
    var icon:        String?
    var summary:     String?
    var price:       String?
    var currency:    String?
    var contentType: String?
    var rights:      String?
    var link:        String?
    var owner:       String?
    var category:    String?
    var realeaseDate: String?
    
    init (id: String, name: String, title: String, icon: String, summary: String, price: String, contentType: String, rights: String, link: String, owner: String, category: String, releaseDate: String, currency: String) {
        
        self.id             = id
        self.name           = name
        self.title          = title
        self.icon           = icon
        self.summary        = summary
        self.price          = price
        self.currency       = currency
        self.contentType    = contentType
        self.rights         = rights
        self.link           = link
        self.owner          = owner
        self.category       = category
        self.realeaseDate   = releaseDate
    }
    
    init(appDictionary: [String: AnyObject]) {
        let idatt = appDictionary["id"]?["attributes"] as? NSDictionary
        self.id             = idatt?["im:id"] as? String
        self.name           = appDictionary["im:name"]?["label"] as? String
        let iconAtt         = appDictionary["im:image"] as? [NSDictionary]
        self.icon           = iconAtt?[2]["label"] as? String
        self.summary        = appDictionary["summary"]?["label"] as? String
        let priceAtt        = appDictionary["im:price"]?["attributes"] as? NSDictionary
        self.price          = priceAtt?["amount"] as? String
        self.currency       = priceAtt?["currency"] as? String
        let typeAtt         = appDictionary["im:contentType"]?["attributes"] as? NSDictionary
        self.contentType    = typeAtt?["term"] as? String
        self.rights         = appDictionary["rights"]?["label"] as? String
        self.title          = appDictionary["title"]?["label"] as? String
        let linkAtt         = appDictionary["link"]?["attributes"] as? NSDictionary
        self.link           = linkAtt?["href"] as? String
        let ownerAtt        = appDictionary["im:artist"] as? NSDictionary
        self.owner          = ownerAtt?["label"] as? String
        let catAtt          = appDictionary["category"]?["attributes"] as? NSDictionary
        self.category       = catAtt?["label"] as? String
        self.realeaseDate   = getDate(date: (appDictionary["im:releaseDate"]?["label"] as? String)!)
    }
    
    static func downloadApplications(isJsonFile: Bool = false, file: NSData = NSData()) -> [Application] {
        var apps = [Application]()
        
        var jsonData = file
        
        if !(isJsonFile) {
            
            keyChain[data: "secret"] = jsonData as Data
            
            do {
                try jsonData = NSData(contentsOf: NSURL(string: serverURL)! as URL)
                
            } catch let error {
              print("\(error.localizedDescription)")
            }
        }
        
        // turn the data into foundation objects (Post)
        if let jsonDictionary = NetworkServices.parseJSONFromData(jsonData: jsonData) {
            let appDictionaries = jsonDictionary["feed"]?["entry"] as! [[String : AnyObject]]
         
            
            for appDictionary in appDictionaries {
                let newApp = Application(appDictionary: appDictionary)
                apps.append(newApp)
            }
        }
        deleteAppsStored()
        saveModel(appdata: apps)
        return apps
    }
    

    func getDate(date: String) -> String {
        let localeStr = "us"
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: localeStr) as Locale!
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateComponents = NSDateComponents()
    
        var sendDate = dateComponents.date
        if let newDate = dateFormatter.date( from: date ) {
            sendDate = newDate
        }
        
        dateFormatter.dateStyle = .medium
        let dateString = dateFormatter.string(from: sendDate!)
        return dateString
    }
    
}
