import Foundation
import XCTest

class CompositeElements: BaseScreen {
    // Logout
    lazy var logoutButton = app.windows.navigationBars.buttons["Logout"].firstMatch
    lazy var popupWindow = app.windows.alerts.firstMatch
    private lazy var cancelButton = app.windows.alerts.buttons["Cancel"]
    private lazy var confirmLogoutButton = app.windows.alerts.buttons["Logout"]
    // Cell elements
    private lazy var checkbox = app.windows.tables.cells.images
    // Bottom bar
    lazy var completeAllButton = app.buttons["Complete All"].firstMatch
    private lazy var cancellAllButton = app.buttons["cancel-tasks-bar-button-item"].firstMatch
    lazy var sortByNameButton = app.buttons["sort-tasks-bar-button-item"].firstMatch
    
    func tapConfirmLogoutButton() {
        if logoutButton.exists {
            logoutButton.tap()
            tapAlertPopUpButton(title: LOGOUT_TITLE, button: LOGOUT)
            LoginFormScreen().assertLoginPage()
        }
    }
    
    func tapCancelLogoutButton() {
        logoutButton.tap()
        tapAlertPopUpButton(title: LOGOUT_TITLE, button: CANCEL)
    }
    
    func tapCompleteTask(pos: Int, title : String, state: String) {
        let navigatorCell = app.windows.tables.cells.element(boundBy: pos)
        let navigatorTitle = navigatorCell.children(matching: .staticText).element(matching: .staticText, identifier: title)
        let checkBox = navigatorCell.children(matching: .image).element(matching: .image, identifier: "cell_image_view")
        XCTAssert(navigatorCell.waitForExistence(timeout: 5))
        XCTAssert(navigatorTitle.waitForExistence(timeout: 5))
        navigatorTitle.tap()
        XCTAssertEqual(checkBox.value as! String, state)
    }
    
    func tapCompleteAllButton() {
        XCTAssertTrue(completeAllButton.isEnabled)
        if SleepTasksScreen().backButton.exists {
            for i in 0...3 {
                CompositeElements().assertCellIsSelected(pos: i, title: sleepArray[i], state: NOT_SELECTED)
            }
            completeAllButton.tap()
            for i in 0...3 {
                CompositeElements().assertCellIsSelected(pos: i, title: sleepArray[i], state: SELECTED)
            }
        }
        else {
            for i in 0...4 {
                CompositeElements().assertCellIsSelected(pos: i, title: tasksArray[i], state: NOT_SELECTED)
            }
            completeAllButton.tap()
            for i in 0...4 {
                CompositeElements().assertCellIsSelected(pos: i, title: tasksArray[i], state: SELECTED)
            }
        }
        XCTAssertTrue(cancelButton.isEnabled)
    }
    
    func tapCancelAllButton() {
        XCTAssertTrue(cancelButton.isEnabled)
        if SleepTasksScreen().backButton.exists {
            for i in 0...3 {
                CompositeElements().assertCellIsSelected(pos: i, title: sleepArray[i], state: SELECTED)
            }
            cancellAllButton.tap()
            for i in 0...3 {
                CompositeElements().assertCellIsSelected(pos: i, title: sleepArray[i], state: NOT_SELECTED)
            }
        }
        else {
            for i in 0...4 {
                CompositeElements().assertCellIsSelected(pos: i, title: tasksArray[i], state: SELECTED)
            }
            cancellAllButton.tap()
            for i in 0...4 {
                CompositeElements().assertCellIsSelected(pos: i, title: tasksArray[i], state: NOT_SELECTED)
            }
        }
        XCTAssertTrue(completeAllButton.isEnabled)
    }
    
    func tapSortByNameButton(state: String = NOT_SELECTED) {
        let tasksSorted = tasksArray.sorted()
        let sleepSorted = sleepArray.sorted()
        sortByNameButton.tap()
        if SleepTasksScreen().backButton.exists {
            for i in 0...3 {
                CompositeElements().assertCellIsSelected(pos: i, title: sleepSorted[i], state: state)
            }
        }
        else {
            for i in 0...4 {
                CompositeElements().assertCellIsSelected(pos: i, title: tasksSorted[i], state: state)
            }
        }
    }
    
    func tapAlertPopUpButton(title: String, button: String) {
        let alertButton = popupWindow.buttons[button]
        assertAlert(title: title)
        alertButton.tap()
    }
    
    func assertDefaultSorting() {
        if SleepTasksScreen().backButton.exists {
            for i in 0...3 {
                CompositeElements().assertCellIsSelected(pos: i, title: sleepArray[i], state: NOT_SELECTED)
            }
        }
        else {
            for i in 0...4 {
                CompositeElements().assertCellIsSelected(pos: i, title: tasksArray[i], state: NOT_SELECTED)
            }
        }
    }
    
    func assertToolbarTitle(title: String) {
        let toolbarName = app.navigationBars.staticTexts[title]
        XCTAssert(toolbarName.waitForExistence(timeout: 5))
        XCTAssertEqual(title, toolbarName.label)
    }
    
    func assertAlert(title: String) {
        let alertTitle = popupWindow.staticTexts[title]
        XCTAssert(popupWindow.waitForExistence(timeout: 5))
        XCTAssertTrue(alertTitle.exists)
    }
    
    func assertCellIsSelected(pos: Int, title: String, state: String) {
        let navigatorCell = app.windows.tables.cells.element(boundBy: pos)
        let navigatorTitle = navigatorCell.children(matching: .staticText).element(matching: .staticText, identifier: title)
        let checkBox = navigatorCell.children(matching: .image).element(matching: .image, identifier: "cell_image_view")
        XCTAssert(navigatorCell.waitForExistence(timeout: 5))
        XCTAssert(navigatorTitle.waitForExistence(timeout: 5))
        XCTAssertEqual(checkBox.value as! String, state)
    }
}
