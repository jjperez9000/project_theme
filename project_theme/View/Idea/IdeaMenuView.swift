//
//  IdeaMenuView.swift
//  project_theme
//
//  Created by John Perez on 8/12/22.
//

import SwiftUI

struct IdeaMenuView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \IdeaPage.date, ascending: true)],
        animation: .default)
    private var pages: FetchedResults<IdeaPage>
    @Binding var selectedIdeaPageId: IdeaPage.ID?
    var body: some View {
        List(selection: $selectedIdeaPageId) {
            ForEach(pages) {page in
                Text(getHeader(title: page.body!))
                    .truncationMode(.tail)
                    .lineLimit(1)
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
}
