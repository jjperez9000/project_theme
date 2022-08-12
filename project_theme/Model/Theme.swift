//
//  Theme.swift
//  project_theme
//
//  Created by John Perez on 7/31/22.
//

import Foundation

struct Theme: Codable {
    var theme: String
    var description: String
    var outcomes: [String]
}

extension Theme {
    static var themePlaceholder: Self {
        Theme(
            theme: "creation",
            description: "asdf",
            outcomes: [
                "Be less lazy",
                "Live more like Larry",
                "pogpogpogpog",
            ])
    }
}

// this is here so that we can print the outcomes section
extension String: Identifiable {
    public typealias ID = Int
    public var id: Int {
        return hash
    }
}
