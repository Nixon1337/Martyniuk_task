import Foundation
import XCTest

open class BaseTest: XCTestCase {
    
    lazy var app = BaseScreen().app
    
    open override func setUp() {
        app.launch()
        continueAfterFailure = false
        LoginFormScreen().loginFlow(login: VALID_LOGIN, pass: VALID_PASSWORD)
    }
    
    open override func tearDown() {
        CompositeElements().tapConfirmLogoutButton()
        app.terminate()
    }
}
