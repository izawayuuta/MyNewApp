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

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance, UITableViewDelegate, UITableViewDataSource, FecesDetailCellDelegate, CalendarViewControllerDelegate {
    
    
    
    var tableViewCell: [String] = []
    var selectedDate: Date? // 選択された日付を保持するプロパティ
    private var calendarDataModel: [CalendarDataModel] = []
    weak var delegate: CalendarViewControllerDelegate?
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calendarHeight: NSLayoutConstraint!
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CalendarDateCell", bundle: nil), forCellReuseIdentifier: "CalendarDateCell")
        tableView.register(UINib(nibName: "PhysicalConditionCell", bundle: nil), forCellReuseIdentifier: "PhysicalConditionCell")
        tableView.register(UINib(nibName: "FecesConditionCell", bundle: nil), forCellReuseIdentifier: "FecesConditionCell")
        tableView.register(UINib(nibName: "FecesDetailCell", bundle: nil), forCellReuseIdentifier: "FecesDetailCell")
        tableView.register(UINib(nibName: "AdditionButtonCell", bundle: nil), forCellReuseIdentifier: "AdditionButtonCell")
        tableView.register(UINib(nibName: "MedicineEmptyStateCell", bundle: nil), forCellReuseIdentifier: "MedicineEmptyStateCell")
        tableView.register(UINib(nibName: "MedicineRecordDetailCell", bundle: nil), forCellReuseIdentifier: "MedicineRecordDetailCell")
        tableView.register(UINib(nibName: "MemoCell", bundle: nil), forCellReuseIdentifier: "MemoCell")
        
        
        calendar.delegate = self
        calendar.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        configureCalendar()
        selectedDate = Date()
        tableViewCell = ["CalendarDateCell", "PhysicalConditionCell", "FecesConditionCell", "FecesDetailCell", "AdditionButtonCell", "MedicineEmptyStateCell", "MedicineRecordDetailCell", "MemoCell"]
        tableView.reloadData()
        
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
        tableView.separatorColor = UIColor.black
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        loadCalendars()
    } // viewDidLoad終わり
    func loadCalendars() {
        let realm = try! Realm()
        let calendars = realm.objects(CalendarDataModel.self)
        calendarDataModel = Array(calendars)
    }
    private func configureCalendar() {
        // ヘッダーの日付フォーマットを変更
        calendar.appearance.headerDateFormat = "yyyy年MM月"
        // 曜日と今日の色を指定
        calendar.appearance.todayColor = UIColor(red: 0.2, green: 0.7, blue: 0.5, alpha: 1.0)
        calendar.appearance.headerTitleColor = UIColor(red: 0.2, green: 0.7, blue: 0.5, alpha: 1.0)
        
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
    // calendarの表示形式変更
    @IBAction func changeButtonAction(_ sender: Any) {
        if calendar.scope == .month {
            calendar.setScope(.week, animated: true)
            changeButton.setTitle("月表示", for: .normal)
            saveCalendarScope(scope: .week)
            calendar.reloadData()
        } else if calendar.scope == .week {
            calendar.setScope(.month, animated: true)
            changeButton.setTitle("週表示", for: .normal)
            saveCalendarScope(scope: .month)
            calendar.reloadData()
        }
    }
    
    
    private func saveCalendarScope(scope: FSCalendarScope) {
        let defaults = UserDefaults.standard
        defaults.set(scope == .month ? "month" : "week", forKey: "calendarScope")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewCell.count
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDate = date
        tableViewCell = ["CalendarDateCell", "PhysicalConditionCell", "FecesConditionCell", "FecesDetailCell", "AdditionButtonCell", "MedicineEmptyStateCell", "MedicineRecordDetailCell", "MemoCell"]
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = tableViewCell[indexPath.row]
        
        if identifier == "CalendarDateCell" {
            let calendarCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CalendarDateCell
            if let date = selectedDate {
                calendarCell.configure(with: date)
            }
            return calendarCell
        } else if identifier == "PhysicalConditionCell" {
            let physicalConditionCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! PhysicalConditionCell
            if indexPath.row < calendarDataModel.count {
                let data = calendarDataModel[indexPath.row]
                physicalConditionCell.number01Button.tag = data.number01Button
                physicalConditionCell.number02Button.tag = data.number02Button
                physicalConditionCell.number03Button.tag = data.number03Button
                physicalConditionCell.number04Button.tag = data.number04Button
                physicalConditionCell.number05Button.tag = data.number05Button
                
                physicalConditionCell.number01Button.setTitle(String(data.number01Button), for: .normal)
                physicalConditionCell.number02Button.setTitle(String(data.number02Button), for: .normal)
                physicalConditionCell.number03Button.setTitle(String(data.number03Button), for: .normal)
                physicalConditionCell.number04Button.setTitle(String(data.number04Button), for: .normal)
                physicalConditionCell.number05Button.setTitle(String(data.number05Button), for: .normal)
            }
            return physicalConditionCell
        } else if identifier == "FecesConditionCell" {
            let fecesConditionCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! FecesConditionCell
            if indexPath.row < calendarDataModel.count {
                let data = calendarDataModel[indexPath.row]
                fecesConditionCell.number1Button.tag = data.number1Button
                fecesConditionCell.number2Button.tag = data.number2Button
                fecesConditionCell.number3Button.tag = data.number3Button
                fecesConditionCell.number4Button.tag = data.number4Button
                fecesConditionCell.number5Button.tag = data.number5Button
                
                fecesConditionCell.number1Button.setTitle(String(data.number1Button), for: .normal)
                fecesConditionCell.number2Button.setTitle(String(data.number2Button), for: .normal)
                fecesConditionCell.number3Button.setTitle(String(data.number3Button), for: .normal)
                fecesConditionCell.number4Button.setTitle(String(data.number4Button), for: .normal)
                fecesConditionCell.number5Button.setTitle(String(data.number5Button), for: .normal)
            }
            return fecesConditionCell
        } else if identifier == "FecesDetailCell" {
            let fecesDetailCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! FecesDetailCell
            if indexPath.row < calendarDataModel.count {
                let data = calendarDataModel[indexPath.row]
                fecesDetailCell.fecesDetail1.tag = data.fecesDetail1
                fecesDetailCell.fecesDetail2.tag = data.fecesDetail2
                fecesDetailCell.fecesDetail3.tag = data.fecesDetail3
                fecesDetailCell.fecesDetail4.tag = data.fecesDetail4
                fecesDetailCell.fecesDetail5.tag = data.fecesDetail5
                fecesDetailCell.fecesDetail6.tag = data.fecesDetail6
                
                fecesDetailCell.fecesDetail1.setTitle(String(data.fecesDetail1), for: .normal)
                fecesDetailCell.fecesDetail2.setTitle(String(data.fecesDetail2), for: .normal)
                fecesDetailCell.fecesDetail3.setTitle(String(data.fecesDetail3), for: .normal)
                fecesDetailCell.fecesDetail4.setTitle(String(data.fecesDetail4), for: .normal)
                fecesDetailCell.fecesDetail5.setTitle(String(data.fecesDetail5), for: .normal)
                fecesDetailCell.fecesDetail6.setTitle(String(data.fecesDetail6), for: .normal)
            }
            fecesDetailCell.delegate = self
            return fecesDetailCell
            
        } else if identifier == "AdditionButtonCell" {
            let additionButtonCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! AdditionButtonCell
            additionButtonCell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            return additionButtonCell
        } else if identifier == "MedicineEmptyStateCell" {
            let medicineEmptyStateCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MedicineEmptyStateCell
            medicineEmptyStateCell.messageLabel.text = "服用はありません"
            medicineEmptyStateCell.messageLabel.textColor = .gray // テキストの色を薄く設定
            medicineEmptyStateCell.messageLabel.textAlignment = .center
            medicineEmptyStateCell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            return medicineEmptyStateCell
        } else if identifier == "MedicineRecordDetailCell" {
            let medicineRecordDetailCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MedicineRecordDetailCell
            return medicineRecordDetailCell
        } else if identifier == "MemoCell" {
            let memoCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MemoCell
            if indexPath.row < calendarDataModel.count {
                let data = calendarDataModel[indexPath.row]
                memoCell.memo.text = data.memo
            }
            memoCell.setDoneButton()
            memoCell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            return memoCell
        } else {
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        // 特定の行を選択不可にする
        if indexPath.row == 0 {
            return false
        } else if indexPath.row == 1 {
            return false
        } else if indexPath.row == 2 {
            return false
        } else if indexPath.row == 3 {
            return false
        } else if indexPath.row == 4 {
            return false
        } else if indexPath.row == 5 {
            return false
        } else if indexPath.row == 6 {
            return false
        } else {
            return true
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 3 {
            return 80 // 3行目の高さを80に設定
        } else {
            return UITableView.automaticDimension
        }
    }
    func didTapHistoryButton(in cell: FecesDetailCell) {
        performSegue(withIdentifier: "FecesHistory", sender: self)
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
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeight.constant = bounds.height
        self.view.layoutIfNeeded()
    }
    // デリゲートメソッド
    func didSaveCalendar(_ calendar: CalendarDataModel) {
        calendarDataModel.append(calendar)
        tableView.reloadData()
    }
    private func saveCalendar(_ calendar: CalendarDataModel) {
        let calendarData = CalendarDataModel()
        calendarData.number01Button = 2
        calendarData.memo = "Sample memo"

        let realm = try! Realm()
        try! realm.write {
            realm.add(calendar)
        }
    }
}
