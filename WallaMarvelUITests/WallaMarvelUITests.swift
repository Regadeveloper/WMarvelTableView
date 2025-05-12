import XCTest

class WallaMarvelUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false

        let app = XCUIApplication()
        app.launchArguments.append("UI-TESTING")
        app.launch()
    }

    func testHeroCellIsTappable() {
        let app = XCUIApplication()
        let heroCell = app.tables.cells["A-Bomb (HAS) Cell"].firstMatch
        XCTAssertTrue(heroCell.waitForExistence(timeout: 2), "Can't find hero cell for A-Bomb (HAS)")
        heroCell.tap()
        let heroDetailDescription = app.staticTexts.containing(NSPredicate(format: "label CONTAINS %@", "Rick Jones")).firstMatch
        XCTAssertTrue(heroDetailDescription.waitForExistence(timeout: 2))
    }
}
