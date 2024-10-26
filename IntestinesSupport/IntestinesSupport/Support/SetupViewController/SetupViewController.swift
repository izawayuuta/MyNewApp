//
//  SetupViewController.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/10/16.
//

import Foundation
import UIKit

class SetupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let tableViewCell = ["ColorTableViewCell", "WeekStartTableViewCell"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        // スクロールを無効化
        tableView.isScrollEnabled = false
        
        navigationController?.navigationBar.isHidden = false // Aに戻るたびに非表示
        
        tableView.register(UINib(nibName: "ColorTableViewCell", bundle: nil), forCellReuseIdentifier: "ColorTableViewCell")
        tableView.register(UINib(nibName: "WeekStartTableViewCell", bundle: nil), forCellReuseIdentifier: "WeekStartTableViewCell")
        
        tableView.separatorColor = UIColor.systemBlue // 色を赤に設定
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = tableViewCell[indexPath.row]
        
        if identifier == "ColorTableViewCell" {
            let colorTableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ColorTableViewCell
            colorTableViewCell.selectionStyle = .none // 選択スタイルを無効にする
            return colorTableViewCell
        } else if identifier == "WeekStartTableViewCell" {
            let weekStartTableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! WeekStartTableViewCell
            weekStartTableViewCell.selectionStyle = .none // 選択スタイルを無効にする
            return weekStartTableViewCell
        } else {
            return UITableViewCell()
        }
    }
    // 行の高さを設定
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // セルタップ時の色を変えないようにする
            tableView.deselectRow(at: indexPath as IndexPath, animated: true)
            // セルの identifier を取得
            let identifier = tableViewCell[indexPath.row]
            
            if identifier == "ColorTableViewCell" {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let colorViewController = storyboard.instantiateViewController(withIdentifier: "ColorViewController") as? ColorViewController {
                    // pushViewControllerを使用してタブバーにアクセスできるようにする
                    navigationController?.pushViewController(colorViewController, animated: true)
                }
            }
        }
}
