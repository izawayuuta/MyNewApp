//
//  CalendarViewController.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/07/02.
//

import Foundation
import FSCalendar
import SwiftUI
import RealmSwift

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calendarHeight: NSLayoutConstraint!
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var calendarDate: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var number01Button: UIButton! // 体調
    @IBOutlet weak var number02Button: UIButton!
    @IBOutlet weak var number03Button: UIButton!
    @IBOutlet weak var number04Button: UIButton!
    @IBOutlet weak var number05Button: UIButton!
    @IBOutlet weak var number1Button: UIButton! // 便の状態
    @IBOutlet weak var number2Button: UIButton!
    @IBOutlet weak var number3Button: UIButton!
    @IBOutlet weak var number4Button: UIButton!
    @IBOutlet weak var number5Button: UIButton!
    @IBOutlet weak var fecesDetail1: UIButton!
    @IBOutlet weak var fecesDetail2: UIButton!
    @IBOutlet weak var fecesDetail3: UIButton!
    @IBOutlet weak var fecesDetail4: UIButton!
    @IBOutlet weak var fecesDetail5: UIButton!
    @IBOutlet weak var fecesDetail6: UIButton!
    @IBOutlet weak var plusButton: UIButton!

    
    var lineViews: [UIView] = []
    var lineViewTopConstraint: NSLayoutConstraint!
    var lineViewBottomConstraint: NSLayoutConstraint!
    private var weekLineConstraints: [NSLayoutConstraint] = []
    private var monthLineConstraints: [NSLayoutConstraint] = []
    
    var isPhysicalConditionSelected: [Bool] = [false, false, false, false, false]
    var isFecesConditionSelected: [Bool] = [false, false, false, false, false]
    var isFecesDetailSelected: [Bool] = [false, false, false, false, false, false]
    var physicalConditionButtons: [UIButton] = []  // 体調のボタン配列
        var fecesConditionButtons: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.delegate = self
        calendar.dataSource = self
        configureCalendar()
        createLines()
        setupPhysicalConditionButtons()
        setupFecesConditionButtons()
        loadSavedScope()
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
        
        // 体調
        let physicalCondition: [UIButton] = [number01Button, number02Button, number03Button, number04Button, number05Button]
        physicalConditionButtons = physicalCondition
        // 便の状態
        let fecesCondition: [UIButton] = [number1Button, number2Button, number3Button, number4Button, number5Button]
        fecesConditionButtons = fecesCondition
        // 便の詳細
        let fecesDetail: [UIButton] = [fecesDetail1, fecesDetail2, fecesDetail3, fecesDetail4, fecesDetail5, fecesDetail6]
        fecesDetailButtons(fecesDetail)
        // プラスボタン
        let plusButton = UIButton()
        self.plusButton(plusButton)
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
    
    // ボタンの装飾
//    func physicalConditionButtons(_ buttons: [UIButton]) {
    private func setupPhysicalConditionButtons() {
            physicalConditionButtons = [number01Button, number02Button, number03Button, number04Button, number05Button]
//            for button in buttons {
        for button in physicalConditionButtons {
                button.setTitleColor(.black, for: .normal)
                button.backgroundColor = .white
                button.tintColor = .black
                button.layer.borderWidth = 0.5
                button.layer.borderColor = UIColor.black.cgColor
                button.layer.cornerRadius = 5.0
                button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            }
        }
