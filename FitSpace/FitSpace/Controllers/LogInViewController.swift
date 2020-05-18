//
//  LogInViewController.swift
//  FitSpace
//
//  Created by Ibrahim Hussain on 15/01/2020.
//  Copyright © 2020 Ibrahim Hussain. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import IQKeyboardManagerSwift

class LogInViewController: UIViewController {
    
    @IBOutlet weak var emailLoginTF: UITextField!
    
    @IBOutlet weak var passwordLoginTF: UITextField!
    
    @IBOutlet weak var logInButton: UIButton!
   
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var forgotPassButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpElements()
        
    }
    
    func setUpElements() {
        
        //Hide the error label
        errorLabel.alpha = 0
        
        //style elements
        Utilities.styleTextField(emailLoginTF)
        emailLoginTF.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        Utilities.styleTextField(passwordLoginTF)
        passwordLoginTF.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        Utilities.greenStyleFilledButton(logInButton)
        
    }

   
    
    @IBAction func logInTapped(_ sender: Any) {
        
        
        // validate text fields
        
        //create clean versions of text fields
        let email = emailLoginTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordLoginTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                // couldnt sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else {
                /*
                let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "tabBarControl")
                
                self.navigationController?.pushViewController(nextViewController!, animated: true)
 */
                
                
                let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as?
                      UITabBarController
                      
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
    
                
            }
        }
        
        
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        print("Back button pressed")
        
         self.performSegue(withIdentifier: "backHomeSegue", sender: self)
               
    }
    
    
}




