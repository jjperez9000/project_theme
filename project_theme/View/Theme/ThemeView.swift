//
//  ThemeView.swift
//  project_theme
//
//  Created by John Perez on 7/29/22.
//

import SwiftUI
import CoreData

struct ThemeView: View {
    
    @State var locked: Bool = true
    @EnvironmentObject var themeVM: Store
    
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
        if (!locked) {
            themeVM.save()
            UserDefaults.standard.set(try? PropertyListEncoder().encode(themeVM.theme), forKey:"theme")
        }
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

struct LogoView: View {
    var body: some View {
        Text(verbatim:"THE")
            .font(.title)
        + Text("ME")
            .font(.title)
            .bold()
        + Text("SYSTEM")
            .font(.title)
    }
}
