//
//  GraphViewController.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/10/16.
//

import Foundation
import UIKit
import Charts
import RealmSwift

class GraphViewController: UIViewController {
    
    @IBOutlet weak var graphView: LineChartView!
    
        var recordList: [FecesDetailDataModel] = []
        // 1ヶ月分のデータを取得する
    override func viewDidLoad() {
            super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false

            // 1ヶ月分のデータを取得
            fetchLastMonthFecesData()
            
            // グラフをセットアップ
            setupGraph()
        }
        
        // 1ヶ月分のデータを取得する
        func fetchLastMonthFecesData() {
            let realm = try! Realm()
            let currentDate = Date()
            
            guard let oneMonthAgo = Calendar.current.date(byAdding: .month, value: -1, to: currentDate) else {
                return
            }
            
            // Realmで1ヶ月分のデータを取得
            let lastMonthData = realm.objects(FecesDetailDataModel.self).filter("date >= %@ AND date <= %@", oneMonthAgo, currentDate)
            
            // recordList にデータを保存
            recordList = Array(lastMonthData)
        }
        
    // グラフをセットアップしてデータを表示する
    func setupGraph() {
        var dataEntries: [ChartDataEntry] = []
        let calendar = Calendar.current
        let currentDate = Date()
        
        // 1ヶ月前の日付を取得
        guard let oneMonthAgo = calendar.date(byAdding: .month, value: -1, to: currentDate) else { return }
        
        // 1ヶ月間の日付を作成（初期化）
        var dailyCount: [Int: Int] = [:]
        for dayOffset in 0..<31 {
            if let date = calendar.date(byAdding: .day, value: dayOffset, to: oneMonthAgo) {
                let day = calendar.component(.day, from: date)
                dailyCount[day] = 0 // データがない日は0を初期化
            }
        }
        
        // データがある日をカウント
        for fecesData in recordList {
            let daysFromStart = calendar.dateComponents([.day], from: oneMonthAgo, to: fecesData.date).day ?? 0
            dailyCount[daysFromStart, default: 0] += 1
        }
        
        // データエントリを作成
        for dayOffset in 0..<31 {
            let count = dailyCount[dayOffset] ?? 0
            let dataEntry = ChartDataEntry(x: Double(dayOffset), y: Double(count))
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "Feces Data")
        let chartData = LineChartData(dataSet: chartDataSet)
        
        // グラフにデータをセット
        graphView.data = chartData
        
        // グラフの追加設定
        graphView.chartDescription.text = "Feces Data for Last Month"
        graphView.xAxis.labelPosition = .bottom
        graphView.xAxis.granularity = 1.0 // X軸の間隔
        graphView.rightAxis.enabled = false // 右側のY軸を無効化

        // 縦軸の設定
        graphView.leftAxis.labelPosition = .outsideChart
        graphView.leftAxis.axisMinimum = 0 // Y軸の最小値を0に固定
        graphView.leftAxis.granularity = 1.0 // Y軸の間隔を1に設定
    }
    }
    


