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
    var fecesDetails: [String] = ["", "", "", "", "", ""]  // 受け取るデータ用のプロパティ

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
//            let recordCell = tableView.dequeueReusableCell(withIdentifier: "FecesRecordTableViewCell", for: indexPath) as! FecesRecordTableViewCell
//            let count = records[indexPath.row]
//            recordCell.configure(with: count)
//            return recordCell
            let recordCell = tableView.dequeueReusableCell(withIdentifier: "FecesRecordTableViewCell", for: indexPath) as! FecesRecordTableViewCell
                    
                    // fecesDetails のデータを使ってラベルを設定する
                    recordCell.label1.text = fecesDetails[0]
                    recordCell.label2.text = fecesDetails[1]
                    recordCell.label3.text = fecesDetails[2]
                    recordCell.label4.text = fecesDetails[3]
                    recordCell.label5.text = fecesDetails[4]
                    recordCell.label6.text = fecesDetails[5]
                    
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
    }
    
    func addRecord(_ count: Int) {
        records.append(count)  // 新しいカウントを追加
        tableView.reloadData()
    }

    func didTapPlusButton(in cell: FecesDetailCell) {
            // StoryboardからViewControllerを取得して遷移する
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let fecesRecordVC = storyboard.instantiateViewController(withIdentifier: "FecesRecordViewController") as? FecesRecordViewController {
                // cellからfecesDetailsのデータを渡す
                fecesRecordVC.fecesDetails = cell.selectedFecesDetails
                navigationController?.pushViewController(fecesRecordVC, animated: true)
            }
        let nextCount = records.count + 1  // カウントを増加
        addRecord(nextCount)
        
        fecesDetails = cell.selectedFecesDetails  // データを更新する
        tableView.reloadData()  // テーブルビューを更新
        }
}
