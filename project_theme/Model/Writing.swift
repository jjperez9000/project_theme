//
//  Writing.swift
//  project_theme
//
//  Created by John Perez on 7/31/22.
//

import Foundation

struct Page: Identifiable, Codable {
    var id: UUID = UUID()
    var date: Date
    var pageNum: Int
    var header: String
    var top1: String
    var top2: String
    var body: String
    var footer: String
}
extension Page {
    static var pagePlaceholder: Self {
        Page(
            date: Date.now,
            pageNum: 0,
            header: "header",
            top1: "test1",
            top2: "test2",
            body: "bodiii",
            footer: "feetsies"
        )
    }
}
