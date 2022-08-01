//
//  WritingView.swift
//  project_theme
//
//  Created by John Perez on 7/31/22.
//

import SwiftUI

struct WritingView: View {
    @EnvironmentObject var database: Store
    
    var body: some View {
        List {
            ForEach(database.pages) { page in
                NavigationLink(page.top1, destination: PageEditView())
            }
        }.toolbar {
            Button(action: newPage) {
                Label("new page", systemImage: "leaf")
            }
        }
        
    }
    
    private func newPage() {
        database.pages.append(.pagePlaceholder)
    }
}

struct WritingView_Previews: PreviewProvider {
    static var previews: some View {
        WritingView()
    }
}
