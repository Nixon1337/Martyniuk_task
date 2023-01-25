import Foundation
import XCTest

class LoginFormScreen: BaseScreen {
    
    private lazy var emailField = app.textFields["password-text-field"]
    private lazy var passwordField = app.secureTextFields.firstMatch
    private lazy var loginButton = app.buttons["login-button"]
    private lazy var loginLabel = app.staticTexts["login-label"]
    
    func loginFlow(login: String, pass: String) {
        typeInEmailField(email: login)
        typeInPasswordField(password: pass)
        assertLoginButton(isEnabled: true)
        tapLoginSuccessButton()
        TasksScreen().assertTasksScreen()
    }
    
    func typeInEmailField(email: String) {
        emailField.tap()
        emailField.typeText(email)
        HelperMethods().tapCloseKeyboardButton()
        XCTAssertEqual(emailField.value as! String, email)
    }
    
    func clearTextInEmailField() {
        emailField.tap()
        emailField.clearText()
        HelperMethods().tapCloseKeyboardButton()
        XCTAssertEqual(emailField.value as! String, EMPTY_EMAIL)
    }
    
    func typeInPasswordField(password: String) {
        passwordField.tap()
        passwordField.typeText(password)
        HelperMethods().tapCloseKeyboardButton()
    }
    
    func tapLoginSuccessButton() {
        tapLoginButton()
        XCTAssertTrue(loginLabel.exists)
        if CompositeElements().logoutButton.waitForExistence(timeout: 10) {
            TasksScreen().assertTasksScreen()
        }
        else {
            CompositeElements().tapAlertPopUpButton(title: ERROR_TITLE, button: RETRY)
        }
    }
    
    func tapLoginFailedButton() {
        tapLoginButton()
        if CompositeElements().popupWindow.exists {
            CompositeElements().tapAlertPopUpButton(title: ERROR_TITLE, button: OK)
        }
    }
    
    func assertLoginButton(isEnabled: Bool) {
        XCTAssert(loginButton.isEnabled == isEnabled)
    }
    
    func assertLoginPage() {
        XCTAssertTrue(emailField.isEnabled)
        XCTAssertTrue(passwordField.isEnabled)
        XCTAssertTrue(loginButton.exists)
    }
    
    func assertEmailField(email: String = EMPTY_EMAIL) {
        XCTAssertEqual(emailField.value as! String, email)
    }
    
    func assertPasswordField(password: String = EMPTY_PASSWORD) {
        XCTAssertEqual(passwordField.value as! String, password)
    }
    
    func assertPasswordFieldIsNotEmpty() {
        XCTAssertNotEqual(passwordField.value as! String, EMPTY_PASSWORD)
    }
    
    private func tapLoginButton() {
        XCTAssertTrue(loginButton.waitForExistence(timeout: 5))
        loginButton.tap()
    }
}
