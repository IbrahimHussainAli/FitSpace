//
//  ForgotPasswordViewController.swift
//  FitSpace
//
//  Created by Ibrahim Hussain on 03/05/2020.
//  Copyright © 2020 Ibrahim Hussain. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class ForgotPasswordViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
      override func viewDidLoad() {
          super.viewDidLoad()
            setUpElements()

          // Do any additional setup after loading the view.
      }
    
    func setUpElements() {
        
        //Hide error label
        errorLabel.alpha = 0
        
        Utilities.greenStyleFilledButton(resetButton)
        
        Utilities.styleTextField(emailTextField)
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    func validateField() -> String? {
                
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please enter a email address."
        }
        return nil
    }
    
    func showError(_ message:String){
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    @IBAction func resetPasswordDidTapped(_ sender: Any) {
        //validate email
        let error = validateField()
        
        if error != nil {
            showError(error!)
        }
        else {
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
        //send reset password email
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            //error check
         if error != nil
        {

            self.showError("Invalid Email")
        }
         else
        {
            self.errorLabel.textColor = UIColor.green
            self.showError("Email has been sent!")
                        // Success - Sent recovery email
        }
        
}
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
      print("Back button pressed")
        
      self.performSegue(withIdentifier: "backToLogIn", sender: self)    }
    
}
