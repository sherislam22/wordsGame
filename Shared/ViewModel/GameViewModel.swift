//
//  GameViewModel.swift
//  wordsGame
//
//  Created by sher on 9/4/22.
//

import Foundation

enum WordError: Error {
    case theSameWord
    case beforeword
    case litleword
    case wrongerror
    case underfinedError
}

class GameViewModel: ObservableObject {
    
   
    
    @Published var player1: Player
    @Published var player2: Player
    @Published var words = [String]()
    let word: String
    
    var isFirst = true
    
    init(player1: Player, player2: Player, word: String) {
        self.player1 = player1
        self.player2 = player2
        self.word = word.uppercased()
    }
    
    // MARK: Валидация слова
    func validate(word: String) throws {
        let word = word.uppercased()
        guard word != self.word else {
            print("Так нельзя! ")
            throw WordError.theSameWord
        }
        
        guard !(words.contains(word)) else {
            print("прояви фантазия придумай новое слово! ")
            throw WordError.beforeword
        }
        
        guard word.count > 2  else {
            print("Слишком короткое слово! ")
            throw WordError.litleword
        }
        
        return
    }
    // MARK: Преврашение слово к символам
    func WordToChars(word: String) -> [Character] {
        var chars = [Character]()
        for char in word.uppercased() {
            chars.append(char)
        }
        return chars
    }
    // MARK: Проверка слова и добавление очков к игроку
    func check(word: String)  throws -> (Int) {
        
        do {
            try self.validate(word: word)
            
        } catch {
            throw error
        }
        
        var bigWordArray = WordToChars(word: self.word)
        let SmallWordArray = WordToChars(word: word)
        var result = ""
        
        for char in SmallWordArray {
            if bigWordArray.contains(char) {
                result.append(char)
                var i = 0
                while bigWordArray[i] != char {
                    i+=1
                }
                bigWordArray.remove(at: i)
                
            } else {
                throw WordError.wrongerror
            }
        }
        guard result == word.uppercased() else {
            print("error")
            return 0
        }
        
        words.append(result)
        if isFirst {
            player1.score += result.count
            
        } else {
            player2.score += result.count
        }
        
        isFirst.toggle()
        // return score
        return result.count
        
    }
}
