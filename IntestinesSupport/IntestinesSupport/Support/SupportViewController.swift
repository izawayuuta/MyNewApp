//
//  SupportViewController.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/10/14.
//

import Foundation
import UIKit

class SupportViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let tableViewCell = ["SupportTableViewCell", "PrivacyPolicyTableViewCell", "TentativeTableViewCell"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "SupportTableViewCell", bundle: nil), forCellReuseIdentifier: "SupportTableViewCell")
        tableView.register(UINib(nibName: "PrivacyPolicyTableViewCell", bundle: nil), forCellReuseIdentifier: "PrivacyPolicyTableViewCell")
        tableView.register(UINib(nibName: "TentativeTableViewCell", bundle: nil), forCellReuseIdentifier: "TentativeTableViewCell")
        
        tableView.separatorColor = UIColor.systemBlue // 色を赤に設定
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = tableViewCell[indexPath.row]
        
        if identifier == "SupportTableViewCell" {
            let supportTableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! SupportTableViewCell
            supportTableViewCell.selectionStyle = .none // 選択スタイルを無効にする
            return supportTableViewCell
        } else if identifier == "PrivacyPolicyTableViewCell" {
            let privacyPolicyTableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! PrivacyPolicyTableViewCell
            privacyPolicyTableViewCell.selectionStyle = .none // 選択スタイルを無効にする
            return privacyPolicyTableViewCell
        } else if identifier == "TentativeTableViewCell" {
            let tentativeTableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! TentativeTableViewCell
            tentativeTableViewCell.selectionStyle = .none // 選択スタイルを無効にする
            tentativeTableViewCell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude) // 線を消す
            return tentativeTableViewCell
        } else {
            return UITableViewCell()
        }
    }
    // 行の高さを設定
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //        // 3行目の高さを固定
        //        if indexPath.row == 3 {
        //            return 80
        //        }
        //        let startingRow = 5
        //        let lastRow = tableView.numberOfRows(inSection: indexPath.section) - 1 // 最後のインデックス
        //
        //        if indexPath.row >= startingRow && indexPath.row <= lastRow {
        //            return 50
        //        } else {
        //            return UITableView.automaticDimension // それ以外のセルは自動調整
        //        }
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // セルタップ時の色を変えないようにする
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        // セルの identifier を取得
        let identifier = tableViewCell[indexPath.row]
        
        // 各セルの identifier に応じて URL を設定
        var urlString: String?
        if identifier == "SupportTableViewCell" {
            urlString = "https://intestinessupport.hp.peraichi.com/?_gl=1*awdhas*_gcl_au*MjAzNjk2ODY0OC4xNzI4Njk0NzMy&_ga=2.221421852.562715736.1728904895-1236405149.1728694732"
        } else if identifier == "PrivacyPolicyTableViewCell" {
            urlString = "https://wooded-starburst-67e.notion.site/11ce36f7a27180ed9311d9209fa8237b"
        }
        
        // URLを開く処理
        if let urlString = urlString, let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

