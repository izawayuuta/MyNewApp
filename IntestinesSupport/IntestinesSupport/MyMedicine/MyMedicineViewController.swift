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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "MedicineTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        loadMedicines()
    }
    func loadMedicines() {
        let realm = try! Realm()
        let MyMedicines = realm.objects(MedicineDataModel.self)
        medicineDataModel = Array(MyMedicines)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicineDataModel.count
    }
    
    // セルを構成する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! MedicineTableViewCell
        let medicine = medicineDataModel[indexPath.row]
        cell.medicineNameLabel.text = medicine.medicineName
//                        cell.stockLabel.text = medicine.stock
        cell.stockNumberLabel.text = "\(medicine.stock)"
        cell.stockUnitLabel.text = medicine.label
        
        cell.selectionStyle = .none // セル選択時の色の変化を無効化

        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let medicineToDelete = medicineDataModel[indexPath.row]
//            deleteMedicine(medicineToDelete)
            medicineDataModel.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            loadMedicines()
            tableView.reloadData()
            print("Row deleted: \(indexPath.row)")
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 選択されたセルのデータを取得
        let selectedMedicine = medicineDataModel[indexPath.row]
        // ストーリーボードからビューコントローラーを取得
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let infoVC = storyboard.instantiateViewController(withIdentifier: "MyMedicineInformation") as? MyMedicineInformation else {
            return
        }
        infoVC.delegate = self
        infoVC.selectedMedicine = selectedMedicine
        let navigationController = UINavigationController(rootViewController: infoVC)
        navigationController.modalPresentationStyle = .automatic
        present(navigationController, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    // デリゲートメソッド
    func didSaveMedicine(_ medicine: MedicineDataModel) {
        medicineDataModel.append(medicine)
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
