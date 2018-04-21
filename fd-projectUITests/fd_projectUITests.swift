//
//  fd_projectUITests.swift
//  fd-projectUITests
//
//  Created by Henry Wrightman on 4/17/18.
//  Copyright © 2018 Henry Wrightman. All rights reserved.
//

import XCTest

class fd_projectUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_Gameflow() {
        
        XCTAssertTrue(app.isDisplayingGames)
    }
    
    func test_Statflow() {
        
        app.swipeLeft()
        
        XCTAssertTrue(app.isDisplayingStats)
    }
    
}

extension XCUIApplication {
    var isDisplayingGames: Bool {
        return otherElements["gamesView"].exists
    }
    
    var isDisplayingStats: Bool {
        return otherElements["statsView"].exists
    }
}
