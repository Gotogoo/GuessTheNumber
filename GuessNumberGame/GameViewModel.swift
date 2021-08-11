//
//  GameViewModel.swift
//  GuessNumberGame
//
//  Created by Facheng Liang on 2021/7/29.
//

import Foundation

struct GameResult {
  var submitValue: String?
  var checkResult: String?
}

struct GamesData {
  var answerLength: Int = 4
  var answer: String?
  var inputValue: String?
  var changeNumbers: Int = 6
  var resultList: [GameResult]?
  var errorMessage: String = ""
}

class GameViewModel: NSObject {
    
  var result = GameResult()
  var gameData = GamesData()
  
  init(length: Int = 4) {
    gameData.answerLength = length
  }

  func start() {
    gameData.answer = generateAnswer()
  }

  func submit(input: String) -> String {
    gameData.inputValue = input
    
    guard validateInputValue(inputValue: input) else {
      gameData.errorMessage = "error input value!"
      return gameData.errorMessage
    }
    
    var containNumbers = 0, positionCorrectNumber = 0
    let answer = gameData.answer!
    
    input.enumerated().forEach { index, character in
      if character == answer[answer.index(answer.startIndex, offsetBy: index)] {
        positionCorrectNumber += 1
        return
      }
      
      if answer.contains(character) {
        containNumbers += 1
      }
    }
    result.submitValue = input
    result.checkResult = "\(positionCorrectNumber)A\(containNumbers)B"
    gameData.resultList?.append(result)
    gameData.changeNumbers -= 1
    
    if gameData.changeNumbers <= 0 {
      return "game failure!"
    }
    
    return result.checkResult!
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
  
  private func validateInputValue(inputValue: String) -> Bool {
    guard Set(inputValue).count == 4 && Int(inputValue) != nil else {
      return false
    }
    return true
  }
}
