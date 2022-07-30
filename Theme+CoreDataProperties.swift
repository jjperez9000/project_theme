//
//  Theme+CoreDataProperties.swift
//  project_theme
//
//  Created by John Perez on 7/30/22.
//
//

import Foundation
import CoreData


extension Theme {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Theme> {
        return NSFetchRequest<Theme>(entityName: "Theme")
    }

    @NSManaged public var theme: String?
    @NSManaged public var themeDescription: String?
    @NSManaged public var outcomes: [String]?

}

extension Theme : Identifiable {

}
