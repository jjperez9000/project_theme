//
//  IdeaMenuView.swift
//  project_theme
//
//  Created by John Perez on 8/12/22.
//

import SwiftUI

struct IdeaMenuView: View {
    //view for displaying a list of idea pages
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \IdeaPage.date, ascending: true)],
        animation: .default)
    private var pages: FetchedResults<IdeaPage>
    @Binding var selectedIdeaPageId: IdeaPage.ID?
    var body: some View {
        List(selection: $selectedIdeaPageId) {
            ForEach(pages) {page in
                //title is either new page or the beginnin of the page body
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

func getHeader(title: String) -> String {
    return title != "" ? title : "new page"
}
