//
//  Certificate.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/07/03.
//

import Foundation
import UIKit
import RealmSwift

class CertificateViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PlusButtonCellDelegate {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var tableViewCell: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "ApplicationClassificationCell", bundle: nil), forCellReuseIdentifier: "ApplicationClassificationCell")
        tableView.register(UINib(nibName: "MoneyCell", bundle: nil), forCellReuseIdentifier: "MoneyCell")
        tableView.register(UINib(nibName: "HierarchyClassificationCell", bundle: nil), forCellReuseIdentifier: "HierarchyClassificationCell")
        tableView.register(UINib(nibName: "DeadlineCell", bundle: nil), forCellReuseIdentifier: "DeadlineCell")
        tableView.register(UINib(nibName: "PeriodCell", bundle: nil), forCellReuseIdentifier: "PeriodCell")
        tableView.register(UINib(nibName: "PlusButtonCell", bundle: nil), forCellReuseIdentifier: "PlusButtonCell")
        
        
        tableViewCell = ["ApplicationClassificationCell", "MoneyCell", "HierarchyClassificationCell", "DeadlineCell", "PeriodCell", "PlusButtonCell"]
        
    }
    // 行数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = tableViewCell[indexPath.row]
        if identifier == "ApplicationClassificationCell" {
            let applicationClassificationCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ApplicationClassificationCell
            applicationClassificationCell.setDoneButton()
            return applicationClassificationCell
        } else if identifier == "MoneyCell" {
            let moneyCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MoneyCell
            moneyCell.setDoneButton()
            return moneyCell
        } else if identifier == "HierarchyClassificationCell" {
            let hierarchyClassificationCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! HierarchyClassificationCell
            hierarchyClassificationCell.setDoneButton()
            return hierarchyClassificationCell
        } else if identifier == "DeadlineCell" {
            let deadlineCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! DeadlineCell
            deadlineCell.setDoneButton()
            return deadlineCell
        } else if identifier == "PeriodCell" {
            let periodCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! PeriodCell
            periodCell.setDoneButton()
            return periodCell
        } else if identifier == "PlusButtonCell" {
            let plusButtonCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! PlusButtonCell
            plusButtonCell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            plusButtonCell.delegate = self
            return plusButtonCell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 各セルの高さを設定
        let identifier = tableViewCell[indexPath.row]
        switch identifier {
        case "ApplicationClassificationCell":
            return 70
        case "MoneyCell":
            return 70
        case "HierarchyClassificationCell":
            return 70
        case "DeadlineCell":
            return 155
        case "PeriodCell":
            return 155
        case "PlusButtonCell":
            return 40
        default:
            return 70
        }
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        // セルが１つしかない時は削除を無効
        let periodCellsCount = tableViewCell.filter { $0 == "PeriodCell" }.count
        if tableViewCell[indexPath.row] == "PeriodCell" && periodCellsCount > 1 {
            return .delete
        }
        return .none
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableViewCell.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    func didTapPlusButton(in cell: PlusButtonCell) {
        tableViewCell.insert("PeriodCell", at: tableViewCell.count - 1)
        let newIndexPath = IndexPath(row: tableViewCell.count - 2, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
}
