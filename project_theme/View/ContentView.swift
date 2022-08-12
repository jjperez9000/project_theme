

//
//  ContentView.swift
//  project_theme
//
//  Created by John Perez on 7/29/22.
//

import SwiftUI

struct Post: Identifiable, Hashable {
    let id = UUID()
    let title = "A post title"
    let preview = "Some wall of text to represent the preview of a post that nobody will read if the title is not a clickbait"
}

enum Destination: Hashable {
    case theme
    case writing
    case goal
    case idea
}


struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var database: Store
   
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \WritingPage.date, ascending: true)],
        animation: .default)
    private var pages: FetchedResults<WritingPage>
    @State private var selectedPageId: WritingPage.ID?
    @State private var sidebarDestination: Destination = .theme
    @State private var navVisibility: NavigationSplitViewVisibility = .all
    private var selectedPage: WritingPage? {
        guard let selectedPage = pages.filter({$0.id == selectedPageId}).first else {
            return nil
        }
        return selectedPage
    }
    
    var body: some View {
        NavigationSplitView(columnVisibility: $navVisibility) {
            SidebarView(destination: $sidebarDestination)
        } content: {
            List(selection: $selectedPageId) {
                ForEach(pages) {page in
                    Text(page.date!.formatted(date: .numeric, time: .omitted) + "  |  " + page.header! )
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
        } detail: {
            if let page = selectedPage {
                NewWritingPageView(page: page)
            } else {
                ThemeView()
            }
        }.toolbar {
            ToolbarItem {
                Button(action: addPage) {
                    Label("Add Item", systemImage: "square.and.pencil")
                }
            }
        }
        
        
    }
    
    private func addPage() {
        withAnimation {
            let newPage = WritingPage(context: viewContext)
            newPage.id = UUID()
            newPage.date = Date()
            newPage.header = "new page"
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


struct SidebarView: View {
    @Binding var destination: Destination
    var body: some View {
        List(selection: $destination) {
            NavigationLink(value: Destination.theme) {
                Label("theme", systemImage: "sparkles")
            }
            NavigationLink(value: Destination.writing) {
                Label("writing", systemImage: "book")
            }
            NavigationLink(value: Destination.goal) {
                Label("goal", systemImage: "flag.fill")
            }
            NavigationLink(value: Destination.idea) {
                Label("idea", systemImage: "circle.hexagonpath")
            }
        }
    }
}

struct IdeaPageView: View {
    var body: some View {
        Text("Idea Pages").navigationTitle("Idea Pages")
    }
}
