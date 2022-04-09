//
//  PlayersTextfields.swift
//  wordsGame (iOS)
//
//  Created by sher on 7/4/22.
//

import SwiftUI

struct PlayersTextfields: View {
    @State var player: Binding<String>
    var placeholder: String
    var body: some View {
        TextField(placeholder, text: player)
            .padding()
            
            .background(Color.white)
            .font(.custom("AvenirNext-bold", size: 14))
            .cornerRadius(12)
    }
}

