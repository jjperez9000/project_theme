//
//  CoreTheme+CoreDataProperties.swift
//  project_theme
//
//  Created by John Perez on 7/30/22.
//
//

import Foundation
import CoreData


extension CoreTheme {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreTheme> {
        return NSFetchRequest<CoreTheme>(entityName: "CoreTheme")
    }

    @NSManaged public var theme: String?
    @NSManaged public var themeDescription: String?
    @NSManaged public var outcomes: [String]?

}

extension CoreTheme : Identifiable {

}
