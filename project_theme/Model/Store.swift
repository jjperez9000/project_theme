//
//  Theme.swift
//  project_theme
//
//  Created by John Perez on 7/30/22.
//

import Foundation

class Store: ObservableObject {
    @Published var theme: Theme = .themePlaceholder
    @Published var pages: [GenericPage] = []
    @Published var goals: [GoalPage] = []
    
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
            return .themePlaceholder
        }
    }
    func loadPages(from storeFileData: Data) -> [GenericPage] {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode([GenericPage].self, from: storeFileData)
        } catch {
            print(error)
            return []
        }
    }
    
    init() {
        if let data = FileManager.default.contents(atPath: databaseFileUrl.path) {
            theme = loadTheme(from: data)
            pages = loadPages(from: data)
        } else {
            if let bundledDatabaseUrl = Bundle.main.url(forResource: "database", withExtension: "json") {
                if let data = FileManager.default.contents(atPath: bundledDatabaseUrl.path) {
                    theme = loadTheme(from: data)
                    pages = loadPages(from: data)
                }
            } else {
                theme = .themePlaceholder
                pages = []
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
        do {
            let data = try encoder.encode(pages)
            if FileManager.default.fileExists(atPath: databaseFileUrl.path) {
                try FileManager.default.removeItem(at: databaseFileUrl)
            }
            try data.write(to: databaseFileUrl)
        } catch {
            //..
        }
    }
}


extension String: Identifiable {
    public typealias ID = Int
    public var id: Int {
        return hash
    }
}
