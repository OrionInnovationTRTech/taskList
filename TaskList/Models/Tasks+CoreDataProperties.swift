//
//  Tasks+CoreDataProperties.swift
//  TaskList
//
//  Created by Seyit Murat Kaya on 22.07.2022.
//
//

import Foundation
import CoreData


extension Tasks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tasks> {
        return NSFetchRequest<Tasks>(entityName: "Tasks")
    }

    @NSManaged public var backgroundColor: String?
    @NSManaged public var creationDate: Date?
    @NSManaged public var detail: String?
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?

}

extension Tasks : Identifiable {

}
