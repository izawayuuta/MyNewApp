//
//  GrapfDataTitleFormatter.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/10/17.
//

import Foundation
import Charts

class GraphDataTitleFormatter: AxisValueFormatter {
    var dateList: [Date] = []
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let index = Int(value)
        guard dateList.count > index else { return "" }
        let targetDate = dateList[index]
        let formatter = DateFormatter()
        let dateFormatString = "M/d"
        formatter.dateFormat = dateFormatString
        return formatter.string(from: targetDate)
    }
}
