import Foundation
import XCTest

class TasksScreen: BaseScreen {
    
    private lazy var moreInfoSleepButton = app.windows.tables.cells.buttons["More Info"]
    
    func tapOnMoreInfoSleepButton() {
        moreInfoSleepButton.tap()
        CompositeElements().assertToolbarTitle(title: SLEEP_TITLE)
    }
    
    func checkNoTasksAreDoneInTasks() {
        for i in 0...4 {
            CompositeElements().assertCellIsSelected(pos: i, title: tasksArray[i], state: NOT_SELECTED)
        }
    }
    
    func checkAllTasksAreDoneInTasks() {
        for i in 0...4 {
            CompositeElements().assertCellIsSelected(pos: i, title: tasksArray[i], state: SELECTED)
        }
    }
    
    func assertTasksScreen() {
        XCTAssert(moreInfoSleepButton.waitForExistence(timeout: 20))
        CompositeElements().assertToolbarTitle(title: TASKS_TITLE)
        XCTAssert(CompositeElements().logoutButton.isEnabled)
        XCTAssert(CompositeElements().sortByNameButton.isEnabled)
    }
}
