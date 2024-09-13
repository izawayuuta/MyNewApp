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
    var certificateIds: [String] = []
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
        loadCertificates()
        saveData()
    }
    // 読み込み
    func loadCertificates() {
        let realm = try! Realm()
        let certificates = realm.objects(CertificateDataModel.self)
        certificateDataModel = Array(certificates)
        certificateIds = certificateDataModel.map { $0.id } // IDの配列を更新
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
                applicationClassificationCell.certificateId = data.id
            }
            applicationClassificationCell.setDoneButton()
            return applicationClassificationCell
        } else if identifier == "MoneyCell" {
            let moneyCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MoneyCell
            if indexPath.row < certificateDataModel.count {
                let data = certificateDataModel[indexPath.row]
                // textField01 を String に変換し、空文字を表示できるようにする
                let displayValue = data.textField01 == 0 ? "" : String(data.textField01)
                moneyCell.textField01.text = displayValue
                moneyCell.certificateId = data.id
            }
            moneyCell.setDoneButton()
            return moneyCell
        } else if identifier == "HierarchyClassificationCell" {
            let hierarchyClassificationCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! HierarchyClassificationCell
            if indexPath.row < certificateDataModel.count {
                let data = certificateDataModel[indexPath.row]
                hierarchyClassificationCell.textField02.text = data.textField02
                hierarchyClassificationCell.certificateId = data.id
            }
            hierarchyClassificationCell.setDoneButton()
            return hierarchyClassificationCell
        } else if identifier == "DeadlineCell" {
            let deadlineCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! DeadlineCell
            if indexPath.row < certificateDataModel.count {
                let data = certificateDataModel[indexPath.row]
                // 各フィールドにデータを設定
                deadlineCell.year.text = data.year != 0 ? String(data.year) : ""
                deadlineCell.month.text = data.month != 0 ? String(data.month) : ""
                deadlineCell.day.text = data.day != 0 ? String(data.day) : ""
                deadlineCell.year2.text = data.year2 != 0 ? String(data.year2) : ""
                deadlineCell.month2.text = data.month2 != 0 ? String(data.month2) : ""
                deadlineCell.day2.text = data.day2 != 0 ? String(data.day2) : ""
                deadlineCell.certificateId = data.id
            }
            deadlineCell.setDoneButton()
            return deadlineCell
        } else if identifier == "PeriodCell" {
            let periodCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! PeriodCell
            if indexPath.row < certificateDataModel.count {
                let data = certificateDataModel[indexPath.row]
                // 各フィールドにデータを設定
                periodCell.textField1.text = data.year != 0 ? String(data.year) : ""
                periodCell.textField2.text = data.month != 0 ? String(data.month) : ""
                periodCell.textField3.text = data.day != 0 ? String(data.day) : ""
                periodCell.textField4.text = data.year2 != 0 ? String(data.year2) : ""
                periodCell.textField5.text = data.month2 != 0 ? String(data.month2) : ""
                periodCell.certificateId = data.id
            } 
            if indexPath.row < certificateIds.count {
                let id = certificateIds[indexPath.row]
                periodCell.certificateId = id
            }
            periodCell.loadPickerSelection()
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
            // CertificateDataModelから削除する
            let realm = try! Realm()
            let dataToDelete = certificateDataModel[indexPath.row]
            
            try! realm.write {
                realm.delete(dataToDelete)
            }
            // TableViewのデータソースから削除
            tableViewCell.remove(at: indexPath.row)
            certificateDataModel.remove(at: indexPath.row)
            // TableViewからセルを削除
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    func didTapPlusButton(in cell: PlusButtonCell) {
            let realm = try! Realm()
            let newCertificate = CertificateDataModel()
            
            try! realm.write {
                realm.add(newCertificate)
            }
            
            certificateIds.append(newCertificate.id)
//            tableViewCell.append("PeriodCell")
        tableViewCell.insert("PeriodCell", at: tableViewCell.count - 1)
            
            tableView.reloadData()
        
        saveData()
            print("☀️Data saved after adding new PeriodCell.")
        }
        func saveData() {
            try! realm.write {
                var periodCellIndex = 0 // PeriodCellのインデックスを追跡
                // すべてのセルからデータを取得
                for i in 0..<tableViewCell.count {
                    let indexPath = IndexPath(row: i, section: 0)
//                    guard i < certificateDataModel.count else { continue }
//                    let certificate = certificateDataModel[i]
                    var certificate: CertificateDataModel

                    if let cell = tableView.cellForRow(at: indexPath) as? ApplicationClassificationCell {
                        let certificate = CertificateDataModel()
                        certificate.textField0 = cell.textField0.text ?? ""
                        realm.add(certificate, update: .modified)
                    } else if let cell = tableView.cellForRow(at: indexPath) as? MoneyCell {
                        let certificate = CertificateDataModel()
                        certificate.textField01 = Int(cell.textField01.text ?? "") ?? 0
                        realm.add(certificate, update: .modified)
                    } else if let cell = tableView.cellForRow(at: indexPath) as? HierarchyClassificationCell {
                        let certificate = CertificateDataModel()
                        certificate.textField02 = cell.textField02.text ?? ""
                        realm.add(certificate, update: .modified)
                    } else if let cell = tableView.cellForRow(at: indexPath) as? DeadlineCell {
                        let certificate = CertificateDataModel()
                        certificate.year = Int(cell.year.text ?? "") ?? 0
                        certificate.month = Int(cell.month.text ?? "") ?? 0
                        certificate.day = Int(cell.day.text ?? "") ?? 0
                        certificate.year2 = Int(cell.year2.text ?? "") ?? 0
                        certificate.month2 = Int(cell.month2.text ?? "") ?? 0
                        certificate.day2 = Int(cell.day2.text ?? "") ?? 0
                        realm.add(certificate, update: .modified)
                    } else if tableViewCell[i] == "PeriodCell" {
                        // PeriodCellに対応するデータが存在するか確認
                        if periodCellIndex < certificateDataModel.count {
                            certificate = certificateDataModel[periodCellIndex]
                        } else {
                            // 新しいデータモデルを作成
                            certificate = CertificateDataModel()
                            certificateDataModel.append(certificate)
                            certificateIds.append(certificate.id)
                        }
                        
                        // PeriodCellの保存処理
                        if let cell = tableView.cellForRow(at: indexPath) as? PeriodCell {
                            certificate.textField1 = Int(cell.textField1.text ?? "") ?? 0
                            certificate.textField2 = Int(cell.textField2.text ?? "") ?? 0
                            certificate.textField3 = Int(cell.textField3.text ?? "") ?? 0
                            certificate.textField4 = Int(cell.textField4.text ?? "") ?? 0
                            certificate.textField5 = Int(cell.textField5.text ?? "") ?? 0
                            print("Saving PeriodCell CertificateDataModel with ID: \(certificate.id), Data: [\(certificate.textField1), \(certificate.textField2), \(certificate.textField3), \(certificate.textField4), \(certificate.textField5)]")
                        }
                        
                        periodCellIndex += 1 // 次のPeriodCell用にインデックスを更新
                        // CertificateDataModelをRealmに保存
                        realm.add(certificate, update: .modified)
                    }
                }
            }
        }
        // データ更新
    func didSaveCertificate(_ certificate: CertificateDataModel) {
            if let index = certificateIds.firstIndex(of: certificate.id) {
                certificateDataModel[index] = certificate
                tableView.reloadData()
            } else {
                certificateDataModel.append(certificate)
                certificateIds.append(certificate.id)
//                tableViewCell.append("PeriodCell")
                tableViewCell.insert("PeriodCell", at: tableViewCell.count - 1) // PlusButtonCell の前に追加
                tableView.reloadData()
            }
        }
    }
