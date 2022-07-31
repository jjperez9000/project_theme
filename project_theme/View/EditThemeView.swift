//
//  EditThemeView.swift
//  project_theme
//
//  Created by John Perez on 7/30/22.
//

import SwiftUI

struct EditThemeView: View {
    @State var tempTheme: String = " "
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
            TextField("Enter Na", text: $tempTheme)
                .font(.title)
                .frame(width: 540, height: 40)
                .padding(20)
                .border(.black)
                .background(.clear)
            Text("description")
                .font(.callout)
                .padding(.top)
            TextField("Enter Na", text: $tempTheme)
                .font(.title2)
                .frame(width: 540)
                .padding(20.0)
                .border(.black)
                .lineLimit(3)
            Text("ideal outcomes")
                .font(.callout)
                .padding(.top)
            
            
            
//            ForEach(oldTheme.outcomes) { outcome in
//                Text(outcome)
//                    .frame(width: 540)
//                    .padding(20.0)
//                    .border(.black)
//                    .lineLimit(3)
//            }
            
        }
    }
}

struct EditThemeView_Previews: PreviewProvider {
    static var previews: some View {
        EditThemeView()
    }
}
