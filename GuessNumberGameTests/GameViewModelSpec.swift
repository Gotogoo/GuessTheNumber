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

      viewModel.start()
      
      XCTAssertEqual(viewModel.gameData.answer!.count, 4)
      XCTAssertEqual(Set(viewModel.gameData.answer!).count, 4)
      XCTAssertNotNil(Int(viewModel.gameData.answer!))
    }

    func testSubmitInputErrorValue() throws {
      let viewModel = GameViewModel()

      viewModel.start()
      let errorResult = viewModel.submit(input: "1224")
      XCTAssertEqual(errorResult, "error input value!")
    }
  
  func testSubmitCount() throws {
    let viewModel = GameViewModel()
    
    viewModel.start()
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
    viewModel.gameData.answer = "1234"
    
    viewModel.start()
    let result = viewModel.submit(input: "1524")
    XCTAssertEqual(result, "2A3B")
  }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
