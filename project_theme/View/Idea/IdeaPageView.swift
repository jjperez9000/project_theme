//
//  IdeaPageView.swift
//  project_theme
//
//  Created by John Perez on 8/12/22.
//


import SwiftUI

struct IdeaPageView: View {
    //view for displaying an individual idea page
    //mostly just a simple text editor 
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var page: IdeaPage
    
    var body: some View {
        TextEditor(text: $page.body.toUnwrapped(defaultValue: ""))
            .onChange(of:$page.body.toUnwrapped(defaultValue: "").wrappedValue) {_ in
                do  {
                    try viewContext.save()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
            .font(.title2)
            .frame(maxWidth: .infinity, minHeight: 400)
            .padding(10)
            .lineLimit(200)
            .border(.black)
            .toolbar {
                ToolbarItem {
                    Button(action: addIdeaPage) {
                        Label("Add Item", systemImage: "square.and.pencil")
                    }
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
}

