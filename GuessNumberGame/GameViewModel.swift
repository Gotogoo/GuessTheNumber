//
//  GameViewModel.swift
//  GuessNumberGame
//
//  Created by Facheng Liang on 2021/7/29.
//

import Foundation

class GameViewModel: NSObject {

  private let length: Int
  private(set) var answer: String!

  init(length: Int = 4) {
    self.length = length
  }

  func start() {
    self.answer = generateAnswer()
  }

  func submit() -> String {
    return "1A1B"
  }

  private func generateAnswer() -> String {
    return "1234"
  }
}
