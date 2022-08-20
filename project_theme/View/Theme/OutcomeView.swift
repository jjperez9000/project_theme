//
//  OutcomeView.swift
//  project_theme
//
//  Created by John Perez on 8/19/22.
//

import SwiftUI

struct OutcomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var outcome: Outcome
    var body: some View {
        ZStack {
            TextField("outcome", text: $outcome.body.toUnwrapped(defaultValue: ""))
                .frame(width: 540)
                .padding(20.0)
                .border(.black)
                .lineLimit(3)
                .multilineTextAlignment(.center)
                .textFieldStyle(.plain)
            ZStack {
                Circle()
                    .fill(Color.gray.opacity(0.01))
                    .frame(width: 50.0, height: 50.0)
                Image(systemName: "minus")
                
            }
            .onTapGesture(perform: {viewContext.delete(outcome)})
            .padding(.leading, 650)
            
        }.padding(0.5)
    }
}
