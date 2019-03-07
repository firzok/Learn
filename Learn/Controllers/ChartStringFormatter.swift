//
//  ChartStringFormatter.swift
//  Learn
//
//  Created by Shiza Siddique on 3/4/19.
//  Copyright © 2019 Mani. All rights reserved.
//

import Foundation
import Charts
class ChartStringFormatter: NSObject, IAxisValueFormatter {
    
    var nameValues: [String]! = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return String(describing: nameValues![Int(value)])
    }
}

