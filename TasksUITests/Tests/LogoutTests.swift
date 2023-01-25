import Foundation
import XCTest

class LogoutTests: BaseTest {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testConfirmLogoutFromTasksScreen() {
        CompositeElements().tapConfirmLogoutButton()
    }
    
    func testCancelLogoutFromTasksScreen() {
        CompositeElements().tapCancelLogoutButton()
        TasksScreen().assertTasksScreen()
    }
    
    func testConfirmLogoutFromSleepScreen() {
        TasksScreen().tapOnMoreInfoSleepButton()
        CompositeElements().tapConfirmLogoutButton()
    }
    
    func testCancelLogoutFromSleepScreen() {
        TasksScreen().tapOnMoreInfoSleepButton()
        CompositeElements().tapCancelLogoutButton()
        SleepTasksScreen().assertSleepTasksScreen()
    }
}
