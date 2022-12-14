//
//  ThemeView.swift
//  project_theme
//
//  Created by John Perez on 7/29/22.
//

import SwiftUI
import CoreData

struct ThemeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var locked: Bool = true
    @Binding var sidebarDestination: Destination
    
    @ObservedObject var theme: CdTheme
    
    
    var body: some View {
        if (locked) {
            StaticThemeView(theme: theme)
                .toolbar {
                    ToolbarItem {
                        Button(action: toggleLock) {
                            Label("lock", systemImage: "lock")
                        }
                    }
                    ToolbarItem {
                        Button(action: addPage) {
                            Label("Add Item", systemImage: "square.and.pencil")
                        }
                    }
                }
            
        } else {
            EditThemeView(theme: theme)
                .toolbar {
                    ToolbarItem {
                        Button(action: toggleLock) {
                            Label("lock", systemImage: "lock.open")
                        }
                    }
                    ToolbarItem {
                        Button(action: addPage) {
                            Label("Add Item", systemImage: "square.and.pencil")
                        }
                    }
                }
            
        }
    }
    private func toggleLock() {
        if (!locked) {
            
            do  {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
        locked.toggle()
    }
    private func addPage() {
        switch (sidebarDestination) {
        case .writing:
            addWritingPage()
        case .idea:
            addIdeaPage()
        case .goal:
            addGoalPage()
        }
    }
    private func addWritingPage() {
        withAnimation {
            let newPage = WritingPage(context: viewContext)
            newPage.id = UUID()
            newPage.date = Date()
            newPage.header = ""
            newPage.body = ""
            newPage.top1 = ""
            newPage.top2 = ""
            newPage.footer = ""
            do  {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    private func addIdeaPage() {
        withAnimation {
            let newPage = IdeaPage(context: viewContext)
            newPage.id = UUID()
            newPage.date = Date()
            newPage.body = ""
            do  {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    private func addGoalPage() {
        let newPage = GoalPage(context: viewContext)
        newPage.id = UUID()
        newPage.date = Date()
        newPage.name = "my page"
        
        let goal = Goal(context: viewContext)
        goal.title = ""
        
        goal.date = Date()
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
}

struct LogoView: View {
    var body: some View {
        Text(verbatim:"THE")
            .font(.title)
        + Text("ME")
            .font(.title)
            .bold()
        + Text("SYSTEM")
            .font(.title)
    }
}
