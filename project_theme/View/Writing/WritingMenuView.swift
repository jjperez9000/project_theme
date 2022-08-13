//
//  WritingMenuView.swift
//  project_theme
//
//  Created by John Perez on 8/12/22.
//

import SwiftUI

struct WritingMenuView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \WritingPage.date, ascending: true)],
        animation: .default)
    private var pages: FetchedResults<WritingPage>
    @Binding var selectedWritingPageId: WritingPage.ID?
    var body: some View {
        List(selection: $selectedWritingPageId) {
            ForEach(pages) {page in
                Text(page.date!.formatted(date: .numeric, time: .omitted) + "  |  " + getHeader(title: page.header!) )
                    .contextMenu {
                        Button("delete page") {
                            if pages.firstIndex(of: page) != nil {
                                viewContext.delete(page)
                            }
                        }
                    }
            }
            .onDelete(perform: deletePages)
        }.toolbar {
            ToolbarItem {
                Button(action: addPage) {
                    Label("Add Item", systemImage: "square.and.pencil")
                }
            }
        }
    }
    private func getHeader(title: String) -> String {
        return title != "" ? title : "new page"
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
    private func addPage() {
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
}
