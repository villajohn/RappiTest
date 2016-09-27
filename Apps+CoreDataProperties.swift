//
//  Apps+CoreDataProperties.swift
//  RappiTest
//
//  Created by Jhon Villalobos on 9/26/16.
//  Copyright © 2016 Jhon Villalobos. All rights reserved.
//

import Foundation
import CoreData


extension Apps {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Apps> {
        return NSFetchRequest<Apps>(entityName: "Apps");
    }

}
