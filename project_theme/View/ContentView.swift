//
//  ContentView.swift
//  project_theme
//
//  Created by John Perez on 7/29/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    //MY STUFF
    func toggleSidebar() {
        #if os(iOS)
        #else
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
        #endif
    }
    //MY STUFF
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {
        NavigationView {
            Sidebar()
                .toolbar {
                    Button(action: toggleSidebar) {
                        Label("hide", systemImage: "sidebar.left")
                    }
                }
                .frame(minWidth: 150)
            ThemeView()
        }

    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

struct Sidebar: View {
    var body: some View {
        List{
            NavigationLink(destination: ThemeView()) {
                Label("Theme", systemImage: "sparkles")
            }
            NavigationLink(destination: GenericPageView()) {
                Label("Writing", systemImage: "book")
            }
            NavigationLink(destination: GoalPageView()) {
                Label("Goals", systemImage: "flag.fill")
            }
            NavigationLink(destination: GoalPageView()) {
                Label("Ideas", systemImage: "circle.hexagonpath")
            }
        }
    }
}



struct GenericPageView: View {
    var body: some View {
        Text("Generic Pages").navigationTitle("Generic Pages")
    }
}


struct GoalPageView: View {
    var body: some View {
        Text("Goal Pages").navigationTitle("Goal Pages")
    }
}
//        NavigationView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//                    } label: {
//                        Text(item.timestamp!, formatter: itemFormatter)
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//            Text("Select an item")
//        }
