//
//  Theme.swift
//  project_theme
//
//  Created by John Perez on 7/30/22.
//

import Foundation

struct Theme: Codable {
    var theme: String
    var description: String
    var outcomes: [String]
}

class ThemeViewModel: ObservableObject {
    @Published var theme: Theme = .placeholder
    
    private var applicationSupportDirectory: URL {
        FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
    }
    private var filename = "database.json"
    private var databaseFileUrl: URL {
        applicationSupportDirectory.appendingPathComponent(filename)
    }
    
    func loadTheme(from storeFileData: Data) -> Theme {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(Theme.self, from: storeFileData)
        } catch {
            print(error)
            return .placeholder
        }
    }
    
    init() {
        if let data = FileManager.default.contents(atPath: databaseFileUrl.path) {
            theme = loadTheme(from: data)
        } else {
            if let bundledDatabaseUrl = Bundle.main.url(forResource: "database", withExtension: "json") {
                if let data = FileManager.default.contents(atPath: bundledDatabaseUrl.path) {
                    theme = loadTheme(from: data)
                }
            } else {
                theme = .placeholder
            }
        }
    }
    
    func save() {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = .prettyPrinted
        do {
            let data = try encoder.encode(theme)
            if FileManager.default.fileExists(atPath: databaseFileUrl.path) {
                try FileManager.default.removeItem(at: databaseFileUrl)
            }
            try data.write(to: databaseFileUrl)
        } catch {
            //..
        }
    }
}

extension Theme {
    static var placeholder: Self {
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
