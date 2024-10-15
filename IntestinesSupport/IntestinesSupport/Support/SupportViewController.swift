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
    
    private let tableViewCell = ["SupportTableViewCell", "TentativeTableViewCell"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "SupportTableViewCell", bundle: nil), forCellReuseIdentifier: "SupportTableViewCell")
        tableView.register(UINib(nibName: "TentativeTableViewCell", bundle: nil), forCellReuseIdentifier: "TentativeTableViewCell")

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = tableViewCell[indexPath.row]
        
        if identifier == "SupportTableViewCell" {
            let supportTableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! SupportTableViewCell
            return supportTableViewCell
        } else if identifier == "TentativeTableViewCell" {
            let tentativeTableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! TentativeTableViewCell
            tentativeTableViewCell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude) // 線を消す
            return tentativeTableViewCell
        } else {
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // セルタップ時の色を変えないようにする
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        //外部ブラウザでURLを開く
                let url = NSURL(string: "https://intestinessupport.hp.peraichi.com/?_gl=1*awdhas*_gcl_au*MjAzNjk2ODY0OC4xNzI4Njk0NzMy&_ga=2.221421852.562715736.1728904895-1236405149.1728694732")
                if UIApplication.shared.canOpenURL(url! as URL) {
                    UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
                }
    }
}
