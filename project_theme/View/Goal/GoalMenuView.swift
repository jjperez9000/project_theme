//
//  GoalMenuView.swift
//  project_theme
//
//  Created by John Perez on 8/12/22.
//

import SwiftUI

struct GoalMenuView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \GoalPage.date, ascending: true)],
        animation: .default)
    private var pages: FetchedResults<GoalPage>
    @Binding var selectedGoalPageId: GoalPage.ID?
    
    var body: some View {
        List(selection: $selectedGoalPageId) {
            ForEach(pages) {page in
                Text(page.date!.formatted(date: .numeric, time: .omitted) + "  |  " + getHeader(title: page.name!) )
                    .contextMenu {
                        Button("delete page") {
                            if pages.firstIndex(of: page) != nil {
                                viewContext.delete(page)
                            }
                        }
                    }
            }
            .onDelete(perform: deletePages)
        }
        
    }
    
    private func deletePages(offsets: IndexSet) {
        withAnimation {
            offsets.map {pages[$0]}.forEach(viewContext.delete)
//            pages.forEach(viewContext.delete) // delete all pages
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

