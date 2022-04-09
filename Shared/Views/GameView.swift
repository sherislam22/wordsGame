//
//  GameView.swift
//  wordsGame
//
//  Created by sher on 4/4/22.
//

import SwiftUI

struct GameView: View {
    
    var viewmodel: GameViewModel
    @State var isexit = false
    @State private var result = ""
    @State private var isAlertPresent = false
    @State var alertText = ""
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        
        VStack {
            HStack {
        Button {
            print("ok")
            
            isexit.toggle()
            
        } label: {
            Text("Exit")
                .padding()
                .foregroundColor(.white)
                .font(.custom("AvenirNext-bold", size: 16))
                .padding(.horizontal, 16)
                .background(Color("title"))
                .cornerRadius(12)
                .padding(.horizontal,12)
        }
                
                Spacer()
                
        }
            
            Text(viewmodel.word)
                .padding()
                .foregroundColor(.white)
                .cornerRadius(12)
                
                .font(.custom("AvenirNext-bold", size: 32))
            
            
            HStack( spacing: 12) {
                VStack {
                    Text("\(viewmodel.player1.score)")
                        .padding(.horizontal)
                        .font(.custom("AvenirNext-bold", size: 60))
                        .foregroundColor(.white)
                    Text(viewmodel.player1.name)
                        .padding(.horizontal,16)
                        .font(.custom("AvenirNext-bold", size: 24))
                        .foregroundColor(.white)
                        
                    
                }.padding(20)
                    .frame(width: screen.width / 2.2, height: screen.width / 2.2 )
                    .background(.red)
                    .cornerRadius(20)
                    .shadow(color: viewmodel.isFirst ?  .red : .clear, radius: 20, x: 0, y: 0)
    
                
                VStack {
                    Text("\(viewmodel.player2.score)")
                        .padding(.horizontal)
                        .font(.custom("AvenirNext-bold", size: 60))
                        .foregroundColor(.white)
                    Text(viewmodel.player2.name)
                        .padding(.horizontal,16)
                        .font(.custom("AvenirNext-bold", size: 24))
                        .foregroundColor(.white)
                    
                }.padding(20)
                    .frame(width: screen.width / 2.2, height: screen.width / 2.2 )
                    .background(Color("title"))
                    .cornerRadius(20)
                    .shadow(color: viewmodel.isFirst ? .clear : .brown, radius: 20, x: 0, y: 0)
                    
            }.padding(.bottom,12)
           
            
            VStack {
                PlayersTextfields(player:$result, placeholder: "Ваше слово")
                    .padding(.horizontal,32)
                
                Button {
                    
                    var score = 0
                    
                    do {
                        try score =  viewmodel.check(word: result)
                        
                    } catch  WordError.theSameWord {
                        alertText = "Так нельзя! "
                        isAlertPresent.toggle()
                    }  catch  WordError.beforeword {
                        alertText = "прояви фантазия придумай новое слово! "
                        isAlertPresent.toggle()
                    } catch  WordError.wrongerror {
                        alertText = "Так нельзя! "
                        isAlertPresent.toggle()
                     } catch  WordError.litleword {
                        alertText = "Слишком короткое слово!"
                        isAlertPresent.toggle()
                    } catch  WordError.underfinedError {
                        alertText = "неизвестная ошибка!"
                        isAlertPresent.toggle()
                    } catch {
                        alertText = "error"
                        isAlertPresent.toggle()
                    }
                    
                    
                    if score > 1 {
                        self.result = ""
                    }
                    
                } label: {
                    Text("Отправить")
                        .padding()
                        .background(Color.red)
                        .cornerRadius(12)
                        .padding(.top,12)
                        .foregroundColor(.white)
                        .font(.custom("AvenirNext-bold", size: 20))
                        
                }
                
                List {
                    ForEach(0..<viewmodel.words.count, id:\.description) { item in
                        wordCell(word: self.viewmodel.words[item])
                            .background(item % 2 == 0 ? Color.red : Color.brown)
                            .listRowInsets(EdgeInsets())
                    }
                    
                    
                }.listStyle(.plain)
                    .cornerRadius(12)
                    .background(.clear)
                    
                .frame( maxWidth: .infinity,  maxHeight: .infinity)
                .padding()
            }
            
        }
        .background(Image("background"))
        .confirmationDialog("Вы хотите завершить игру?", isPresented: $isexit, titleVisibility: .visible) {
            Button(role: .destructive) {
                dismiss()
            } label: {
                Text("Да")
            }
            Button(role: .cancel) { } label: {
                Text("Нет")
            }
        }
        .alert(alertText, isPresented: $isAlertPresent) {
            Text("OK")
        }
    }
        
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewmodel: GameViewModel(player1: Player(name: "Vasya"), player2: Player(name: "Serega"), word: "Магнитотерапия"))
    }
}
