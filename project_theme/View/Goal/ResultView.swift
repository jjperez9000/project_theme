//
//  ResultView.swift
//  project_theme
//
//  Created by John Perez on 8/19/22.
//

import SwiftUI


struct ResultView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var result: Result
    
    var body: some View{
        VStack {
            Text(String(result.number)).padding(20)
            Text(String(result.success)).padding(20)
            ResultCircle(success: result.success)
            .onTapGesture(perform: {
                result.success = result.success < 2 ? result.success + 1 : 0
                
                do  {
                    try viewContext.save()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            })
            .rotationEffect(Angle(degrees: 135))
        }
    }
}

struct ResultCircle: View {
    var success: Int16
    var body: some View {
        ZStack {
            
            if(success == 0) {
                Circle()
                    .stroke(Color.black, lineWidth: 1)
                    .frame(width: 50.0, height: 50.0)
                    .padding(20)
            } else if (success == 1) {
                Circle()
                    .stroke(Color.black, lineWidth: 1)
                    .frame(width: 50.0, height: 50.0)
                    .padding(20)
                Circle()
                    .trim(from: 0.5, to: 1)
                    .fill(Color.gray.opacity(0.8))
                    .frame(width: 50.0, height: 50.0)
                    .padding(20)
            } else {
                Circle()
                    .stroke(Color.black, lineWidth: 1)
                    .frame(width: 50.0, height: 50.0)
                    .padding(20)
                Circle()
                    .fill(Color.gray.opacity(0.8))
                    .frame(width: 50.0, height: 50.0)
                    .padding(20)
            }
            
            Rectangle()
                .frame(width: 50, height: 1)
            
            Circle()
                .fill(Color.black.opacity(0.01))
                .frame(width: 50.0, height: 50.0)
                .opacity(1.0)
            
            
        }
    }
}

