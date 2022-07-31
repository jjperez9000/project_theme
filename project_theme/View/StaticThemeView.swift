//
//  StaticThemeView.swift
//  project_theme
//
//  Created by John Perez on 7/30/22.
//

import SwiftUI

struct StaticThemeView: View {
    
    
    
    //    var theme = Theme(
    //        theme: "creation",
    //        description: "Contribute to the world, don't consume from the worldContribute to the world, don't consume from the worldContribute to the world, don't consume from the worldContribute to the world, don't consume from the worldContribute to the world, don't consume from the world",
    //        outcomes: [
    //            "Be less lazy",
    //            "Live more like Larry",
    //            "pogpogpogpog",
    //        ])
    
    @ObservedObject var themeVM = ThemeViewModel()
    
    var body: some View {
        VStack {
            Button("save :)", action: saveTheme)
            Button("changeshit", action: updateThing)
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
            Text(themeVM.theme.theme)
                .font(.title)
                .frame(width: 540, height: 40)
                .padding(20)
                .border(.black)
            Text("description")
                .font(.callout)
                .padding(.top)
            Text(themeVM.theme.description)
                .font(.title2)
                .frame(width: 540)
                .padding(20.0)
                .border(.black)
                .lineLimit(3)
            Text("ideal outcomes")
                .font(.callout)
                .padding(.top)
            
            
            
            ForEach(themeVM.theme.outcomes) { outcome in
                Text(outcome)
                    .frame(width: 540)
                    .padding(20.0)
                    .border(.black)
                    .lineLimit(3)
            }
            
        }
        
    }
    private func saveTheme() {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(themeVM.theme), forKey:"theme")
    }
    private func updateThing() {
        themeVM.theme.theme = "diff"
        themeVM.save()
    }
    
}

struct StaticThemeView_Previews: PreviewProvider {
    static var previews: some View {
        StaticThemeView()
    }
}
