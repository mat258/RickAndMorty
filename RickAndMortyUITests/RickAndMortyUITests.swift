//
//  RickAndMortyUITests.swift
//  RickAndMortyUITests
//
//  Created by Matias Valdes on 14/09/2023.
//

import XCTest

final class RickAndMortyUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-UITests"]
        app.launch()
    }
    
    func testAddFavorite() {
        let firstCell = app.collectionViews["characterList"].buttons["characterCell-0"]
        let secondCell = app.collectionViews["characterList"].buttons["characterCell-1"]
        firstCell.tap()
        app.buttons["favoriteButton"].tap()
        app.navigationBars.firstMatch.buttons["Characters"].tap()
        XCTAssertTrue(firstCell.images["favorite"].waitForExistence(timeout: 2))
        XCTAssertFalse(secondCell.images["favorite"].exists)
    }
    
    func testRemoveFavorite() {
        let firstCell = app.collectionViews["characterList"].buttons["characterCell-0"]
        firstCell.tap()
        app.buttons["favoriteButton"].tap()
        app.navigationBars.firstMatch.buttons["Characters"].tap()
        XCTAssertTrue(firstCell.images["favorite"].waitForExistence(timeout: 2))
        firstCell.tap()
        app.buttons["favoriteButton"].tap()
        app.navigationBars.firstMatch.buttons["Characters"].tap()
        XCTAssertTrue(firstCell.images["favorite"].waitForNonExistence(timeout: 2))
    }
    
    func testDetailText() {
        let firstCell = app.collectionViews["characterList"].buttons["characterCell-0"]
        firstCell.tap()
        XCTAssertTrue(app.staticTexts["name"].label == "Earth")
        XCTAssertTrue(app.staticTexts["type"].label == "Type: city")
        XCTAssertTrue(app.staticTexts["dimension"].label == "Dimension: C-137")
    }
}


extension XCUIElement {
    func waitForNonExistence(timeout: TimeInterval) -> Bool {
        let predicate = NSPredicate( format: "exists == FALSE")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: self)
        _ = XCTWaiter.wait(for: [expectation], timeout: timeout)
        return !exists
    }
}
