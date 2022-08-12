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
                .environmentObject(Store())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
        }.commands {
            SidebarCommands()
        }
    }
}
