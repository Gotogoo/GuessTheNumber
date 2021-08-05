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

    func testSubmit() throws {
      let viewModel = GameViewModel()

      viewModel.start()
      let result = viewModel.submit(input: "1234")
      let inputValue = viewModel.gameData.inputValue!

//      XCTAssertEqual(result, "1A1B")
      XCTAssertEqual(inputValue.count, 4)
      XCTAssertEqual(Set(inputValue).count, 4)
      XCTAssertNotNil(Int(inputValue))
      
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
