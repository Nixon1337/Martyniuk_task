import Foundation
import XCTest

class DataConditionsTests: BaseTest {
    
    override func setUp() {
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testReloginViaSameAccount() {
        LoginFormScreen().loginFlow(login: VALID_LOGIN, pass: VALID_PASSWORD)
        for i in 0...2 {
            CompositeElements().tapCompleteTask(pos: i, title: tasksArray[i], state: SELECTED)
        }
        CompositeElements().tapConfirmLogoutButton()
        LoginFormScreen().loginFlow(login: VALID_LOGIN, pass: VALID_PASSWORD)
        for i in 0...2 {
            CompositeElements().assertCellIsSelected(pos: i, title: tasksArray[i], state: SELECTED)
        }
    }
    
    func testBackgroundForegroundEveryScreen() {
        LoginFormScreen().typeInPasswordField(password: VALID_PASSWORD)
        LoginFormScreen().typeInEmailField(email: VALID_LOGIN)
        HelperMethods().putAppInBackgroundAndReopen()
        LoginFormScreen().assertEmailField(email: VALID_LOGIN)
        LoginFormScreen().assertPasswordFieldIsNotEmpty()
        LoginFormScreen().tapLoginSuccessButton()
        TasksScreen().assertTasksScreen()
        for i in 0...1 {
            CompositeElements().tapCompleteTask(pos: i, title: tasksArray[i], state: SELECTED)
        }
        HelperMethods().putAppInBackgroundAndReopen()
        for i in 0...1 {
            CompositeElements().assertCellIsSelected(pos: i, title: tasksArray[i], state: SELECTED)
        }
        TasksScreen().tapOnMoreInfoSleepButton()
        for i in 0...1 {
            CompositeElements().tapCompleteTask(pos: i, title: sleepArray[i], state: SELECTED)
        }
        HelperMethods().putAppInBackgroundAndReopen()
        for i in 0...1 {
            CompositeElements().assertCellIsSelected(pos: i, title: sleepArray[i], state: SELECTED)
        }
    }
    
    func testKillAppAndReopenEveryScreen() {
        LoginFormScreen().typeInEmailField(email: VALID_LOGIN)
        LoginFormScreen().typeInPasswordField(password: VALID_PASSWORD)
        HelperMethods().killAppAndReopen()
        LoginFormScreen().assertEmailField()
        LoginFormScreen().assertPasswordField()
        LoginFormScreen().loginFlow(login: VALID_LOGIN, pass: VALID_PASSWORD)
        for i in 0...1 {
            CompositeElements().tapCompleteTask(pos: i, title: tasksArray[i], state: SELECTED)
        }
        HelperMethods().killAppAndReopen()
        for i in 0...1 {
            CompositeElements().assertCellIsSelected(pos: i, title: tasksArray[i], state: SELECTED)
        }
        TasksScreen().tapOnMoreInfoSleepButton()
        for i in 0...1 {
            CompositeElements().tapCompleteTask(pos: i, title: sleepArray[i], state: SELECTED)
        }
        HelperMethods().killAppAndReopen()
        TasksScreen().tapOnMoreInfoSleepButton()
        for i in 0...1 {
            CompositeElements().assertCellIsSelected(pos: i, title: sleepArray[i], state: SELECTED)
        }
    }
    
    func testCheckSwipeUpAndSwipeDown() {
        LoginFormScreen().loginFlow(login: VALID_LOGIN, pass: VALID_PASSWORD)
        for i in 0...1 {
            CompositeElements().tapCompleteTask(pos: i, title: tasksArray[i], state: SELECTED)
        }
        HelperMethods().swipeTheScreenUp()
        for i in 0...1 {
            CompositeElements().assertCellIsSelected(pos: i, title: tasksArray[i], state: SELECTED)
        }
        HelperMethods().swipeTheScreenDown()
        for i in 0...1 {
            CompositeElements().assertCellIsSelected(pos: i, title: tasksArray[i], state: SELECTED)
        }
        TasksScreen().tapOnMoreInfoSleepButton()
        for i in 0...1 {
            CompositeElements().tapCompleteTask(pos: i, title: sleepArray[i], state: SELECTED)
        }
        HelperMethods().swipeTheScreenUp()
        for i in 0...1 {
            CompositeElements().assertCellIsSelected(pos: i, title: sleepArray[i], state: SELECTED)
        }
        HelperMethods().swipeTheScreenDown()
        for i in 0...1 {
            CompositeElements().assertCellIsSelected(pos: i, title: sleepArray[i], state: SELECTED)
        }
    }
    
    func testTransfersBeetwenScreens() {
        LoginFormScreen().loginFlow(login: VALID_LOGIN, pass: VALID_PASSWORD)
        TasksScreen().checkNoTasksAreDoneInTasks()
        TasksScreen().tapOnMoreInfoSleepButton()
        SleepTasksScreen().assertSleepTasksScreen()
        SleepTasksScreen().checkNoTasksAreDoneInSleep()
        for i in 2...3 {
            CompositeElements().tapCompleteTask(pos: i, title: sleepArray[i], state: SELECTED)
        }
        for i in 0...1 {
            CompositeElements().assertCellIsSelected(pos: i, title: tasksArray[i], state: NOT_SELECTED)
        }
        SleepTasksScreen().tapOnBackButton()
        TasksScreen().assertTasksScreen()
        TasksScreen().checkNoTasksAreDoneInTasks()
        for i in 3...4 {
            CompositeElements().tapCompleteTask(pos: i, title: tasksArray[i], state: SELECTED)
        }
        for i in 0...2 {
            CompositeElements().assertCellIsSelected(pos: i, title: tasksArray[i], state: NOT_SELECTED)
        }
        TasksScreen().tapOnMoreInfoSleepButton()
        SleepTasksScreen().assertSleepTasksScreen()
        for i in 2...3 {
            CompositeElements().assertCellIsSelected(pos: i, title: sleepArray[i], state: SELECTED)
        }
        for i in 0...1 {
            CompositeElements().assertCellIsSelected(pos: i, title: tasksArray[i], state: NOT_SELECTED)
        }
        SleepTasksScreen().tapOnBackButton()
        TasksScreen().assertTasksScreen()
        for i in 3...4 {
            CompositeElements().assertCellIsSelected(pos: i, title: tasksArray[i], state: SELECTED)
        }
        for i in 0...2 {
            CompositeElements().assertCellIsSelected(pos: i, title: tasksArray[i], state: NOT_SELECTED)
        }
    }
}
