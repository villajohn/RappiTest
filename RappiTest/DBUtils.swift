//
//  DBUtils.swift
//  RappiTest
//
//  Created by Jhon Villalobos on 3/5/17.
//  Copyright © 2017 Jhon Villalobos. All rights reserved.
//

import Foundation
import CoreData
import UIKit

func saveModel(appdata: [Application]) {
    
    let managedContext = getGlobalManagedContext()
    
    let entity = NSEntityDescription.entity(forEntityName: "Apps", in: managedContext)

    for app in appdata {
        let appItem = NSManagedObject(entity: entity!, insertInto: managedContext)
        appItem.setValue(app.category!, forKey: "category")
        appItem.setValue(app.contentType!, forKey: "contentType")
        appItem.setValue(app.icon!, forKey: "icon")
        appItem.setValue(app.id!, forKey: "id")
        appItem.setValue(app.link!, forKey: "link")
        appItem.setValue(app.name!, forKey: "name")
        appItem.setValue(app.owner!, forKey: "owner")
        appItem.setValue(app.price!, forKey: "price")
        appItem.setValue(app.currency!, forKey: "currency")
        appItem.setValue(app.realeaseDate!, forKey: "releaseDate")
        appItem.setValue(app.rights!, forKey: "rights")
        appItem.setValue(app.summary!, forKey: "summary")
        appItem.setValue(app.title!, forKey: "title")
        
        //4 Save main product
        do {
            try managedContext.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
//    let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Apps")
    
    //DELETE TABLE
    
//     let results = try! managedContext.fetch(fetchRequest)
//     let orderItem : [NSManagedObject] = results as! [NSManagedObject]
//     print(orderItem.count)
//     for ord in results {
//        print((ord as AnyObject).value(forKey: "title") as! String)
//        print((ord as AnyObject).value(forKey: "summary") as! String)
//        print((ord as AnyObject).value(forKey: "price") as! String)
    
//     managedContext.delete(ord as! NSManagedObject)
//     }
//     
//     let results2 = try managedContext.fetch(fetchRequest2)
//     let orderItem2 : [NSManagedObject] = results as! [NSManagedObject]
//     print(orderItem2.count)
//     for ord in results2 {
//     print((ord as AnyObject).value(forKey: "oro_id"))
//     print((ord as AnyObject).value(forKey: "oro_name"))
//     print((ord as AnyObject).value(forKey: "oro_price"))
//     print((ord as AnyObject).value(forKey: "oro_optype"))
//     
//     managedContext.delete(ord as! NSManagedObject)
//     }
//     
//     try managedContext.save()
     
 
//    }
}

func deleteAppsStored() {
    let managedContext = getGlobalManagedContext()
    let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Apps")
    
    //DELETE TABLE
    let results = try! managedContext.fetch(fetchRequest)
    let orderItem : [NSManagedObject] = results as! [NSManagedObject]
    print(orderItem.count)
    for ord in results {
        print((ord as AnyObject).value(forKey: "title") as! String)
        print((ord as AnyObject).value(forKey: "summary") as! String)
        print((ord as AnyObject).value(forKey: "price") as! String)
        
        managedContext.delete(ord as! NSManagedObject)
        try! managedContext.save()
    }
}

func getGlobalManagedContext() -> NSManagedObjectContext {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var localManagedContext : NSManagedObjectContext
    
    if #available(iOS 10.0, *) {
        localManagedContext = appDelegate.persistentContainer.viewContext
    } else {
        // iOS 9.0 and below - however you were previously handling it
        guard let modelURL = Bundle.main.url(forResource: "LittlePiazza", withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        localManagedContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docURL = urls[urls.endIndex-1]
        let storeURL = docURL.appendingPathComponent("LittlePiazza.sqlite")
        do {
            try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
        } catch {
            fatalError("Error migrating store: \(error)")
        }
    }
    
    return localManagedContext
}

func getAppsStored() -> [Application] {
    
    let context = getGlobalManagedContext()
    var appsStored = [Application]()
    
    let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Apps")
    
    do {
        let results = try context.fetch(fetchRequest)
        let appItem : [NSManagedObject] = results as! [NSManagedObject]
        
        for prd in appItem {
            let objectCategory  = (prd as AnyObject).value(forKey: "category") as! String
            let objCntType      = (prd as AnyObject).value(forKey: "contentType") as! String
            let objIcon         = (prd as AnyObject).value(forKey: "icon") as! String
            let objId           = (prd as AnyObject).value(forKey: "id") as! String
            let objCurrency     = (prd as AnyObject).value(forKey: "currency") as! String
            let objLink         = (prd as AnyObject).value(forKey: "link") as! String
            let objName         = (prd as AnyObject).value(forKey: "name") as! String
            let objOwner        = (prd as AnyObject).value(forKey: "owner") as! String
            let objPrice        = (prd as AnyObject).value(forKey: "price") as! String
            let objRelease      = (prd as AnyObject).value(forKey: "releaseDate") as! String
            let objRights       = (prd as AnyObject).value(forKey: "rights") as! String
            let objSummary      = (prd as AnyObject).value(forKey: "summary") as! String
            let objTitle        = (prd as AnyObject).value(forKey: "title") as! String
            
            
            let newApp = Application(id: objId, name: objName, title: objTitle, icon: objIcon, summary: objSummary, price: objPrice, contentType: objCntType, rights: objRights, link: objLink, owner: objOwner, category: objectCategory, releaseDate: objRelease, currency: objCurrency)
            
            appsStored.append(newApp)
        }
        
    } catch {}
    
    return appsStored
}


