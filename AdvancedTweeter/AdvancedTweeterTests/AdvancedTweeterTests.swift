//
//  AdvancedTweeterTests.swift
//  AdvancedTweeterTests
//
//  Created by Samuel Tse on 14/4/19.
//  Copyright © 2019 Samuel Tse. All rights reserved.
//

import XCTest
@testable import AdvancedTweeter

class AdvancedTweeterTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMessageSpliter() {
        
        let message = "I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself."
        let testResult = Service.shared.processMessage(message)
        for i in 0..<testResult.count {
                XCTAssertLessThan(testResult[i].count, 51 )
        }
    }

    func testMessageError() {
        
        let message = "I can't believeeeeeeeeeeeeeeeeeeeTweeternowsupportschunkingggggggggggggggggggg my messages, so I don't have to do it myself."
        let testResult = Service.shared.processMessage(message)
        XCTAssertEqual(testResult[0], "ERROR")
    }

}
