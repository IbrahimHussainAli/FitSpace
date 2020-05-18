//
//  SignUpViewController.swift
//  FitSpace
//
//  Created by Ibrahim Hussain on 15/01/2020.
//  Copyright © 2020 Ibrahim Hussain. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore


class SignUpViewController: UIViewController {
    
    @IBOutlet weak var fullNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements(){
        
        //hide error label
        errorLabel.alpha = 0
        
        //style elements
        
        Utilities.styleTextField(fullNameTextField)
        //change placeholder text colour
        fullNameTextField.attributedPlaceholder = NSAttributedString(string: "Full name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])

        Utilities.styleTextField(emailTextField)
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        Utilities.styleTextField(passwordTextField)
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        Utilities.greenStyleFilledButton(signUpButton)
        
    }

    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise error message.
    func validateFields() -> String? {
        
        // check all fields are filled in
        if fullNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        // check if email is valid
        let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // email isnt valid
        if Utilities.isEmailValid(cleanedEmail) == false {
            return "Please enter a valid email address"
        }
        
        // check if the password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // passwword isn't secure
            return "Please ensure your password is at least 8 characters, contains a special character and a number"
        }
        
        
        return nil
    }
    
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        // validate the fields
        let error = validateFields()
        
        if error != nil {
            
            // theres something wrong with fields, show error message
            showError(error!)
        }
        else{
            
            // create cleaned versions of data
            let fullName = fullNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
        // create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                //check for errors
                if err != nil {
                    //There was an error with user creation
                    self.showError("Error creating user")
                }
                else {
                    
                    //user was created successfully, now store fullname
                    
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["fullname": fullName, "uid": result!.user.uid ]) { (error) in
                        
                        if error != nil {
                            //show error message
                            self.showError("Error saving user data")
                        }
                    }
                    
                    //transition to home screen
                    self.transitionToHome()
                    
                    /*
                    let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "tabBarControl")
                    self.navigationController?.pushViewController(nextViewController!, animated: true)
 */
                    
                }
            }
    }
    
    }
    
    func showError(_ message:String){
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    
    
    func transitionToHome() {
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as?
        UITabBarController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
     }
 
     
     
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        print("Back button pressed")
        
        self.performSegue(withIdentifier: "backHomeSegue", sender: self)
        
        
    }
    
    
}
