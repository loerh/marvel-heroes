//
//  marvel_heroesUITests.swift
//  marvel-heroesUITests
//
//  Created by Laurent Meert on 08/05/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import XCTest

class MarvelHeroesUITests: XCTestCase {
        
    private var application: XCUIApplication?
    
    private var app: XCUIApplication {
        
        if let app = application {
            return app
        }
        
        let newApp = XCUIApplication()
        application = newApp
        return newApp
    }
    
    override func setUp() {
        super.setUp()
        
        // stop immediately when a failure occurs
        continueAfterFailure = false
        // Launch the application that they test
        app.launch()
    }
    
    func testElementsPresentInTableView() {
        let predicate = NSPredicate(format: "count > 0")
        let expect = expectation(for: predicate, evaluatedWith: app.cells, handler: nil)
        wait(for: [expect], timeout: 10)
    }
    
    func testTableViewScrollable() {
        app.tables.firstMatch.swipeUp()
        app.tables.firstMatch.swipeUp()
    }
    
    func testSearchNoResults() {
        
        search(text: "difjwuyah")
        XCTAssert(app.cells.count == 0)
    }
    
    func testCancelSearch() {
        search(text: "difjwuyah", keepActive: true)
        XCTAssert(app.cells.count == 0)
        app.buttons["Cancel"].tap()
        XCTAssert(app.cells.count > 0)
    }
    
    func testTableViewSelection() {
        
        app.cells.firstMatch.tap()
        let predicate = NSPredicate(format: "exists == 1")
        
        let detailImageView = app.images["detailImageView"]
        let detailTitleLabel = app.staticTexts["detailTitleLabel"]
        let detailDescriptionLabel = app.staticTexts["detailDescriptionLabel"]
        
        expectation(for: predicate, evaluatedWith: detailImageView, handler: nil)
        expectation(for: predicate, evaluatedWith: detailTitleLabel, handler: nil)
        expectation(for: predicate, evaluatedWith: detailDescriptionLabel, handler: nil)

        waitForExpectations(timeout: 10, handler: nil)
    }
    
    private func search(text: String, keepActive: Bool = false) {
        let searchMoviesSearchField = app.searchFields.firstMatch
        searchMoviesSearchField.tap()
        searchMoviesSearchField.typeText(text)
        if !keepActive {
            app.buttons["Done"].tap()
        }
    }
    
}