//    @IBOutlet weak var startDateTextField: UITextField!
//        @IBOutlet weak var endDateTextField: UITextField!
//
//    var recordList: [FecesDetailDataModel] = []
//
//    var datePicker: UIDatePicker {
//           let datePicker: UIDatePicker = UIDatePicker()
//           datePicker.datePickerMode = .date
//           datePicker.timeZone = .current
//           datePicker.preferredDatePickerStyle = .wheels
//           datePicker.locale = .current
//           return datePicker
//       }
//
//    var dateFormatter: DateFormatter {
//            let dateFormatt = DateFormatter()
//            dateFormatt.dateStyle = .long
//            dateFormatt.timeZone = .current
//            dateFormatt.locale = Locale(identifier: "ja-JP")
//            return dateFormatt
//        }
//
//    var toolBar: UIToolbar {
//            let toolBarRect = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35)
//            let toolBar = UIToolbar(frame: toolBarRect)
//            let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDone))
//            toolBar.setItems([doneItem], animated: true)
//            return toolBar
//        }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        navigationController?.navigationBar.isHidden = false
//        // データを取得してグラフを描画
//        fetchDataAndSetupGraph()
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//            super.viewWillAppear(animated)
//            configureGraph()
//            configureTextField()
//        }
//
//        private func fetchDataAndSetupGraph() {
//            let realm = try! Realm()
//
//            // Realmから全データを取得
//            let allRecords = realm.objects(FecesDetailDataModel.self)
//
//            // 選択された日付範囲を取得
//            guard let startDateText = startDateTextField.text,
//                  let endDateText = endDateTextField.text,
//                  let startDate = dateFormatter.date(from: startDateText),
//                  let endDate = dateFormatter.date(from: endDateText) else {
//                return
//            }
//
//            // 選択された日付範囲でデータをフィルタリング
//            let filteredRecords = allRecords.filter("date >= %@ AND date <= %@", startDate, endDate)
//
//            // 日付ごとのデータ数をカウントする辞書を作成
//            var countByDate: [String: Int] = [:]
//
//            for record in filteredRecords {
//                // 日付をフォーマットしてキーとして使用
//                let dateString = DateFormatter.localizedString(from: record.date, dateStyle: .short, timeStyle: .none)
//                countByDate[dateString, default: 0] += 1
//            }
//
//            // グラフ用のデータを設定
//            setupGraph(with: countByDate)
//        }
//
//        private func setupGraph(with countByDate: [String: Int]) {
//            var entries: [ChartDataEntry] = []
//            var index = 0
//
//            for (date, count) in countByDate {
//                let entry = ChartDataEntry(x: Double(index), y: Double(count), data: date as AnyObject)
//                entries.append(entry)
//                index += 1
//            }
//
//            let dataSet = LineChartDataSet(entries: entries, label: "Feces Count")
//            let data = LineChartData(dataSet: dataSet)
//
//            graphView.data = data
//            graphView.xAxis.valueFormatter = DefaultAxisValueFormatter { (value, axis) -> String in
//                let index = Int(value)
//                let keys = Array(countByDate.keys)
//                return index < keys.count ? keys[index] : ""
//            }
//        }
//
//        func configureGraph() {
//            graphView.xAxis.labelPosition = .bottom
//            let titleFormatter = GraphDataTitleFormatter()
//            let dateList = recordList.map({ $0.date })
//            titleFormatter.dateList = dateList
//            graphView.xAxis.valueFormatter = titleFormatter
//        }
//
//        func configureTextField() {
//            let startDatePicker = datePicker
//            let endDatePicker = datePicker
//            let today = Date()
//            let pastMonth = Calendar.current.date(byAdding: .month, value: -1, to: today)
//
//            startDatePicker.date = pastMonth ?? Date()
//            endDatePicker.date = today
//
//            startDateTextField.inputView = startDatePicker
//            endDateTextField.inputView = endDatePicker
//
//            startDateTextField.text = dateFormatter.string(from: pastMonth ?? Date())
//            endDateTextField.text = dateFormatter.string(from: today)
//
//            // キーボードの上にツールバーを表示するための設定
//            startDateTextField.inputAccessoryView = toolBar
//            endDateTextField.inputAccessoryView = toolBar
//
//            // 日付が変更されたときに呼ばれるメソッドを設定
//            startDatePicker.addTarget(self, action: #selector(didChangeStartDate(picker:)), for: .valueChanged)
//            endDatePicker.addTarget(self, action: #selector(didChangeEndDate(picker:)), for: .valueChanged)
//        }
//
//        @objc func didTapDone() {
//            view.endEditing(true)
//        }
//
//        @objc func didChangeStartDate(picker: UIDatePicker) {
//            startDateTextField.text = dateFormatter.string(from: picker.date)
//            // 日付が変更されたらグラフを更新
//            fetchDataAndSetupGraph()
//        }
//
//        @objc func didChangeEndDate(picker: UIDatePicker) {
//            endDateTextField.text = dateFormatter.string(from: picker.date)
//            // 日付が変更されたらグラフを更新
//            fetchDataAndSetupGraph()
//        }
