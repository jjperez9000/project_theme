//
//  ThemeView.swift
//  project_theme
//
//  Created by John Perez on 7/29/22.
//

import SwiftUI
import CoreData

extension String: Identifiable {
    public typealias ID = Int
    public var id: Int {
        return hash
    }
}

struct ThemeView: View {
    @State var locked: Bool = true
   
    
    var body: some View {
        if (locked) {
            StaticThemeView().toolbar {
                Button(action: toggleLock) {
                    Label("lock", systemImage: "lock")
                }
            }
            
        } else {
            EditThemeView().toolbar {
                Button(action: toggleLock) {
                    Label("lock", systemImage: "lock.open")
                }
            }
            
        }
    }
    private func toggleLock() {
        locked.toggle()
    }
   
   
}

struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ThemeView()
        }
    }
}
