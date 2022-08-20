//
//  EditThemeView.swift
//  project_theme
//
//  Created by John Perez on 7/30/22.
//

import SwiftUI

struct EditThemeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var theme: CdTheme
    var body: some View {
        
            VStack {
                LogoView()
                Text("theme")
                    .font(.callout)
                    .padding(.top)
                TextField("your theme", text: $theme.title.toUnwrapped(defaultValue: ""))
                    .font(.title)
                    .frame(width: 540, height: 40)
                    .padding(20)
                    .border(.black)
                    .background(.clear)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.plain)
                Text("description")
                    .font(.callout)
                    .padding(.top)
                TextField("your theme", text: $theme.summary.toUnwrapped(defaultValue: ""))
                    .font(.title2)
                    .frame(width: 540, height: 40)
                    .padding([.top, .bottom], 10)
                    .padding([.leading, .trailing], 20)
                    .border(.black)
                    .background(.clear)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.plain)
                Text("ideal outcomes")
                    .font(.callout)
                    .padding(.top)
                if theme.outcomes != nil {
                    ForEach(getSortedOutcomes(), id: \.self) { outcome in
                        OutcomeView(outcome: outcome)
                    }
                }
                Button(action: addOutcome) {
                    Text("add outcome")
                }.padding()
            }
            
        

    }
    private func addOutcome() {
        let outcome = Outcome(context: viewContext)
        outcome.body = ""
        outcome.date = Date()
        theme.addToOutcomes(outcome)
        
        do  {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    private func getSortedOutcomes() -> [Outcome] {
        return (theme.outcomes as! Set<Outcome>).sorted(by: {$0.date! < $1.date!})
    }
}
