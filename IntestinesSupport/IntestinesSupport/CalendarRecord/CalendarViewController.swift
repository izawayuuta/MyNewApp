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

class CalendarViewController: UIViewController, FecesDetailCellDelegate {
    
    private let tableViewCell: [String] = ["CalendarDateCell", "PhysicalConditionCell", "FecesConditionCell", "FecesDetailCell", "AdditionButtonCell", "MedicineEmptyStateCell", "MedicineRecordDetailCell", "MemoCell"]
    
    private var selectedDate: Date?
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
        
        calendar.delegate = self
        calendar.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "CalendarDateCell", bundle: nil), forCellReuseIdentifier: "CalendarDateCell")
        tableView.register(UINib(nibName: "PhysicalConditionCell", bundle: nil), forCellReuseIdentifier: "PhysicalConditionCell")
        tableView.register(UINib(nibName: "FecesConditionCell", bundle: nil), forCellReuseIdentifier: "FecesConditionCell")
        tableView.register(UINib(nibName: "FecesDetailCell", bundle: nil), forCellReuseIdentifier: "FecesDetailCell")
        tableView.register(UINib(nibName: "AdditionButtonCell", bundle: nil), forCellReuseIdentifier: "AdditionButtonCell")
        tableView.register(UINib(nibName: "MedicineEmptyStateCell", bundle: nil), forCellReuseIdentifier: "MedicineEmptyStateCell")
        tableView.register(UINib(nibName: "MedicineRecordDetailCell", bundle: nil), forCellReuseIdentifier: "MedicineRecordDetailCell")
        tableView.register(UINib(nibName: "MemoCell", bundle: nil), forCellReuseIdentifier: "MemoCell")
        
        tableView.separatorColor = UIColor.black
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        loadCalendars()
        configureCalendar()
        setupCalendarScope()
    }
    
    private func setupCalendarScope() {
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
    }
    
    // viewDidLoad終わり
    private func loadCalendars() {
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
    
    // FIXME: 遷移するとクラッシュする
    func didTapRecordButton(in cell: FecesDetailCell) {
        performSegue(withIdentifier: "FecesHistory", sender: self)
    }
    
    private func refreshData() {
        loadCalendars()
        tableView.reloadData()
    }
}

// MARK: tableView関連
extension CalendarViewController: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 選択された日付がないとそもそもデータの保存ができないため、日付が選択していない場合は空のCellを返却する
        // 今は適当なCellを使用したので、ボーダーが表示されないような工夫をお願いします
        // ユーザーに日付の選択を促すCellを実装しても良いでしょう
        guard let selectedDate else { return EmptyStateCell() }
        
        let identifier = tableViewCell[indexPath.row]
        // 日付に紐づくcalendarDataModelを取得する
        let filteredCalendarDataModel = calendarDataModel.filter { $0.date == selectedDate }.first
        
        if identifier == "CalendarDateCell" {
            let calendarCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CalendarDateCell
            calendarCell.configure(with: selectedDate)
            return calendarCell
        } else if identifier == "PhysicalConditionCell" {
            let physicalConditionCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! PhysicalConditionCell
            physicalConditionCell.delegate = self
            // CalendarDataModelがnilの場合は早期リターンする
            guard let model = filteredCalendarDataModel else {
                // nilの場合は日付だけ必要なのでそれをセットする
                physicalConditionCell.configure(selectedDate: selectedDate)
                return physicalConditionCell
            }
            physicalConditionCell.configure(selectedIndex: model.selectedPhysicalConditionIndex, model: model , selectedDate: selectedDate)
            return physicalConditionCell
        } else if identifier == "FecesConditionCell" {
            let fecesConditionCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! FecesConditionCell
            if indexPath.row < calendarDataModel.count {
            }
            return fecesConditionCell
        } else if identifier == "FecesDetailCell" {
            let fecesDetailCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! FecesDetailCell
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
    
    /// 全てのCellの選択を不可にする
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 3 {
            return 80 // 3行目の高さを80に設定
        } else {
            return UITableView.automaticDimension
        }
    }
}

// MARK: CalendarViewControllerDelegate関連 / RealmDataの保存を行う
extension CalendarViewController: CalendarViewControllerDelegate {
    func saveCalendarData(_ newData: CalendarDataModel) {
        let realm = try! Realm()
        // Realmのデータの中に同じidが存在するならそれをもとに更新する
        if let object = realm.objects(CalendarDataModel.self).filter("id == %@", newData.id).first {
            try! realm.write {
                object.date = newData.date
                object.selectedPhysicalConditionIndex = newData.selectedPhysicalConditionIndex
                object.selectedFecesConditionIndex = newData.selectedFecesConditionIndex
                object.selectedFecesDetailIndex = newData.selectedFecesDetailIndex
                object.memo = newData.memo
            }
        } else {
            // idが一致しない場合は新規で保存する
            try! realm.write {
                realm.add(newData)
            }
        }
        // Realmの保存が完了した後TableViewをリロードする
        refreshData()
        
        func didTapRecordButton(in cell: FecesDetailCell) {
            performSegue(withIdentifier: "FecesRecord", sender: self)
        }
    }
}

// MARK: FSCalendarDelegate関連
extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    // 日付が選択されたときに呼び出されるメソッド
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDate = date
        tableView.reloadData() // 選択された日付に関連するデータを表示するためにテーブルビューをリロード
    }
    
    // カレンダーの日付のタイトルの色をカスタマイズするメソッド
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        let weekday = Calendar.current.component(.weekday, from: date)
        
        // 土曜日の場合、タイトルの色を青にする
        if weekday == 7 {
            return .blue
            // 日曜日の場合、タイトルの色を赤にする
        } else if weekday == 1 {
            return .red
        }
        return nil // その他の日はデフォルトの色を使用
    }
    
    // カレンダーの高さが変更されるときに呼び出されるメソッド
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        // カレンダーの高さ制約を更新
        calendarHeight.constant = bounds.height
        // レイアウトの更新を即時反映
        self.view.layoutIfNeeded()
    }
}

