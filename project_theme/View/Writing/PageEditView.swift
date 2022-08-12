//
//  PageEditView.swift
//  project_theme
//
//  Created by John Perez on 7/31/22.
//

import SwiftUI

//addition to make the textField backgrounds the proper color
extension NSTextView {
    open override var frame: CGRect {
        didSet {
            backgroundColor = .clear
            drawsBackground = true
        }

    }
}


struct PageEditView: View {
    @EnvironmentObject var database: Store
    @Environment(\.scenePhase) private var scenePhase
    @State var myID: UUID

    var body: some View {
        VStack {
            HStack {
                Text("DATE          " + database.pages.filter({$0.id == myID}).first!.date.formatted(date: .numeric, time: .omitted)
                    + "        ")
                    .padding(.leading, 5)
                
                Divider().background(.black)
                TextField("title", text: $database.pages.filter({$0.id == myID}).first!.header )
                    .onChange(
                        of: $database.pages.filter({$0.id == myID}).first!.header.wrappedValue) {_ in
                        database.save()
                        UserDefaults.standard.set(try? PropertyListEncoder().encode(database.pages), forKey:"pages")
                    }
                    .multilineTextAlignment(.center)
                
            }
            .font(.callout)
            .frame(maxWidth: .infinity, maxHeight: 20)
            .border(.black)
            .background(.clear)
            .textFieldStyle(.plain)
            
            TextEditor(text: $database.pages.filter({$0.id == myID}).first!.top1)
                .onChange(of: $database.pages.filter({$0.id == myID}).first!.top1.wrappedValue) {_ in
                    database.save()
                    UserDefaults.standard.set(try? PropertyListEncoder().encode(database.pages), forKey:"pages")
                }
                .font(.title2)
                .frame(maxWidth: .infinity, minHeight: 100, maxHeight: 100)
                .padding(10)
                .lineLimit(200)
                .border(.black)
                
            TextEditor(text: $database.pages.filter({$0.id == myID}).first!.top2 )
                .onChange(of: $database.pages.filter({$0.id == myID}).first!.top1.wrappedValue) {_ in
                    database.save()
                    UserDefaults.standard.set(try? PropertyListEncoder().encode(database.pages), forKey:"pages")
                }
                .font(.title2)
                .frame(maxWidth: .infinity, minHeight: 100, maxHeight: 100)
                .padding(10)
                .lineLimit(200)
                .border(.black)
                
            TextEditor(text: $database.pages.filter({$0.id == myID}).first!.body )
                .onChange(of: $database.pages.filter({$0.id == myID}).first!.body.wrappedValue) {_ in
                    database.save()
                    UserDefaults.standard.set(try? PropertyListEncoder().encode(database.pages), forKey:"pages")
                }
                .font(.title2)
                .frame(maxWidth: .infinity, minHeight: 400)
                .padding(10)
                .lineLimit(200)
                .border(.black)
                
            TextEditor(text: $database.pages.filter({$0.id == myID}).first!.footer )
                .onChange(of: $database.pages.filter({$0.id == myID}).first!.footer.wrappedValue) {_ in
                    saveFiles()
                }
                .font(.title2)
                .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                .padding(10)
                .lineLimit(200)
                .border(.black)
                
        }.padding(20)
        
    }
    private func saveFiles() {
//        database.save()
//        UserDefaults.standard.set(try? PropertyListEncoder().encode(database.pages), forKey:"pages")
    }
}
