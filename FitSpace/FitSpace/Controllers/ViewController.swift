//
//  ViewController.swift
//  FitSpace
//
//  Created by Ibrahim Hussain on 14/01/2020.
//  Copyright © 2020 Ibrahim Hussain. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var logInButton: UIButton!
    
    let backgroundImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setBackground()
        setUpElements()
        
          }
    
    
    func setBackground() {
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        backgroundImageView.image = UIImage(named: "sage-friedman-TT2J5t1QaMw-unsplash 3")
        view.sendSubviewToBack(backgroundImageView)
    }

    func setUpElements(){
        
        Utilities.greenStyleFilledButton(signUpButton)
        Utilities.greyStyleFilledButton(logInButton)
        
    }

}
