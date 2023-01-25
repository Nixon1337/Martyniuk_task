import Foundation
import XCTest

class TasksTests: BaseTest {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCompleteAllCancelAllTasks() {
        completeAllAndCancelAllFilter()
    }
    
    func testCompleteAllCancelAllSleepTasks() {
        TasksScreen().tapOnMoreInfoSleepButton()
        completeAllAndCancelAllFilter()
    }
    
    func testCheckEachTaskInTasks() {
        TasksScreen().checkNoTasksAreDoneInTasks()
        for i in 0...4 {
            CompositeElements().tapCompleteTask(pos: i, title: tasksArray[i], state: SELECTED)
        }
        TasksScreen().checkAllTasksAreDoneInTasks()
        for i in 0...4 {
            CompositeElements().tapCompleteTask(pos: i, title: tasksArray[i], state: NOT_SELECTED)
        }
        TasksScreen().checkNoTasksAreDoneInTasks()
    }
    
    func testCheckEachTaskInSleep() {
        TasksScreen().tapOnMoreInfoSleepButton()
        SleepTasksScreen().checkNoTasksAreDoneInSleep()
        for i in 0...3 {
            CompositeElements().tapCompleteTask(pos: i, title: tasksArray[i], state: SELECTED)
        }
        SleepTasksScreen().checkAllTasksAreDoneInSleep()
        for i in 0...3 {
            CompositeElements().tapCompleteTask(pos: i, title: tasksArray[i], state: NOT_SELECTED)
        }
        SleepTasksScreen().checkNoTasksAreDoneInSleep()
    }
    
    func testCheckSortByNameInTasks() {
        sortByNameFilter()
    }
    
    func testCheckSortByNameInSleep() {
        TasksScreen().tapOnMoreInfoSleepButton()
        sortByNameFilter()
    }
    
    private func completeAllAndCancelAllFilter() {
        CompositeElements().tapCompleteAllButton()
        CompositeElements().tapCancelAllButton()
    }
    
    private func sortByNameFilter() {
        CompositeElements().assertDefaultSorting()
        CompositeElements().tapSortByNameButton()
    }
}
