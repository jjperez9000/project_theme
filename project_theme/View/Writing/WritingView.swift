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
        NavigationView {
            List {
                ForEach(database.pages) { page in
                    NavigationLink(page.date.formatted(date: .numeric, time: .omitted) + "  |  " + page.header, destination: PageEditView(myID: page.id))
                }.onDelete(perform: removeRows)
            }
            Text("No Page Selected")
        }
        .toolbar {
            Button("new page", action: newPage)
        }
    }
    private func newPage() {
        database.pages.append(.pagePlaceholder)
    }
    private func removeRows(at offsets: IndexSet) {
        database.pages.remove(atOffsets: offsets)
        database.save()
    }
}

struct WritingView_Previews: PreviewProvider {
    static var previews: some View {
        WritingView()
    }
}
