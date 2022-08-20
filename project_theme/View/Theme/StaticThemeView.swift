//
//  StaticThemeView.swift
//  project_theme
//
//  Created by John Perez on 7/30/22.
//

import SwiftUI

struct StaticThemeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var theme: CdTheme
    var body: some View {
        VStack {
            LogoView()
            Text("theme")
                .font(.callout)
                .padding(.top)
            Text(theme.title ?? "")
                .font(.title)
                .frame(width: 540, height: 40)
                .padding(20)
                .border(.black)
            Text("description")
                .font(.callout)
                .padding(.top)
            Text(theme.summary ?? "")
                .font(.title2)
                .frame(width: 540)
                .padding(20.0)
                .border(.black)
                .lineLimit(3)
            Text("ideal outcomes")
                .font(.callout)
                .padding(.top)
            if theme.outcomes != nil {
                ForEach(getSortedOutcomes(), id: \.self) { outcome in
                    Text(outcome.body ?? "")
                        .frame(width: 540)
                        .padding(20.0)
                        .border(.black)
                        .lineLimit(3)
                }
            }
        }
        
    }
    private func getSortedOutcomes() -> [Outcome] {
        return (theme.outcomes as! Set<Outcome>).sorted(by: {$0.date! < $1.date!})
    }
}
