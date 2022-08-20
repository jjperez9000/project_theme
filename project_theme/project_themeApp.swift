//
//  project_themeApp.swift
//  project_theme
//
//  Created by John Perez on 7/29/22.
//

import SwiftUI

@main
struct project_themeApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    NSWindow.allowsAutomaticWindowTabbing = false
                }
                .frame(minWidth: 605)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
        }.commands {
            SidebarCommands()
        }
    }
}

//TODO: have button to add / remove ideal outcomes
//Add Dates to goal page
//add art to goal page
//add duplicate button for goal page
//add theme archive
