//
//  project_themeApp.swift
//  project_theme
//
//  Created by John Perez on 7/29/22.
//

import SwiftUI

@main
struct project_themeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    NSWindow.allowsAutomaticWindowTabbing = false
                }
                .frame(minWidth: 605)
                .environmentObject(Store())
            
        }.commands {
            SidebarCommands()
        }
    }
}
