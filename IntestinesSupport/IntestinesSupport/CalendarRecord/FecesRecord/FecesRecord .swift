//
//  FecesRecord .swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/07/19.
//

import Foundation
import UIKit
import RealmSwift

class FecesRecordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var records: [String] = []
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
            tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "EmptyStateCell", bundle: nil), forCellReuseIdentifier: "EmptyStateCell")

        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if records.isEmpty {
                    return 1
                } else {
                    return records.count
                }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyStateCell", for: indexPath) as! EmptyStateCell
                    cell.messageLabel.text = "記録はありません"
                    cell.messageLabel.textColor = .gray 
                    cell.messageLabel.textAlignment = .center
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
                    return cell
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func addRecord(_ record: String) {
            records.append(record)
            tableView.reloadData()
        }
}
