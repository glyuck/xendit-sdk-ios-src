//
//  Authenticate3DSUITests.swift
//  XenditExampleUITests
//
//  Created by Vladimir Lyukov on 26/10/2018.
//  Copyright © 2018 Xendit. All rights reserved.
//

import XCTest


class Authenticate3DSUITests: BaseTestCase {
    override func setUp() {
        super.setUp()

        app = XCUIApplication()
        app.launch()
    }

    func test3DSAuthentication() {
        let token = getToken()

        homeScreen.authenticate3DSButton.tap()
        authenticate3DSScreen.tokenIDTextField.clearAndEnterText(token)
        authenticate3DSScreen.submitButton.tap()

        waitForElementToAppear(webAuthenticationScreen.titleLabel, timeout: 30)
        webAuthenticationScreen.passwordTextField.tap()
        webAuthenticationScreen.passwordTextField.typeText(TestCards.password3ds)
        webAuthenticationScreen.submitButton.tap()

        waitForElementToAppear(authenticate3DSScreen.successAlert, timeout: 30)
        let text = authenticate3DSScreen.successAlert.alertMessage
        XCTAssert(text.hasPrefix("TokenID - "))
        XCTAssert(text.contains("Status - VERIFIED"))

        authenticate3DSScreen.successAlert.buttons["OK"].tap()
        navBackButton.tap()
    }

    func test3DSAuthentication_InvalidToken() {
        let token = "invalid_token"

        homeScreen.authenticate3DSButton.tap()
        authenticate3DSScreen.tokenIDTextField.clearAndEnterText(token)
        authenticate3DSScreen.submitButton.tap()

        let alert = app.alerts["SERVER_ERROR"]
        waitForElementToAppear(alert, timeout: 30)
        XCTAssertEqual(alert.alertMessage, "Something unexpected happened, we are investigating this issue right now")
        alert.buttons["OK"].tap()
        navBackButton.tap()
    }

    func test3DSAuthentication_InvalidToken2() {
        let token = "5bd59627156a6fe31871512a"

        homeScreen.authenticate3DSButton.tap()
        authenticate3DSScreen.tokenIDTextField.clearAndEnterText(token)
        authenticate3DSScreen.submitButton.tap()

        let alert = app.alerts["TOKEN_NOT_FOUND_ERROR"]
        waitForElementToAppear(alert, timeout: 30)
        XCTAssertEqual(alert.alertMessage, "Credit card token not found")
        alert.buttons["OK"].tap()
        navBackButton.tap()
    }


    fileprivate func getToken() -> String {
        // ==== Step 1: Create token
        homeScreen.createTokenButton.tap()

        // Fill token form
        expectScreenTitle(createTokenScreen.title)
        createTokenScreen.cardNumberTextField.clearAndEnterText(TestCards.validVisa3ds)
        createTokenScreen.multipleUseSwitch.tap()
        createTokenScreen.createTokenButton.tap()

        // Extract token ID
        waitForElementToAppear(createTokenScreen.successAlert, timeout: 60)
        let text = createTokenScreen.successAlert.alertMessage
        createTokenScreen.successAlert.buttons["OK"].tap()
        navBackButton.tap()

        let tokenMatch = matchesWithSubgroups(for: "TokenID - (\\w+)", in: text)
        XCTAssertEqual(tokenMatch.count, 1)
        XCTAssertEqual(tokenMatch.first!.count, 2)

        return tokenMatch.first!.last!
    }
}