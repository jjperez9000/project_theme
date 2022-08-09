//
//  Goal.swift
//  project_theme
//
//  Created by John Perez on 8/8/22.
//

import Foundation

struct Goal: Identifiable, Codable {
    var id: UUID = UUID()
    var title: String
    var results: Array<Int> = Array(repeating: 0, count: 15)
}

struct GoalPage: Identifiable, Codable {
    var id: UUID = UUID()
    var goals: [Goal] = []
}
