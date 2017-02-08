//
//  EntryDB+CoreDataProperties.swift
//  
//
//  Created by Diego Leon on 2/8/17.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension EntryDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EntryDB> {
        return NSFetchRequest<EntryDB>(entityName: "EntryDB");
    }

    @NSManaged public var category: String?
    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var summary: String?

}
