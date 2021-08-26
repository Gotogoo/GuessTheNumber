//
//  GameViewModel.swift
//  GuessNumberGame
//
//  Created by Facheng Liang on 2021/7/29.
//

import Foundation

enum AttempResult: Hashable {
  case invalidInput
  case runningOut
  case incorrect(hint: String)
  
  var message: String {
    switch self {
    case .incorrect(let hint):
      return hint
    case .invalidInput:
      return "invalid input"
    default:
      return "running out"
    }
  }
}

struct GameResult: Hashable {
  var submitValue: String
  var checkResult: AttempResult
  
  init(
    submitValue: String = "",
    checkResult: AttempResult = .incorrect(hint: "")
  ) {
    self.submitValue = submitValue
    self.checkResult = checkResult
  }
}

extension AttempResult: Equatable {
  
}

extension GameResult: Equatable {
  static func == (lhs: GameResult, rhs: GameResult) -> Bool {
    lhs.submitValue == rhs.submitValue && lhs.checkResult == rhs.checkResult
  }
}

public struct GamesData {
  var answerLength: Int = 4
  var attempNumber: Int = 6
  var answer: String?
  var input: String?
  var results: [GameResult] = []
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
    print("answer:", answer)
    gameData.answer = answer
  }
  
  func submit(input: String) -> [GameResult] {
    gameData.input = input
    
    guard validateInputValue(inputValue: input) else {
      gameData.results.append(
        GameResult(
          submitValue: input,
          checkResult: .invalidInput
        )
      )
      return gameData.results
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
    result.checkResult = .incorrect(hint: "\(positionCorrectNumber)A\(containNumbers)B")
    gameData.results.append(result)
    
    if input == answer {
      return gameData.results
    }
    
    gameData.attempNumber -= 1
    
    if gameData.attempNumber <= 0 {
      gameData.results.append(
        GameResult(
          submitValue: input,
          checkResult: .runningOut
        )
      )
      return gameData.results
    }
    
    return gameData.results
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
    Set(inputValue).count == 4 && Int(inputValue) != nil
  }
  
  // TODO: game restart
  func restart() {
    
  }
}
