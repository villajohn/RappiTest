//
//  Apps+CoreDataClass.swift
//  RappiTest
//
//  Created by Jhon Villalobos on 9/26/16.
//  Copyright © 2016 Jhon Villalobos. All rights reserved.
//

import Foundation
import CoreData


public class Apps: NSManagedObject {

    @NSManaged public var realeaseDate: String?
    @NSManaged public var category: String?
    @NSManaged public var owner: String?
    @NSManaged public var link: String?
    @NSManaged public var rights: String?
    @NSManaged public var contentType: String?
    @NSManaged public var price: String?
    @NSManaged public var summary: String?
    @NSManaged public var icon: String?
    @NSManaged public var title: String?
    @NSManaged public var name: String?
    @NSManaged public var id: String?
    
}
