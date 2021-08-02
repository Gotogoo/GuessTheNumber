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

    func testValidationResult() throws {
      var viewModel = GameViewModel()

      viewModel.start()
      let result = viewModel.submit()

      XCTAssertEqual(result, "1A1B")
    }

    func testValidationResult2() throws {
      var viewModel = GameViewModel()

      viewModel.start()
      let result = viewModel.submit()

      XCTAssertEqual(result, "0A1B")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
