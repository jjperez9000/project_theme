//
//  StaticThemeView.swift
//  project_theme
//
//  Created by John Perez on 7/30/22.
//

import SwiftUI

struct StaticThemeView: View {
    
    @EnvironmentObject var themeVM: Store
    
    var body: some View {
        VStack {
            LogoView()
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
}

struct StaticThemeView_Previews: PreviewProvider {
    static var previews: some View {
        StaticThemeView()
    }
}
