//
//  ContentView.swift
//  Shared
//
//  Created by sher on 4/4/22.
//

import SwiftUI

let screen = UIScreen.main.bounds


struct StartView: View {
    
    @State var text: String = ""
    @State var player1 = ""
    @State var player2 = ""
    @State var isShowed = false
    @State var isAlertPresent = false
   
    
    var body: some View {
        VStack {
            
        TitleText(text: "WordsGame")
            PlayersTextfields(player: $text, placeholder: "Введите длинное слово")
                .padding(20)
                .padding(.top,32)
              
            PlayersTextfields(player: $player1, placeholder: "Игрок 1")
                .padding(.horizontal, 20)
            
            PlayersTextfields(player: $player2, placeholder: "Игрок 2")
                .padding(.horizontal, 20)
              
            
            Button {
                if text.count > 6 {
                    self.isShowed.toggle()
                }
                    else {
                    isAlertPresent.toggle()
                }
               
                
            } label: {
                Text("Играть")
                    .padding()
                    .padding(.horizontal, 64)
                    .background(Color.red)
                    .foregroundColor(Color.white)
                    .font(.custom("AvenirNext-bold", size: 14))
                    .cornerRadius(24)
                    .padding()
                    
            }

            
        }
        .background(Image("background"))
        .alert("Слово слишком короткое! ", isPresented: $isAlertPresent, actions: {
            Text("OK")
        })
        
        
            .fullScreenCover(isPresented: $isShowed) {
                
                let name1 = player1 == "" ? "Игрок 1" : player1
                let name2 = player2 == "" ? "Игрок 2" : player2
                
                
                let player1 = Player(name: name1)
                let player2 = Player(name: name2)
                let gameViewModel = GameViewModel(player1: player1, player2: player2, word: text)
                
                GameView(viewmodel: gameViewModel)
                
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
        
    }
}
