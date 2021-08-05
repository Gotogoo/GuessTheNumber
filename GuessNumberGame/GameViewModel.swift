//
//  GameViewModel.swift
//  GuessNumberGame
//
//  Created by Facheng Liang on 2021/7/29.
//

import Foundation

struct Result {
  var submitValue: String
  var checkResult: String
}

struct GamesData {
  var answerLength: Int = 4
  var answer: String?
  var inputValue: String?
  var changeNumbers: Int = 6
  var resultList: [Result]?
}

class GameViewModel: NSObject {
    
  var results: [Result]?
  var gameData = GamesData()
  
    init(length: Int = 4) {
      gameData.answerLength = length
    }

    func start() {
      gameData.answer = generateAnswer()
    }

    func submit(input: String) -> String {
      gameData.inputValue = input
      
      return "1A1B"
    }

  private func generateAnswer() -> String {
      var string = String()
    while string.count < gameData.answerLength {
        let character = String(Int.random(in: 0...9))
        if !string.contains(character) {
          string.append(character)
        }
      }
      return string
    }
}
