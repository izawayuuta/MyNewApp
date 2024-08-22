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

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "EmptyStateCell", bundle: nil), forCellReuseIdentifier: "EmptyStateCell")
        tableView.register(UINib(nibName: "FecesRecordTableViewCell", bundle: nil), forCellReuseIdentifier: "FecesRecordTableViewCell")
        setup()
    }
    
    
    private func setup() {
        guard let selectedDate else { return }
        
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
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if fecesDetails.isEmpty {
            return 1
        } else {
            return fecesDetails.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if fecesDetails.isEmpty {
            let emptyCell = tableView.dequeueReusableCell(withIdentifier: "EmptyStateCell", for: indexPath) as! EmptyStateCell
            emptyCell.messageLabel.text = "記録はありません"
            emptyCell.messageLabel.textColor = .gray
            emptyCell.messageLabel.textAlignment = .center
            emptyCell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            return emptyCell
        } else {
            let recordCell = tableView.dequeueReusableCell(withIdentifier: "FecesRecordTableViewCell", for: indexPath) as! FecesRecordTableViewCell
            var type: [FecesDetailType] = [] // 空の配列として初期化

            let types = fecesDetails[indexPath.row].fecesDetailTypeObject
            types.forEach {
                if let fecesDetailType = FecesDetailType(rawValue: $0.fecesDetailConditionIndex) {
                    type.append(fecesDetailType)
                } else {
                    print("Invalid fecesDetailConditionIndex: \($0.fecesDetailConditionIndex)")
                }
            }
            
            
            recordCell.configure(with: type)
            
            return recordCell
        }
    }
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addRecord(_ count: Int) {
        records.append(count)  // 新しいカウントを追加
        tableView.reloadData()
    }
}
