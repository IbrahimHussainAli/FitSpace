//
//  FitSpaceUITests.swift
//  FitSpaceUITests
//
//  Created by Ibrahim Hussain on 17/05/2020.
//  Copyright © 2020 Ibrahim Hussain. All rights reserved.
//

import XCTest

class FitSpaceUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
  
    func testNavigationBar() {
        
        let validEmail = "test@hotmail.com"
        let validPassword = "test123!"
        
        
        let app = XCUIApplication()
        XCUIApplication().launch()
        
        let logInButton = app.buttons["LOG IN"]
        logInButton.tap()
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.typeText(validEmail)
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText(validPassword)
        logInButton.tap()
        
        let reportNavButton = app.tabBars.buttons["Report"]
        
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: reportNavButton, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        reportNavButton.tap()
        
        
        let reportPage = app.staticTexts["Report of the last 7 days"]
        XCTAssertTrue(reportPage.exists)
 
        
    }
    
    
        func testInvalidLogIn_forgottenPasswordErrorIsShown() {
        
        let validEmail = "test@hotmail.com"
        let invalidPassword = "test123"
        
            
            let app = XCUIApplication()
            
            XCUIApplication().launch()
            
            let logInStaticText = app/*@START_MENU_TOKEN@*/.staticTexts["LOG IN"]/*[[".buttons[\"LOG IN\"].staticTexts[\"LOG IN\"]",".staticTexts[\"LOG IN\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
            logInStaticText.tap()
            
           let emailTextField = app.textFields["Email"]
            
            emailTextField.tap()
            emailTextField.typeText(validEmail)
            
            let passwordSecureTextField = app.secureTextFields["Password"]
            passwordSecureTextField.tap()
            
            passwordSecureTextField.typeText(invalidPassword)
        
            logInStaticText.tap()
            
            let errorMessage = app.staticTexts["The password is invalid or the user does not have a password."]
            
            XCTAssertTrue(errorMessage.exists)
            
                
        
    }
      
    func testValidLogInSuccess() {
        
        
        let validEmail = "test@hotmail.com"
        let validPassword = "test123!"
        
        let app = XCUIApplication()
        
        let logInStaticText = app/*@START_MENU_TOKEN@*/.staticTexts["LOG IN"]/*[[".buttons[\"LOG IN\"].staticTexts[\"LOG IN\"]",".staticTexts[\"LOG IN\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        logInStaticText.tap()
        
        let emailTextField = app.textFields["Email"]
        XCTAssertTrue(emailTextField.exists)
        
        emailTextField.tap()
        
        emailTextField.typeText(validEmail)
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordSecureTextField.exists)
        
        passwordSecureTextField.tap()
        
        passwordSecureTextField.typeText(validPassword)
        
        logInStaticText.tap()
        
        let homeView = app.tabBars.buttons["Home"]
        
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: homeView, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
                
    }
    
          

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
