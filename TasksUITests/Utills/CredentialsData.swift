import Foundation

let VALID_LOGIN = "nikolay192003@gmail.com"
let VALID_PASSWORD = "qwerty12345"

let EMPTY_EMAIL = "Email"
let EMPTY_PASSWORD = "Password"

let INVALID_LOGIN = "nikolay192003"
let INVALID_PASSWORD = "h"

let CYRILLIC = "николай@gmail.com"
let WITHOUT_AT_SIGN = "nikolay192003gmail.com"
let WITHOUT_DOT = "nikolay192003@gmailcom"
let WITH_SPECIAL_SYMBOL = "nikolay192003#@gmail.com"
let WITH_SPACE = "nikolay 192003@gmail.com"
let MAIL_DOMAIN = "@gmail.com"

var invalidEmails = [CYRILLIC, WITHOUT_AT_SIGN, WITHOUT_DOT, WITH_SPECIAL_SYMBOL, WITH_SPACE]
