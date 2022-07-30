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
    
    struct myTheme {
        var theme: String
        var description: String
        var outcomes: [String]
    }
    
    var theme = myTheme(
        theme: "creation",
        description: "Contribute to the world, don't consume from the worldContribute to the world, don't consume from the worldContribute to the world, don't consume from the worldContribute to the world, don't consume from the worldContribute to the world, don't consume from the world",
        outcomes: [
            "Be less lazy",
            "Live more like Larry",
            "pogpogpogpog",
        ])
    
    var body: some View {
        VStack {
            
            Text(verbatim:"THE")
                .font(.title)
            + Text("ME")
                .font(.title)
                .bold()
            + Text("SYSTEM")
                .font(.title)
            Text("theme")
                .font(.callout)
                .padding(.top)
            Text(theme.theme)
                .font(.title)
                .frame(width: 540, height: 40)
                .padding(20)
                .border(.black)
            Text("description")
                .font(.callout)
                .padding(.top)
            Text(theme.description)
                .font(.title2)
                .frame(width: 540)
                .padding(20.0)
                .border(.black)
                .lineLimit(3)
            Text("ideal outcomes")
                .font(.callout)
                .padding(.top)
            ForEach(theme.outcomes) { outcome in
                Text(outcome)
                    .frame(width: 540)
                    .padding(20.0)
                    .border(.black)
                    .lineLimit(3)
            }
            
        }
        .toolbar {
            Button(action: {}) {
                Label("lock", systemImage: "lock")
            }
        }
    }
}

struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ThemeView()
        }
    }
}
