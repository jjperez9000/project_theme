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
            NavigationLink(destination: WritingView()) {
                Label("Writing", systemImage: "book")
            }
            NavigationLink(destination: GoalView()) {
                Label("Goals", systemImage: "flag.fill")
            }
            NavigationLink(destination: IdeaPageView()) {
                Label("Ideas", systemImage: "circle.hexagonpath")
            }
        }
    }
}

struct IdeaPageView: View {
    var body: some View {
        Text("Idea Pages").navigationTitle("Idea Pages")
    }
}
