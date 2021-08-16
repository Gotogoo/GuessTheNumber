//
//  GameViewModel.swift
//  GuessNumberGame
//
//  Created by Facheng Liang on 2021/7/29.
//

import Foundation

enum AttempResult {
  case invalidInput
  case runningOut
  case incorrect(hint: String)
}

struct GameResult {
  var submitValue: String
  var checkResult: AttempResult
}

struct GamesData {
  var answerLength: Int = 4
  var attempNumber: Int = 6
  var answer: String
  var input: String
  var results: [GameResult]
}

class GameViewModel: NSObject {
    
  var result = GameResult()
  var gameData = GamesData()
  
  init(length: Int = 4) {
    gameData.answerLength = length
  }

  func start() {
    resetAnswer(generateAnswer())
  }
  
  func resetAnswer(_ answer: String) {
    gameData.answer = answer
  }

  func submit(input: String) -> [GameResult] {
    gameData.input = input
    
    guard validateInputValue(inputValue: input) else {
      gameData.results?.append(
        GameResult(
          submitValue: input,
          checkResult: "Invalid input!"
        )
      )
      return gameData.results ?? []
    }
    
    var containNumbers = 0, positionCorrectNumber = 0
    let answer = gameData.answer!

    zip(input, answer).forEach {
      if $0 == $1 {
        positionCorrectNumber += 1
      }
    }

    containNumbers = Set(input).intersection(Set(answer)).count - positionCorrectNumber
    
    result.submitValue = input
    result.checkResult = "\(positionCorrectNumber)A\(containNumbers)B"
    gameData.results?.append(result)
    gameData.attempNumber -= 1
    
    if gameData.attempNumber <= 0 {
      gameData.results?.append(
        GameResult(
          submitValue: input,
          checkResult: "Game failure!"
        )
      )
      return gameData.results ?? []
    }
    
    return gameData.results ?? []
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
