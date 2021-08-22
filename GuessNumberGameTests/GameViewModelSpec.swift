//
//  GameViewModelSpec.swift
//  GuessNumberGameTests
//
//  Created by Facheng Liang on 2021/7/29.
//

import XCTest

@testable import GuessNumberGame

class GameViewModelSpec: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGeneratedAnswer() throws {
      let viewModel = GameViewModel()
      viewModel.resetAnswer("1234")
      
      XCTAssertEqual(viewModel.gameData.answer!.count, 4)
      XCTAssertEqual(Set(viewModel.gameData.answer!).count, 4)
      XCTAssertNotNil(Int(viewModel.gameData.answer!))
    }

    func testSubmitInputErrorValue() throws {
      let viewModel = GameViewModel()
      viewModel.resetAnswer("1234")
      
      let errorResult = viewModel.submit(input: "1224")
      XCTAssertEqual(errorResult, [GameResult(submitValue: "1224", checkResult: .invalidInput)])
    }
  
  func testSubmitCount() throws {
    let viewModel = GameViewModel()
    viewModel.resetAnswer("1982")
    
    viewModel.submit(input: "1234")
    XCTAssertEqual(viewModel.gameData.attempNumber, 5)
    
    viewModel.submit(input: "1524")
    XCTAssertEqual(viewModel.gameData.attempNumber, 4)
    
    viewModel.submit(input: "1264")
    XCTAssertEqual(viewModel.gameData.attempNumber, 3)
    
    viewModel.submit(input: "1724")
    XCTAssertEqual(viewModel.gameData.attempNumber, 2)
    
    viewModel.submit(input: "6524")
    XCTAssertEqual(viewModel.gameData.attempNumber, 1)
    
    let result = viewModel.submit(input: "8924")
    XCTAssertEqual(viewModel.gameData.attempNumber, 0)
    XCTAssertEqual(
      result,
      [
        GameResult(submitValue: "1234", checkResult: .incorrect(hint: "1A1B")),
        GameResult(submitValue: "1524", checkResult: .incorrect(hint: "1A1B")),
        GameResult(submitValue: "1264", checkResult: .incorrect(hint: "1A1B")),
        GameResult(submitValue: "1724", checkResult: .incorrect(hint: "1A1B")),
        GameResult(submitValue: "6524", checkResult: .incorrect(hint: "0A1B")),
        GameResult(submitValue: "8924", checkResult: .incorrect(hint: "1A2B")),
        GameResult(submitValue: "8924", checkResult: .runningOut)
      ]
    )
  }
  
  func testSubmitResult() throws {
    let viewModel = GameViewModel()
    viewModel.resetAnswer("1234")
    
    let result = viewModel.submit(input: "1524")
    XCTAssertEqual(result, [GameResult(submitValue: "1524", checkResult: .incorrect(hint: "2A1B"))])
  }
  
  func testSubmitResult1() throws {
    let viewModel = GameViewModel()
    viewModel.resetAnswer("1234")
    
    let result = viewModel.submit(input: "5678")
    XCTAssertEqual(result, [GameResult(submitValue: "5678", checkResult: .incorrect(hint: "0A0B"))])
  }
  
  func testSubmitResult2() throws {
    let viewModel = GameViewModel()
    viewModel.resetAnswer("1234")
    
    let result = viewModel.submit(input: "5278")
    XCTAssertEqual(result, [GameResult(submitValue: "5278", checkResult: .incorrect(hint: "1A0B"))])
  }
  
  func testSubmitResult3() throws {
    let viewModel = GameViewModel()
    viewModel.resetAnswer("1234")
    
    let result = viewModel.submit(input: "3789")
    print(result)
    XCTAssertEqual(result, [GameResult(submitValue: "3789", checkResult: .incorrect(hint: "0A1B"))])
  }
}