//    func fecesConditionButtons(_ buttons: [UIButton]) {
//        for button in buttons {
    // ボタンの装飾
    private func setupFecesConditionButtons() {
           fecesConditionButtons = [number1Button, number2Button, number3Button, number4Button, number5Button]
           
           for button in fecesConditionButtons {
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .white
            button.tintColor = .black
            button.layer.borderWidth = 0.5
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.cornerRadius = 5.0
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }
    }
    // ボタンの装飾
    func fecesDetailButtons(_ buttons: [UIButton]) {
        for button in buttons {
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .white
            button.tintColor = .black
            button.layer.borderWidth = 2.0
            button.layer.borderColor = UIColor(red: 0.23, green: 0.55, blue: 0.35, alpha: 1.0).cgColor
            button.layer.cornerRadius = 5.0
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }
    }
    // ボタンの装飾
    func plusButton(_ button: UIButton) {
        let buttonWidth = self.plusButton.frame.width
        let buttonHeight = self.plusButton.frame.height
        self.plusButton.setTitleColor(.black, for: .normal)
        self.plusButton.backgroundColor = .white
        self.plusButton.tintColor = .black
        self.plusButton.layer.cornerRadius = self.plusButton.frame.height / 2
 
        self.plusButton.layer.shadowColor = UIColor.black.cgColor
        self.plusButton.layer.shadowRadius = 3
        self.plusButton.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        self.plusButton.layer.shadowOpacity = 0.3

        self.plusButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    @objc func buttonTapped(_ sender: UIButton) {
            switch sender {
            case number01Button, number02Button, number03Button, number04Button, number05Button:
                handlePhysicalConditionButtonTap(sender)
            case number1Button, number2Button, number3Button, number4Button, number5Button:
                handleFecesConditionButtonTap(sender)
            case fecesDetail1, fecesDetail2, fecesDetail3, fecesDetail4, fecesDetail5, fecesDetail6:
                handleFecesDetailButtonTap(sender)
            default:
                break
            }
        }
    func handlePhysicalConditionButtonTap(_ button: UIButton) {
            guard let index = getButtonIndex(button, in: [number01Button, number02Button, number03Button, number04Button, number05Button]) else { return }
            
            isPhysicalConditionSelected[index] = !isPhysicalConditionSelected[index]
            
            if isPhysicalConditionSelected[index] {
                // 選択された時の色
                button.backgroundColor = .yellow
            } else {
                // 非選択時の色
                button.backgroundColor = .white
            }
        }
        
        // 便の状態ボタンのタップ処理
        func handleFecesConditionButtonTap(_ button: UIButton) {
            guard let index = getButtonIndex(button, in: [number1Button, number2Button, number3Button, number4Button, number5Button]) else { return }
            
            isFecesConditionSelected[index] = !isFecesConditionSelected[index]
            
            if isFecesConditionSelected[index] {
                // 選択された時の色
                button.backgroundColor = .yellow
            } else {
                // 非選択時の色
                button.backgroundColor = .white
            }
        }
    @objc func PhysicalConditionButtonTap(_ sender: UIButton) {
           // 他のボタンの色を元に戻す
           for button in physicalConditionButtons {
               if button != sender {
                   resetButton(button)
               }
           }
           // 選択されたボタンの色を変更する
           updateButton(sender)
       }
       
       @objc func FecesConditionButtonTap(_ sender: UIButton) {
           // 他のボタンの色を元に戻す
           for button in fecesConditionButtons {
               if button != sender {
                   resetButton(button)
               }
           }
           // 選択されたボタンの色を変更する
           updateButton(sender)
       }
       
       func resetButton(_ button: UIButton) {
           button.backgroundColor = .white
           // 他のデザイン属性も初期化する場合には、ここで行う
       }
       
    func updateButton(_ button: UIButton) {
        button.backgroundColor = UIColor(red: 0.23, green: 0.55, blue: 0.35, alpha: 1.0)
    }
        
        // 便の詳細ボタンのタップ処理
        func handleFecesDetailButtonTap(_ button: UIButton) {
            guard let index = getButtonIndex(button, in: [fecesDetail1, fecesDetail2, fecesDetail3, fecesDetail4, fecesDetail5, fecesDetail6]) else { return }
            
            isFecesDetailSelected[index] = !isFecesDetailSelected[index]
            if isFecesDetailSelected[index] {
                // 選択された時の色
                button.backgroundColor = UIColor(red: 0.23, green: 0.55, blue: 0.35, alpha: 1.0)
            } else {
                // 非選択時の色
                button.backgroundColor = .white
            }
        }
        
    private func getButtonIndex(_ button: UIButton, in array: [UIButton]) -> Int? {
            for (index, btn) in array.enumerated() {
                if btn == button {
                    return index
                }
            }
            return nil
        }
    
    private func createLines() {
        // 線の作成
        let yOffsets: [CGFloat] = [-62, -22, 19, 98]
        
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
        
        let verticalLineView = UIView()
        verticalLineView.backgroundColor = .gray
        verticalLineView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(verticalLineView)
        lineViews.append(verticalLineView)
        
        NSLayoutConstraint.activate([
            verticalLineView.widthAnchor.constraint(equalToConstant: 1), // 線の太さ
            verticalLineView.topAnchor.constraint(equalTo: view.topAnchor, constant: 364), // 上端からの距離
            verticalLineView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -328), // 下端からの距離
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
                weekLineConstraints.append(lineView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: [-212, -173, -133, -51][index]))
            } else {
                // 縦線の位置調整
                weekLineConstraints.append(contentsOf: [
                    lineView.topAnchor.constraint(equalTo: view.topAnchor, constant: 214),
                    lineView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -477)
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
                    lineView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -332)
                ])
                lineView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -114).isActive = true
            }
        }
        
        NSLayoutConstraint.deactivate(weekLineConstraints)
        NSLayoutConstraint.activate(monthLineConstraints)
    }
    private func loadSavedScope() {
            let defaults = UserDefaults.standard
            if let savedScope = defaults.string(forKey: "calendarScope") {
                if savedScope == "month" {
                    setCalendarScope(.month, animated: false)
                } else {
                    setCalendarScope(.week, animated: false)
                }
            } else {
                setCalendarScope(.month, animated: false)
            }
        }
    private func setCalendarScope(_ scope: FSCalendarScope, animated: Bool) {
            calendar.setScope(scope, animated: animated)
            changeButton.setTitle(scope == .month ? "週表示" : "月表示", for: .normal)
            updateLinePositions()
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

