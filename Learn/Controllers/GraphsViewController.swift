//
//  GraphsViewController.swift
//  Learn
//
//  Created by Shiza Siddique on 3/4/19.
//  Copyright © 2019 Mani. All rights reserved.
//

import UIKit
import Charts

//protocol GetChartData{
//    func getChartData(with dataPoints: [String], values: [Double])
//    var workoutDuration : [String] {get set}
//    var beatsPerMinute : [String] {get set}
//}

class GraphsViewController: UIViewController {
    

    
    @IBOutlet weak var lineChartView: LineChartView!
    var days: [String]!

    
    
        override func viewDidLoad() {
            super.viewDidLoad()
    
            days = ["Mon", "Tue", "Wed", "Thur", "Fri", "Sat", "Sun"]
            let timeSpend = [230.0, 400.0, 600.0, 300.0, 920.0, 160.0, 200.0]
    
            setChart(dataPoints: days, values: timeSpend)
        }
    
    
        func setChart(dataPoints: [String], values: [Double]) {
    
    //        var dataEntriesPie = [PieChartDataEntry]()
            var dataEntriesLine = [ChartDataEntry]()
            for i in 0..<dataPoints.count {
                print("i \(days[i])")
                print("values[i] \(values[i])")
    //            let entry = PieChartDataEntry()
    //            entry.y = values[i]
    //            entry.label = days[i]
    
                let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
    
    //            dataEntriesPie.append(entry)
                dataEntriesLine.append(dataEntry)
    
            }
    
    //        let pieChartDataSet = PieChartDataSet(values: dataEntriesPie, label: "Units Sold")
    //        let pieChartData = PieChartData(dataSet: pieChartDataSet)
    //        self.pieChartView.data = pieChartData
    
            //        pieChartView.legend.enabled = true
            //        pieChartView.drawEntryLabelsEnabled = true
    
            //        pieChartView.xAxis.valueFormatter = axisFormatDelegate
    
    //        var colors: [UIColor] = []
    
    //        for _ in 0..<dataPoints.count {
    //            let red = Double(arc4random_uniform(256))
    //            let green = Double(arc4random_uniform(256))
    //            let blue = Double(arc4random_uniform(256))
    //
    //            print("red \(red)")
    //            print("green \(green)")
    //            print("blue \(blue)")
    //
    //            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
    //            //            let color = UIColor(red: 0.8, green: 0.1, blue: 0.5, alpha: 1)
    //            print("color \(color)")
    //            colors.append(color)
    //        }
    //        print("\n")
    //        pieChartDataSet.colors = colors

           
            //setiing Dataset of the graph
            let lineChartDataSet = LineChartDataSet(values: dataEntriesLine, label: "Time Spend Learning")
            lineChartDataSet.valueTextColor = NSUIColor(white: 1, alpha: 1) //points color at each circle
            lineChartDataSet.formSize = CGFloat(20)
    
            
            //setting gradient of the line graph
            let gradientColors = [UIColor.cyan.cgColor, UIColor.clear.cgColor] as CFArray // Colors of the gradient
            let colorLocations:[CGFloat] = [0.5, 0.0] // Positioning of the gradient
            let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) // Gradient Object
            lineChartDataSet.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0) // Set the Gradient
            lineChartDataSet.drawFilledEnabled = true // Draw the Gradient
            lineChartDataSet.valueFont  = NSUIFont.boldSystemFont(ofSize: 15)
    
    
            let lineChartData = LineChartData(dataSet: lineChartDataSet)
            
            //setting x-axis as string values
            let formatter = ChartStringFormatter()
            formatter.nameValues = days
            lineChartView.xAxis.valueFormatter = formatter
            
            lineChartView.xAxis.granularity = 1
            lineChartView.notifyDataSetChanged()
            //        lineChartView.fitScreen()
            lineChartView.data = lineChartData
            
            //animation
            lineChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInSine)
 
            
            //setting up chart's color, font, grid lines
            let xAxis : XAxis = lineChartView.xAxis
            let leftyAxis : YAxis = lineChartView.leftAxis
            let rightyAxis : YAxis = lineChartView.rightAxis
    
            xAxis.labelFont = UIFont(name: "HelveticaNeue", size: 15.0)!
            xAxis.labelTextColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            xAxis.gridColor = .white
            xAxis.axisLineColor = .white
            xAxis.labelPosition = .bottom
            xAxis.drawGridLinesEnabled = false
    
            leftyAxis.labelFont = UIFont(name: "HelveticaNeue", size: 15.0)!
            leftyAxis.labelTextColor = .white
            leftyAxis.axisLineColor = .white
            leftyAxis.gridColor = .white
            leftyAxis.drawLabelsEnabled = true
            leftyAxis.drawGridLinesEnabled = false
    
            rightyAxis.enabled = false
            rightyAxis.drawAxisLineEnabled = false
    
    
            //setting legend's font and color
            let legend = lineChartView.legend
            legend.font = UIFont(name: "HelveticaNeue", size: 16.0)!
            legend.textColor = .white
    
    
        }
    
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}


