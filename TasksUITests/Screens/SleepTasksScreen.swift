import Foundation
import XCTest

class SleepTasksScreen: BaseScreen {
    
    lazy var backButton = app.windows.navigationBars.buttons[TASKS_TITLE]

    func tapOnBackButton() {
        backButton.tap()
        CompositeElements().assertToolbarTitle(title: TASKS_TITLE)
    }
    
    func checkNoTasksAreDoneInSleep() {
        for i in 0...3 {
            CompositeElements().assertCellIsSelected(pos: i, title: sleepArray[i], state: NOT_SELECTED)
        }
    }
    
    func checkAllTasksAreDoneInSleep() {
        for i in 0...3 {
            CompositeElements().assertCellIsSelected(pos: i, title: sleepArray[i], state: SELECTED)
        }
    }
    
    func assertSleepTasksScreen() {
        XCTAssert(backButton.waitForExistence(timeout: 3))
        CompositeElements().assertToolbarTitle(title: SLEEP_TITLE)
        XCTAssert(CompositeElements().logoutButton.isEnabled)
        XCTAssert(CompositeElements().sortByNameButton.isEnabled)
    }
}
