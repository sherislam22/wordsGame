//
//  wordCell.swift
//  wordsGame
//
//  Created by sher on 9/4/22.
//

import SwiftUI

struct wordCell: View {
    let word: String
    var body: some View {
        HStack {
            Text("\(word)")
                .listRowSeparator(.hidden)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .padding()
                .font(.custom("AvenirNext-bold", size: 22))
                .foregroundColor(.white)
            
            Text("\(word.count)")
                
                .padding()
                .font(.custom("AvenirNext-bold", size: 22))
                .foregroundColor(.white)
        }
    }
}

struct wordCell_Previews: PreviewProvider {
    static var previews: some View {
        wordCell(word: "Magnit")
    }
}
