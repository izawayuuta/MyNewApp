//
//  FecesRecord .swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/07/19.
//

import Foundation
import UIKit
import RealmSwift

enum FecesDetailType: Int {
    case hardFeces
    case normalFeces
    case diarrhea
    case constipation
    case softFeces
    case bloodyFeces
}

class FecesRecordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var records: [Int] = []
    
    private var fecesDetails: [FecesDetailDataModel] = []  // 受け取るデータ用のプロパティ
    var selectedDate: Date?
    var fecesDetailCell: FecesDetailCell?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "EmptyStateCell", bundle: nil), forCellReuseIdentifier: "EmptyStateCell")
        tableView.register(UINib(nibName: "FecesRecordTableViewCell", bundle: nil), forCellReuseIdentifier: "FecesRecordTableViewCell")
        setup()
    }
    private func setup() {
        guard let selectedDate = selectedDate else { return }
        
        let realm = try! Realm()
        // selectedDateを東京時間に変換
        let tokyoTimeZone = TimeZone(identifier: "Asia/Tokyo")!
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: selectedDate)
        components.timeZone = tokyoTimeZone
        let tokyoSelectedDate = calendar.date(from: components)!
        
        // 同じ日付のFecesDetailDataModelをフィルタリング
        let startOfDay = calendar.startOfDay(for: tokyoSelectedDate)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        let predicate = NSPredicate(format: "date >= %@ AND date < %@", startOfDay as NSDate, endOfDay as NSDate)
        let results = realm.objects(FecesDetailDataModel.self).filter(predicate)
        
        fecesDetails = Array(results)
        
        // records 配列の初期値を設定
        records = Array(repeating: 1, count: fecesDetails.count)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if fecesDetails.isEmpty {
            return 1
        } else {
            return fecesDetails.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // `fecesDetails` が空の場合は EmptyStateCell を使用
        if fecesDetails.isEmpty {
            let emptyCell = tableView.dequeueReusableCell(withIdentifier: "EmptyStateCell", for: indexPath) as! EmptyStateCell
            emptyCell.messageLabel.text = "記録はありません"
            emptyCell.messageLabel.textColor = .gray
            emptyCell.messageLabel.textAlignment = .center
            emptyCell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            return emptyCell
        } else {
            // `FecesRecordTableViewCell` を使用する場合
            let recordCell = tableView.dequeueReusableCell(withIdentifier: "FecesRecordTableViewCell", for: indexPath) as! FecesRecordTableViewCell
            
            // データを取得する
            let fecesDetail = fecesDetails[indexPath.row]
            var type: [FecesDetailType] = []
            
            let types = fecesDetail.fecesDetailTypeObject
            types.forEach {
                if let fecesDetailType = FecesDetailType(rawValue: $0.fecesDetailConditionIndex) {
                    type.append(fecesDetailType)
                } else {
                    print("Invalid fecesDetailConditionIndex: \($0.fecesDetailConditionIndex)")
                }
            }
            
            // 日付のフォーマット
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ja_JP")
            dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
            dateFormatter.dateFormat = "HH:mm"
            let dateString = dateFormatter.string(from: fecesDetail.date)
            
            // セルを設定する
            recordCell.configure(with: type, date: dateString)
            
            if recordCell.dateLabel != nil {
                print("dateLabel is not nil in cellForRowAt > 成功")
            } else {
                print("dateLabel is nil in cellForRowAt > 失敗")
            }
            
            return recordCell
        }
    }
    
    // スライドして削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let recordToDelete = fecesDetails[indexPath.row]
            
            let realm = try! Realm()
            try! realm.write {
                realm.delete(recordToDelete)
            }
            fecesDetails.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    // セルの高さを任意の高さに固定
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension FecesRecordViewController: FecesDetailCellDelegate {
    func didTapPlusButton(indexes: [Int]) {
        // Handle plus button action
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        if let cell = tableView.cellForRow(at: indexPath) as? FecesRecordTableViewCell {
            cell.updateCount()
        }
    }
    
    func didTapRecordButton(in cell: FecesDetailCell) {
        // Handle record button action
    }
}
