//
//  ContentView.swift
//  project_theme
//
//  Created by John Perez on 7/29/22.
//

import SwiftUI


struct ContentView: View {
    
    func toggleSidebar() {
        #if os(iOS)
        #else
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
        #endif
    }
    
    
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
            NavigationLink(destination: IdeaPageView()) {
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

struct IdeaPageView: View {
    var body: some View {
        Text("Idea Pages").navigationTitle("Idea Pages")
    }
}
