//
//  GoalPageView.swift
//  project_theme
//
//  Created by John Perez on 8/12/22.
//

import SwiftUI

struct GoalPageView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var page: GoalPage
    
    var body: some View {
        List {
            if let mygoals = page.goals {
                ForEach(Array(mygoals as Set), id: \.self) { goal in
                    if let mygoal = goal as? Goal {
                        GoalView(goal: mygoal)
                    }
                }
            }
        }.toolbar {
            ToolbarItem {
                Button(action: addGoal) {
                    Label("Add Goal", systemImage: "trophy")
                }
            }
            ToolbarItem {
                Button(action: addGoalPage) {
                    Label("Add Page", systemImage: "square.and.pencil")
                }
            }
        }
    }
    private func addGoalPage() {
        let newPage = GoalPage(context: viewContext)
        newPage.id = UUID()
        newPage.date = Date()
        newPage.name = "my page"
        
        let goal = Goal(context: viewContext)
        goal.title = String(Int.random(in: 0..<100))
        goal.id = UUID()
        newPage.addToGoals(goal)
         
        for i in 1...7 {
            let result = Result(context: viewContext)
            result.number = Int16(i)
            result.success = 0
            goal.addToResults(result)
        }
        
        do  {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    private func addGoal() {
        let goal = Goal(context: viewContext)
        goal.title = String(Int.random(in: 0..<100))
        goal.id = UUID()
        page.addToGoals(goal)
         
        for i in 1...7 {
            let result = Result(context: viewContext)
            result.number = Int16(i)
            result.success = 0
            goal.addToResults(result)
        }
        
        do  {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
