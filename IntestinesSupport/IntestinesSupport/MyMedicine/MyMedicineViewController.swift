//
//  MyMedicine.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/07/03.
//

import SwiftUI
import UIKit
import RealmSwift

class MyMedicineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MedicineViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var medicineDataModel: [MedicineDataModel] = []
    var selectedIndex: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "MedicineTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        loadMedicines()
        print("MedicineDataModel : \(medicineDataModel)")
    }
    func loadMedicines() {
        let realm = try! Realm()
        let MyMedicines = realm.objects(MedicineDataModel.self)
        medicineDataModel.removeAll()
        medicineDataModel = Array(MyMedicines)
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicineDataModel.filter { !$0.isInvalidated }.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! MedicineTableViewCell
        let filteredData = medicineDataModel.filter { !$0.isInvalidated }
        
        guard indexPath.row < filteredData.count else {
            return UITableViewCell()
        }
        let medicine = filteredData[indexPath.row]
        // セルの設定
        cell.medicineNameLabel.text = medicine.medicineName
        cell.stockNumberLabel.text = "\(medicine.stock)"
        cell.stockUnitLabel.text = medicine.label
        cell.selectionStyle = .none // セル選択時の色の変化を無効化
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let realm = try! Realm()
            
            // 削除対象のオブジェクトを取得
            let medicineToDelete = medicineDataModel[indexPath.row]
            
            // メモリ上のデータを削除
            medicineDataModel.remove(at: indexPath.row)
            
            // Realmからも削除
            try! realm.write {
                realm.delete(medicineToDelete)
            }
            
            // テーブルビューを更新
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 選択されたセルのデータを取得
        let selectedMedicine = medicineDataModel[indexPath.row]
        selectedIndex = indexPath // 選択したインデックスを保存
        // ストーリーボードからビューコントローラーを取得
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let infoVC = storyboard.instantiateViewController(withIdentifier: "MyMedicineInformation") as? MyMedicineInformation else {
            return
        }
        infoVC.delegate = self
        infoVC.selectedMedicine = selectedMedicine
        let navigationController = UINavigationController(rootViewController: infoVC)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    // デリゲートメソッド
    func didSaveMedicine(_ medicine: MedicineDataModel) {
        let realm = try! Realm()
        // 選択されたセルを削除
        if let existingIndex = selectedIndex {
            let oldMedicine = medicineDataModel[existingIndex.row]
            medicineDataModel.remove(at: existingIndex.row)
            tableView.deleteRows(at: [existingIndex], with: .automatic)
            
            try! realm.write {
                realm.delete(oldMedicine)
            }
        }
        medicineDataModel.append(medicine)
        
        try! realm.write {
            realm.add(medicine, update: .modified)
        }
        tableView.reloadData()
    }
    //    private func saveMedicine(_ medicine: MedicineDataModel) {
    //        let realm = try! Realm()
    //        try! realm.write {
    //            realm.add(medicine)
    //        }
    //        tableView.reloadData()
    //    }
    func didDeleteMedicine(_ medicine: MedicineDataModel) {
        medicineDataModel.append(medicine)
        tableView.reloadData()
    }
    //    func deleteMedicine(_ medicine: MedicineDataModel) {
    //        do {
    //            let realm = try! Realm()
    //            try realm.write ({
    //                realm.delete(medicine)
    //            })
    //            tableView.reloadData()
    //        }catch {
    //        }
    //    }
}
