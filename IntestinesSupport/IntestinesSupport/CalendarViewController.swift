//
//  CalendarViewController.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/07/02.
//

import Foundation
import FSCalendar
import SwiftUI

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calendarHeight: NSLayoutConstraint!
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var calendarDate: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var lineViews: [UIView] = []
    var lineViewTopConstraint: NSLayoutConstraint!
    var lineViewBottomConstraint: NSLayoutConstraint!
    private var weekLineConstraints: [NSLayoutConstraint] = []
        private var monthLineConstraints: [NSLayoutConstraint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.delegate = self
        calendar.dataSource = self
        configureCalendar()
        createLines()
        
        // 画面を閉じた時の表示を再度表示
        let defaults = UserDefaults.standard
        if let savedScope = defaults.string(forKey: "calendarScope") {
            if savedScope == "month" {
                calendar.setScope(.month, animated: false)
                changeButton.setTitle("週表示", for: .normal)
            } else {
                calendar.setScope(.week, animated: false)
                changeButton.setTitle("月表示", for: .normal)
            }
        } else {
            // デフォルトの表示形式を月表示に設定
            calendar.setScope(.month, animated: false)
            changeButton.setTitle("週表示", for: .normal)
        }
        // 日付の初期表示設定（現在の日付）
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        let currentDate = Date()
        let currentDateText = dateFormatter.string(from: currentDate)
        calendarDate.text = currentDateText
        
    }
    
    private func configureCalendar() {
        // ヘッダーの日付フォーマットを変更
        calendar.appearance.headerDateFormat = "yyyy年MM月"
        // 曜日と今日の色を指定
        calendar.appearance.todayColor = .orange
        calendar.appearance.headerTitleColor = .orange
        calendar.appearance.weekdayTextColor = .black
        // 曜日表示内容を変更
        calendar.calendarWeekdayView.weekdayLabels[0].text = "日"
        calendar.calendarWeekdayView.weekdayLabels[1].text = "月"
        calendar.calendarWeekdayView.weekdayLabels[2].text = "火"
        calendar.calendarWeekdayView.weekdayLabels[3].text = "水"
        calendar.calendarWeekdayView.weekdayLabels[4].text = "木"
        calendar.calendarWeekdayView.weekdayLabels[5].text = "金"
        calendar.calendarWeekdayView.weekdayLabels[6].text = "土"
        // 土日の色を変更
        calendar.calendarWeekdayView.weekdayLabels[0].textColor = .red
        calendar.calendarWeekdayView.weekdayLabels[6].textColor = .blue
    }
    
    private func createLines() {
        // 線の作成
        let yOffsets: [CGFloat] = [-61, -23, 19, 96]
        
        for yOffset in yOffsets {
            let lineView = UIView()
            lineView.backgroundColor = .gray
            lineView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(lineView)
            lineViews.append(lineView)
            
            NSLayoutConstraint.activate([
                lineView.heightAnchor.constraint(equalToConstant: 1), // 線の太さ
                lineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0), // 左端からの距離
                lineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0), // 右端からの距離
                lineView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yOffset) // 垂直位置
            ])
        }
        
        // 縦線の作成
        
        let topAnchor: CGFloat = 365
        let bottomAnchor: CGFloat = -330
        let verticalLineView = UIView()
        verticalLineView.backgroundColor = .gray
        verticalLineView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(verticalLineView)
        lineViews.append(verticalLineView)
        
        NSLayoutConstraint.activate([
            verticalLineView.widthAnchor.constraint(equalToConstant: 1), // 線の太さ
            verticalLineView.topAnchor.constraint(equalTo: view.topAnchor, constant: topAnchor), // 上端からの距離
            verticalLineView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomAnchor), // 下端からの距離
            verticalLineView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -114) // 水平位置
        ])
    }
    private func updateLinePositions() {
            // 週表示と月表示の線の位置調整
            if calendar.scope == .week {
                applyWeekConstraints()
            } else {
                applyMonthConstraints()
            }
        }
        
        private func applyWeekConstraints() {
            // 週表示の場合の線の位置設定
            for (index, lineView) in lineViews.enumerated() {
                if index < 4 {
                    // 横線の位置調整
                    weekLineConstraints.append(lineView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: [-212, -174, -133, -53][index]))
                } else {
                    // 縦線の位置調整
                    weekLineConstraints.append(contentsOf: [
                        lineView.topAnchor.constraint(equalTo: view.topAnchor, constant: 214),
                        lineView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -479)
                    ])
                    lineView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -114).isActive = true
                }
            }
            
            NSLayoutConstraint.deactivate(monthLineConstraints)
            NSLayoutConstraint.activate(weekLineConstraints)
        }

        private func applyMonthConstraints() {
            // 月表示の場合の線の位置設定
            for (index, lineView) in lineViews.enumerated() {
                if index < 4 {
                    // 横線の位置調整
                    monthLineConstraints.append(lineView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: [-61, -23, 19, 96][index]))
                } else {
                    // 縦線の位置調整
                    monthLineConstraints.append(contentsOf: [
                        lineView.topAnchor.constraint(equalTo: view.topAnchor, constant: 365),
                        lineView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -330)
                    ])
                    lineView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -114).isActive = true
                }
            }
            
            NSLayoutConstraint.deactivate(weekLineConstraints)
            NSLayoutConstraint.activate(monthLineConstraints)
        }
    
    // calendarの表示形式変更
    @IBAction func changeButtonAction(_ sender: Any) {
        if calendar.scope == .month {
            calendar.setScope(.week, animated: true)
            changeButton.setTitle("月表示", for: .normal)
            saveCalendarScope(scope: .week)
        } else if calendar.scope == .week {
            calendar.setScope(.month, animated: true)
            changeButton.setTitle("週表示", for: .normal)
            saveCalendarScope(scope: .month)
        }
        updateLinePositions()
        calendar.reloadData()
    }
    private func saveCalendarScope(scope: FSCalendarScope) {
        let defaults = UserDefaults.standard
        defaults.set(scope == .month ? "month" : "week", forKey: "calendarScope")
    }
}
extension CalendarViewController {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // 日付が選択されたときの処理
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        let selectedDateText = dateFormatter.string(from: date)
        calendarDate.text = selectedDateText
    }
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeight.constant = bounds.height
        self.view.layoutIfNeeded()
    }
}


extension CalendarViewController {
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        let weekday = Calendar.current.component(.weekday, from: date)
        
        // 土曜を青、日曜を赤
        if weekday == 7 {
            return .blue
        } else if weekday == 1 {
            return .red
        }
        return nil
    }
}

