//
//  CalendarDateCell.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/07/11.
//

import UIKit
import FSCalendar
import SwiftUI

class CalendarDateCell: UITableViewCell {
    
    @IBOutlet weak var calendarDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        dateForMatter()
        
        backgroundColor = UIColor(red: 0.4, green: 0.7, blue: 0.4, alpha: 0.9)
    }
    private func dateForMatter() {
        // 日付の初期表示設定（現在の日付）
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateFormat = "yyyy年MM月dd日(EEE)"
        let currentDate = Date()
        let currentDateText = dateFormatter.string(from: currentDate)
        calendarDate.text = currentDateText
    }
    func configure(with date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateFormat = "yyyy年MM月dd日(EEE)"
        let dateString = dateFormatter.string(from: date)
        calendarDate.text = dateString
    }
    //    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
    //        let dateFormatter = DateFormatter()
    //        dateFormatter.dateFormat = "yyyy年MM月dd日"
    //        let selectedDateText = dateFormatter.string(from: date)
    //        calendarDate.text = selectedDateText
    //    }
}
