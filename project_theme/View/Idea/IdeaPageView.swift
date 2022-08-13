//
//  IdeaPageView.swift
//  project_theme
//
//  Created by John Perez on 8/12/22.
//


import SwiftUI

struct IdeaPageView: View {
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
        
    }
}

