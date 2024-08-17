//
//  FecesRecord .swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/07/19.
//

import Foundation
import UIKit
import RealmSwift

class FecesRecordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FecesDetailCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var records: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "EmptyStateCell", bundle: nil), forCellReuseIdentifier: "EmptyStateCell")
        tableView.register(UINib(nibName: "FecesRecordTableViewCell", bundle: nil), forCellReuseIdentifier: "FecesRecordTableViewCell")
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if records.isEmpty {
            return 1
        } else {
            return records.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if records.isEmpty {
            let emptyCell = tableView.dequeueReusableCell(withIdentifier: "EmptyStateCell", for: indexPath) as! EmptyStateCell
            emptyCell.messageLabel.text = "記録はありません"
            emptyCell.messageLabel.textColor = .gray
            emptyCell.messageLabel.textAlignment = .center
            emptyCell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            return emptyCell
        } else {
            let recordCell = tableView.dequeueReusableCell(withIdentifier: "FecesRecordTableViewCell", for: indexPath) as! FecesRecordTableViewCell
            let count = records[indexPath.row]
            recordCell.configure(with: count)
            return recordCell
        }
    }
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    //    func addRecord(_ record: String) {
    //            records.append(record)
    //            tableView.reloadData()
    //        }
    func didTapRecordButton(in cell: FecesDetailCell) {
        // 新しいデータを追加してテーブルビューを更新
        let nextCount = records.count + 1  // カウントを増加
        addRecord(nextCount)
    }
    
    func addRecord(_ count: Int) {
        records.append(count)  // 新しいカウントを追加
        tableView.reloadData()
    }
}
