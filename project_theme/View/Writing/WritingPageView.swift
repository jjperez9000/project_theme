//
//  NewWritingPageView.swift
//  project_theme
//
//  Created by John Perez on 8/11/22.
//

import SwiftUI

struct NewWritingPageView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var page: WritingPage
    
    
    var body: some View {
        VStack {
            HStack {
                if page.date != nil {
                    Text("DATE          " + page.date!.formatted(date: .numeric, time: .omitted) + "        ").padding(.leading, 5)
                } else {
                    Text("no d8").padding(.leading, 5)
                }
                Divider().background(.black)
                TextField("title", text: $page.header.toUnwrapped(defaultValue: ""))
                    .onChange(of:$page.body.toUnwrapped(defaultValue: "").wrappedValue) {_ in
                        do  {
                            try viewContext.save()
                        } catch {
                            let nsError = error as NSError
                            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                        }
                    }
                    .multilineTextAlignment(.center)
                
            }
            .font(.callout)
            .frame(maxWidth: .infinity, maxHeight: 20)
            .border(.black)
            .background(.clear)
            .textFieldStyle(.plain)
            
            TextEditor(text: $page.top1.toUnwrapped(defaultValue: ""))
                .onChange(of:$page.top1.toUnwrapped(defaultValue: "").wrappedValue) {_ in
                    do  {
                        try viewContext.save()
                    } catch {
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
                }
                .font(.title2)
                .frame(maxWidth: .infinity, minHeight: 100, maxHeight: 100)
                .padding(10)
                .lineLimit(200)
                .border(.black)
                
            TextEditor(text:$page.top2.toUnwrapped(defaultValue: "") )
                .onChange(of:$page.top2.toUnwrapped(defaultValue: "").wrappedValue) {_ in
                    do  {
                        try viewContext.save()
                    } catch {
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
                }
                .font(.title2)
                .frame(maxWidth: .infinity, minHeight: 100, maxHeight: 100)
                .padding(10)
                .lineLimit(200)
                .border(.black)
                
            TextEditor(text: $page.body.toUnwrapped(defaultValue: ""))
                .onChange(of:$page.body.toUnwrapped(defaultValue: "").wrappedValue) {_ in
                    do  {
                        try viewContext.save()
                    } catch {
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
                }
                .font(.title2)
                .frame(maxWidth: .infinity, minHeight: 400)
                .padding(10)
                .lineLimit(200)
                .border(.black)
                
            TextEditor(text:$page.footer.toUnwrapped(defaultValue: "") )
                .onChange(of:$page.footer.toUnwrapped(defaultValue: "").wrappedValue) {_ in
                    do  {
                        try viewContext.save()
                    } catch {
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
                }
                .font(.title2)
                .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
                .padding(10)
                .lineLimit(200)
                .border(.black)
            
        }
        .padding(20)
        .background(.white)
        
    }
    func setName(from body: String) {
        let body = body.trimmingCharacters(in: .whitespacesAndNewlines)
        if body.count > 0 {
            page.body = String(body.prefix(25))
        } else {
            page.body = "new page"
        }
    }
}

extension Binding {
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}
