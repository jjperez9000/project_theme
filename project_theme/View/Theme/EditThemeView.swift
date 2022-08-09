//
//  EditThemeView.swift
//  project_theme
//
//  Created by John Perez on 7/30/22.
//

import SwiftUI

struct EditThemeView: View {
    @EnvironmentObject var themeVM: Store
    var body: some View {
        ZStack {
            VStack {
                LogoView()
                Text("theme")
                    .font(.callout)
                    .padding(.top)
                TextField("your theme", text: $themeVM.theme.theme)
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
                TextField("describe ur theme uwu", text: $themeVM.theme.description, axis: .vertical)
                    .font(.title2)
                    .frame(width: 540)
                    .padding(20.0)
                    .border(.black)
                    .lineLimit(3)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.plain)
                Text("ideal outcomes")
                    .font(.callout)
                    .padding(.top)
                
                ForEach(themeVM.theme.outcomes.indices, id:\.self) { idx in
                    TextField("outcome", text: $themeVM.theme.outcomes[idx])
                        .frame(width: 540)
                        .padding(20.0)
                        .border(.black)
                        .lineLimit(3)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(.plain)
                }
            }
        }

    }
    
    private func saveTheme() {
        
        UserDefaults.standard.set(try? PropertyListEncoder().encode(themeVM.theme), forKey:"theme")
    }
}

struct EditThemeView_Previews: PreviewProvider {
    static var previews: some View {
        EditThemeView()
    }
}
