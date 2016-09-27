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
    var id:          NSDictionary?
    var name:        String?
    var title:       String?
    var icon:        [NSDictionary]?
    var summary:     String?
    var price:       NSDictionary?
    var contentType: NSDictionary?
    var rights:      String?
    var link:        NSDictionary?
    var owner:       NSDictionary?
    var category:    NSDictionary?
    var realeaseDate: String?
    
    init (id: NSDictionary, name: String, title: String, icon: [NSDictionary], summary: String, price: NSDictionary, contentType: NSDictionary, rights: String, link: NSDictionary, owner: NSDictionary, category: NSDictionary, releaseDate: String) {
        
        self.id             = id
        self.name           = name
        self.title          = title
        self.icon           = icon
        self.summary        = summary
        self.price          = price
        self.contentType    = contentType
        self.rights         = rights
        self.link           = link
        self.owner          = owner
        self.category       = category
        self.realeaseDate   = releaseDate
    }
    
    init(appDictionary: [String: AnyObject]) {
        self.id             = appDictionary["id"]?["attributes"] as? NSDictionary
        self.name           = appDictionary["im:name"]?["label"] as? String
        self.icon           = appDictionary["im:image"] as? [NSDictionary]
        self.summary        = appDictionary["summary"]?["label"] as? String
        self.price          = appDictionary["im:price"]?["attributes"] as? NSDictionary
        self.contentType    = appDictionary["im:contentType"]?["attributes"] as? NSDictionary
        self.rights         = appDictionary["rights"]?["label"] as? String
        self.title          = appDictionary["title"]?["label"] as? String
        self.link           = appDictionary["link"]?["attributes"] as? NSDictionary
        self.owner          = appDictionary["im:artist"] as? NSDictionary
        self.category       = appDictionary["category"]?["attributes"] as? NSDictionary
        self.realeaseDate   = getDate(date: (appDictionary["im:releaseDate"]?["label"] as? String)!)
    }
    
    static func downloadApplications(isJsonFile: Bool = false, file: NSData = NSData()) -> [Application] {
        var apps = [Application]()
        
        var jsonData = file
        
        if !(isJsonFile) {
            
            keyChain[data: "secret"] = jsonData as Data
            
            do {
                try jsonData = NSData(contentsOf: NSURL(string: "https://itunes.apple.com/us/rss/topfreeapplications/limit=20/json")! as URL)
                
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
        
        //dateFormatter.dateStyle = .medium
        let dateString = dateFormatter.string(from: sendDate!)
        return dateString
    }
    
}
