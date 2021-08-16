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
      XCTAssertEqual(errorResult, "error input value!")
    }
  
  func testSubmitCount() throws {
    let viewModel = GameViewModel()
    viewModel.resetAnswer("1982")
    
    let resultOne = viewModel.submit(input: "1234")
    let resultTwo = viewModel.submit(input: "1524")
    let resultThree = viewModel.submit(input: "1264")
    let resultFour = viewModel.submit(input: "1724")
    let resultFive = viewModel.submit(input: "6524")
    let resultSix = viewModel.submit(input: "8924")
    
    XCTAssertEqual(resultSix, "game failure!")
  }
  
  func testSubmitResult() throws {
    let viewModel = GameViewModel()
    viewModel.resetAnswer("1234")
    
    let result = viewModel.submit(input: "1524")
    XCTAssertEqual(result, "2A1B")
  }
  
  func testSubmitResult1() throws {
    let viewModel = GameViewModel()
    viewModel.resetAnswer("1234")
    
    let result = viewModel.submit(input: "5678")
    XCTAssertEqual(result, "0A0B")
  }
  
  func testSubmitResult2() throws {
    let viewModel = GameViewModel()
    viewModel.resetAnswer("1234")
    
    let result = viewModel.submit(input: "5278")
    XCTAssertEqual(result, "1A0B")
  }
  
  func testSubmitResult3() throws {
    let viewModel = GameViewModel()
    viewModel.resetAnswer("1234")
    
    let result = viewModel.submit(input: "3789")
    XCTAssertEqual(result, "0A1B")
  }
}
