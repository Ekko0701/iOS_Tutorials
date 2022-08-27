//
//  Item+CoreDataProperties.swift
//  CoreData_tutorial
//
//  Created by Ekko on 2022/08/26.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var check: Bool
    @NSManaged public var title: String?

}

extension Item : Identifiable {

}
