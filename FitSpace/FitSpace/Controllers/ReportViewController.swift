//
//  ReportViewController.swift
//  FitSpace
//
//  Created by Ibrahim Hussain on 13/05/2020.
//  Copyright © 2020 Ibrahim Hussain. All rights reserved.
//

import Foundation
import UIKit
import Charts
import CoreMotion


class ReportViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var chartView: BarChartView!
    
      var days:[String] = []
      var stepsTaken:[Int] = []
      let activityManager = CMMotionActivityManager()
      let pedoMeter = CMPedometer()
    
        var cnt = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        chartView.delegate = self;
        
        chartView.noDataText = "Data will be loaded soon."
        
        chartView.drawBarShadowEnabled = false
        chartView.drawValueAboveBarEnabled = true
        
        
        chartView.maxVisibleCount = 60
        chartView.pinchZoomEnabled = false
        chartView.drawGridBackgroundEnabled = true
        chartView.drawBordersEnabled = false

        
        getDataForLastWeek()
    }
    
    func getDataForLastWeek(){
        
        if CMPedometer.isStepCountingAvailable(){
            let serialQueue : DispatchQueue = DispatchQueue(__label: "report.MyQueue", attr: nil)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "d MM"
            serialQueue.sync(execute: { () -> Void in
                //let today = Date()
                for day in 0...6{
                    let fromDate = Date(timeIntervalSinceNow: Double(-7+day) * 86400)
                    let toDate = Date(timeIntervalSinceNow: Double(-7+day+1) * 86400)
                    let dtStr = formatter.string(from: toDate)
                    self.pedoMeter.queryPedometerData(from: fromDate, to: toDate) { (data : CMPedometerData!, error) -> Void in
                    if(error == nil){
                        print("\(dtStr) : \(data.numberOfSteps)")
                        self.days.append(dtStr)
                        self.stepsTaken.append(Int(truncating: data.numberOfSteps))
                        print("Days : \(self.days)")
                        if(self.days.count == 7) {
                            DispatchQueue.main.sync {
                                //let xVals = self.days
                                var yVals: [BarChartDataEntry] = []
                                for idx in 0...6 {
                                    yVals.append(BarChartDataEntry(x: Double(idx), y: Double(self.stepsTaken[idx])))
                                    //((BarChartDataEntry(x: Double(idx), yValues: (self.stepsTaken[idx]))))
                                }
                                
                                let set1 = BarChartDataSet(entries: yVals, label: "Steps Taken")
                                set1.barBorderWidth = 0.25
                                set1.valueColors = .init(arrayLiteral: .black)
                                
                                
                                let data = BarChartData(dataSet: set1)
                                
                                self.chartView.data = data
                                self.view.reloadInputViews()
                                
                            }
                        }
                        }
                
            }
            
        }
        
        
    }
        )}
    }
    
}
