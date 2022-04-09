//
//  TitleText.swift
//  wordsGame (iOS)
//
//  Created by sher on 7/4/22.
//

import SwiftUI

struct TitleText: View {
    @State var text: String
    var body: some View {
        
        
        Text(text)
            .padding()
            .frame(maxWidth: .infinity)
            .font(.custom("AvenirNext-bold", size: 32))
            .background(Color("title"))
            .foregroundColor(Color.white)
    }
}

struct TitleText_Previews: PreviewProvider {
    static var previews: some View {
        TitleText(text: "Магнитотерапия")
    }
}
