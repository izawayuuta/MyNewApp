//
//  Certificate.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/07/03.
//

import Foundation
import UIKit
import RealmSwift

class CertificateViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PlusButtonCellDelegate, CertificateViewControllerDelegate {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var tableViewCell: [String] = []
    private var certificateDataModel: [CertificateDataModel] = []
    weak var delegate: CertificateViewControllerDelegate?

    let realm = try! Realm()
    
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
        saveData()
        loadCertificates()
    }
    // 読み込み
    func loadCertificates() {
        let realm = try! Realm()
        let certificates = realm.objects(CertificateDataModel.self)
        certificateDataModel = Array(certificates)
        tableView.reloadData()
    }
    // 行数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = tableViewCell[indexPath.row]
        if identifier == "ApplicationClassificationCell" {
            let applicationClassificationCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ApplicationClassificationCell
            if indexPath.row < certificateDataModel.count {
                        let data = certificateDataModel[indexPath.row]
                        applicationClassificationCell.textField0.text = data.textField0
                    }
            applicationClassificationCell.setDoneButton()
            return applicationClassificationCell
        } else if identifier == "MoneyCell" {
            let moneyCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MoneyCell
            if indexPath.row < certificateDataModel.count {
                        let data = certificateDataModel[indexPath.row]
                        moneyCell.textField01.text = String(data.textField01)
                    }
            moneyCell.setDoneButton()
            return moneyCell
        } else if identifier == "HierarchyClassificationCell" {
            let hierarchyClassificationCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! HierarchyClassificationCell
            if indexPath.row < certificateDataModel.count {
                        let data = certificateDataModel[indexPath.row]
                        hierarchyClassificationCell.textField02.text = data.textField02
                    }
            hierarchyClassificationCell.setDoneButton()
            return hierarchyClassificationCell
        } else if identifier == "DeadlineCell" {
            let deadlineCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! DeadlineCell
            if indexPath.row < certificateDataModel.count {
                        let data = certificateDataModel[indexPath.row]
                        deadlineCell.year.text = String(data.year)
                        deadlineCell.month.text = String(data.month)
                        deadlineCell.day.text = String(data.day)
                        deadlineCell.year2.text = String(data.year2)
                        deadlineCell.month2.text = String(data.month2)
                        deadlineCell.day2.text = String(data.day2)
                    }
            deadlineCell.setDoneButton()
            return deadlineCell
        } else if identifier == "PeriodCell" {
            let periodCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! PeriodCell
            if indexPath.row < certificateDataModel.count {
                        let data = certificateDataModel[indexPath.row]
                        periodCell.textField1.text = String(data.textField1)
                        periodCell.textField2.text = String(data.textField2)
                        periodCell.textField3.text = String(data.textField3)
                        periodCell.textField4.text = String(data.textField4)
                        periodCell.textField5.text = String(data.textField5)
                        periodCell.pickerView.selectRow(data.pickerView, inComponent: 0, animated: false)
                    }
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
    func saveData() {
        try! realm.write {
            // すべてのセルからデータを取得
            for i in 0..<tableViewCell.count {
                let indexPath = IndexPath(row: i, section: 0)
                if let cell = tableView.cellForRow(at: indexPath) as? ApplicationClassificationCell {
                    let certificate = CertificateDataModel()
                    certificate.textField0 = cell.textField0.text ?? ""
                    realm.add(certificate, update: .modified)
                    print("Saved ApplicationClassificationCell: \(certificate.textField0)")
                } else if let cell = tableView.cellForRow(at: indexPath) as? MoneyCell {
                    let certificate = CertificateDataModel()
                    certificate.textField01 = Int(cell.textField01.text ?? "") ?? 0
                    realm.add(certificate, update: .modified)
                    print("Saved MoneyCell: \(certificate.textField01)")
                } else if let cell = tableView.cellForRow(at: indexPath) as? HierarchyClassificationCell {
                    let certificate = CertificateDataModel()
                    certificate.textField02 = cell.textField02.text ?? ""
                    realm.add(certificate, update: .modified)
                    print("Saved HierarchyClassificationCell: \(certificate.textField02)")
                } else if let cell = tableView.cellForRow(at: indexPath) as? DeadlineCell {
                    let certificate = CertificateDataModel()
                    certificate.year = Int(cell.year.text ?? "") ?? 0
                    certificate.month = Int(cell.month.text ?? "") ?? 0
                    certificate.day = Int(cell.day.text ?? "") ?? 0
                    certificate.year2 = Int(cell.year2.text ?? "") ?? 0
                    certificate.month2 = Int(cell.month2.text ?? "") ?? 0
                    certificate.day2 = Int(cell.day2.text ?? "") ?? 0
                    realm.add(certificate, update: .modified)
                    print("Saved DeadlineCell: \(certificate.year)-\(certificate.month)-\(certificate.day) to \(certificate.year2)-\(certificate.month2)-\(certificate.day2)")
                } else if let cell = tableView.cellForRow(at: indexPath) as? PeriodCell {
                    let certificate = CertificateDataModel()
                    certificate.textField1 = Int(cell.textField1.text ?? "") ?? 0
                    certificate.textField2 = Int(cell.textField2.text ?? "") ?? 0
                    certificate.textField3 = Int(cell.textField3.text ?? "") ?? 0
                    certificate.textField4 = Int(cell.textField4.text ?? "") ?? 0
                    certificate.textField5 = Int(cell.textField5.text ?? "") ?? 0
                    certificate.pickerView = cell.pickerView.selectedRow(inComponent: 0)
                    realm.add(certificate, update: .modified)
                    print("Saved PeriodCell: \(certificate.textField1), \(certificate.textField2), \(certificate.textField3), \(certificate.textField4), \(certificate.textField5), PickerView Index: \(certificate.pickerView)")
                }
            }
        }
    }

    // データ更新
    func didSaveCertificate(_ certificate: CertificateDataModel) {
        certificateDataModel.append(certificate)
        tableView.reloadData()
    }
}
