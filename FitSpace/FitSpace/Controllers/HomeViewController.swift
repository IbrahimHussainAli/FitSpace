//
//  HomeViewController.swift
//  FitSpace
//
//  Created by Ibrahim Hussain on 15/01/2020.
//  Copyright © 2020 Ibrahim Hussain. All rights reserved.
//

import UIKit
import CoreMotion
import MBCircularProgressBar
import FirebaseAuth


class HomeViewController: UIViewController {
    
    var motion = CMPedometer()
    

      
    
    //labels

    @IBOutlet weak var PedLabel: UILabel!
    @IBOutlet weak var DistLabel: UILabel!
    @IBOutlet weak var FloorLabel: UILabel!
    @IBOutlet weak var progressView: MBCircularProgressBarView!
    @IBOutlet weak var goalCount: UILabel!
    @IBOutlet weak var logOutButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //pedometer
        distCount()
        floorCount()
        stepCounter()
        self.progressView.value = 0
        
        // Do any additional setup after loading the view.
    }
    
        override func viewWillAppear(_ animated: Bool) {
            stepCounter()
    }
    
    //logout button
    
    @IBAction func signOutTapped(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            if let storyboard = self.storyboard {
                let vc = storyboard.instantiateViewController(withIdentifier: "viewController") 
                self.present(vc, animated: false, completion: nil)
            }
        } catch let err {
            print("Failed to sign out with error", err)
        }
        
    }
    
    
    //pedometer
    
    @IBAction func stepper(_ sender: UIStepper) {
             goalCount.text = String(sender.value)
        
           self.progressView.maxValue = CGFloat(sender.value)
           stepCounter()
        
    }
 

    let cal = Calendar.current
    
    func stepCounter(){
      let midnight = cal.date(bySettingHour: 00, minute: 00, second: 00, of: Date())!;

        
        if CMPedometer.isStepCountingAvailable(){
                self.motion.startUpdates(from: midnight) { (steps, error) in
                DispatchQueue.main.async{
                
                    self.PedLabel.text = steps?.numberOfSteps.stringValue
                    
                    
                    let pro = (steps?.numberOfSteps.intValue ?? 0)
                    UIView.animate(withDuration: 5.0 ) {
                        
                        self.progressView.value = CGFloat(pro)
                    
                    }
                
        }
    }
    }
    }

    
    //count distance
        
        func distCount(){
            
            let midnight = cal.date(bySettingHour: 00, minute: 00, second: 00, of: Date())!;
            
            if CMPedometer.isDistanceAvailable(){
                
                
                self.motion.startUpdates(from: midnight) { (dist, error) in
                DispatchQueue.main.async {
                    
                    let floatValueDist = dist?.distance?.floatValue

                    self.DistLabel.text = "\(floatValueDist ?? 0)"
                }
            }
        }
    }
    

    //count floorascended
        
    func floorCount() {
        
        let midnight = cal.date(bySettingHour: 00, minute: 00, second: 00, of: Date())!;
        
        if CMPedometer.isFloorCountingAvailable(){
            motion.startUpdates(from: midnight) {( floors, error) in
                DispatchQueue.main.async {
                    self.FloorLabel.text = floors?.floorsAscended?.stringValue
                }
        }

    }
    }
    
        
    }

    
    




   //countSteps
   
   /*
   func stepCounter(){
       
       let midnight = cal.date(bySettingHour: 00, minute: 00, second: 00, of: Date())!;
       
       if CMPedometer.isStepCountingAvailable(){
       motion.queryPedometerData(from: midnight, to: Date()) { (data, error) in
     DispatchQueue.main.async {
       
       self.PedLabel.text =  data?.numberOfSteps.stringValue
       
               }
           }
       }
   else {
       print("Pedometer steps is not available")
       }
       
       
   }
*/
  

   
   
   //count distance
   /*
   func distCount(){
       
       let midnight = cal.date(bySettingHour: 00, minute: 00, second: 00, of: Date())!;
       
       if CMPedometer.isDistanceAvailable(){
       motion.startUpdates(from: midnight) { (dist, error) in
               DispatchQueue.main.async {
                   self.DistLabel.text = dist?.distance?.stringValue
               }
           }
       }
   }
*/
    
