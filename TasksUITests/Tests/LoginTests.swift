import Foundation
import XCTest

class LoginTests: BaseTest {
    
    override func setUp() {
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCheckValidCredentials() {
        LoginFormScreen().typeInEmailField(email: VALID_LOGIN)
        LoginFormScreen().typeInPasswordField(password: VALID_PASSWORD)
        LoginFormScreen().assertLoginButton(isEnabled: true)
        LoginFormScreen().tapLoginSuccessButton()
        TasksScreen().assertTasksScreen()
    }
    
    func testEmptyFields() {
        LoginFormScreen().assertEmailField()
        LoginFormScreen().assertPasswordField()
        LoginFormScreen().assertLoginButton(isEnabled: false)
        LoginFormScreen().typeInEmailField(email: VALID_LOGIN)
        LoginFormScreen().assertLoginButton(isEnabled: false)
        LoginFormScreen().tapLoginFailedButton()
        LoginFormScreen().assertLoginPage()
        LoginFormScreen().clearTextInEmailField()
        LoginFormScreen().typeInPasswordField(password: VALID_PASSWORD)
        LoginFormScreen().assertLoginButton(isEnabled: false)
        LoginFormScreen().tapLoginFailedButton()
        LoginFormScreen().assertLoginPage()
    }
    
    func testLoginWithInvalidCredentials() {
        LoginFormScreen().typeInEmailField(email: INVALID_LOGIN)
        LoginFormScreen().typeInPasswordField(password: INVALID_PASSWORD)
        LoginFormScreen().assertLoginButton(isEnabled: true)
        LoginFormScreen().tapLoginFailedButton()
        LoginFormScreen().assertLoginPage()
    }
    
    func testInvalidCredentialsInEmailField() {
        LoginFormScreen().typeInPasswordField(password: VALID_PASSWORD)
        for email in invalidEmails {
            LoginFormScreen().typeInEmailField(email: email)
            LoginFormScreen().assertLoginButton(isEnabled: true)
            LoginFormScreen().tapLoginFailedButton()
            LoginFormScreen().assertLoginPage()
            LoginFormScreen().clearTextInEmailField()
        }
    }
    
    func testLoginGreatDealOfCharactares() {
        LoginFormScreen().typeInEmailField(email: HelperMethods().randomText(length: 500) + MAIL_DOMAIN)
        LoginFormScreen().typeInPasswordField(password: HelperMethods().randomText(length: 500))
        LoginFormScreen().assertLoginButton(isEnabled: true)
        LoginFormScreen().tapLoginFailedButton()
        LoginFormScreen().assertLoginPage()
    }
}
