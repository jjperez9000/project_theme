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
            description: "Contribute to the world, don't consume from the worldContribute to the world, don't consume from the worldContribute to the world, don't consume from the worldContribute to the world, don't consume from the worldContribute to the world, don't consume from the world",
            outcomes: [
                "Be less lazy",
                "Live more like Larry",
                "pogpogpogpog",
            ])
    }
}
