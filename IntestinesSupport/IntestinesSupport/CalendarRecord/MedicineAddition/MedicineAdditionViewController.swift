//
//  MedicineAdditionViewController.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/08/27.
//

import Foundation
import UIKit
import RealmSwift

protocol MedicineAdditionViewControllerDelegate: AnyObject {
    func didSaveMedicineRecord(_ record: MedicineRecordDataModel)
}

class MedicineAdditionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var medicineAdditionButton: UIButton!
    
    weak var delegate: MedicineAdditionViewControllerDelegate?
    var myMedicineInformation: MyMedicineInformation?

    private var medicineDataModel: [MedicineDataModel] = []
    private var medicineRecordDataModel: [MedicineRecordDataModel] = []
    // 選択されたセルのインデックスパスを保持する配列
    private var selectedIndexPaths: [IndexPath] = []
    var additionButtonCell: AdditionButtonCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MedicineAdditionTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        tableView.allowsMultipleSelection = true
        loadMedicines()
        selectedCellButton()
        buttonSetup()
    }
    func loadMedicines() {
        let realm = try! Realm()
        medicineDataModel = Array(realm.objects(MedicineDataModel.self))
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicineDataModel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! MedicineAdditionTableViewCell
        let medicine = medicineDataModel[indexPath.row]
        cell.medicineName.text = medicine.medicineName
        cell.unitLabel.text = medicine.label
        cell.textField.text = "\(medicine.doseNumber)"
        
        
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        
        cell.selectionStyle = .none // セルを選択したときに色が変わらないようにする
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            // 新しく選択された場合はチェックマークを付ける
            cell.accessoryType = .checkmark
            selectedIndexPaths.append(indexPath)
            selectedCellButton()
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            // 選択が解除された場合はチェックマークを外す
            cell.accessoryType = .none
            selectedIndexPaths.removeAll { $0 == indexPath }
            selectedCellButton()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0 // セルの高さ
    }
    @IBAction func medicineAdditionButton(_ sender: UIButton) {
        let record = MedicineRecordDataModel()
        let realm = try! Realm()
        
        let currentDate = Date()
        
        let dateFormatter = DateFormatter()
           dateFormatter.locale = Locale(identifier: "ja_JP")
           dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
           dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
           
           // 現在日時をフォーマットした文字列に変換
        let timeString = dateFormatter.string(from: currentDate)
           
        let formattedDate = dateFormatter.date(from: timeString)!
        
        // 選択されたインデックスパスからセルを取得
        for indexPath in selectedIndexPaths {
            if let cell = tableView.cellForRow(at: indexPath) as? MedicineAdditionTableViewCell {
                
                try! realm.write {
                // セルの情報をデータモデルに保存
                record.medicineName = cell.medicineName.text ?? ""
                record.unit = cell.unitLabel.text ?? ""
                if let doseNumber = Int(cell.textField.text ?? "") {
                    record.textField = doseNumber
                }
                record.timePicker = cell.timePicker.date
                
                    realm.add(record, update: .modified)
                }
                
                let savedData = realm.objects(MedicineRecordDataModel.self).filter("medicineName = %@ AND timePicker = %@", record.medicineName, record.timePicker)
                for data in savedData {
//                    print("Saved MedicineRecordDataModel: \(data) 保存完了") // 正常
                }
                
                
                
                if let calendarVC = self.storyboard?.instantiateViewController(withIdentifier: "CalendarViewController") as? CalendarViewController {
                    calendarVC.selectedDate = cell.timePicker.date
                    self.navigationController?.pushViewController(calendarVC, animated: true)
                }
            }
        }
        delegate?.didSaveMedicineRecord(record)
        dismiss(animated: true, completion: nil) // モーダル画面を閉じる
        
        guard let myMedicineInfo = myMedicineInformation else { return }
                
                // テーブルビューから `MedicineAdditionTableViewCell` を取得
        if let indexPath = tableView.indexPathForSelectedRow {
            if let cell = tableView.cellForRow(at: indexPath) as? MedicineAdditionTableViewCell {
                let addedAmount = cell.addedAmount // 追加量の取得
                
                // `stock` を更新
                if let stockText = myMedicineInfo.stock.text, let currentStock = Int(stockText) {
                    let updatedStock = currentStock - addedAmount
                    // 更新後の `stock` を表示するなどの処理を追加する
                    print("Updated stock: \(String(describing: myMedicineInfo.stock))")
                    myMedicineInfo.stock.text = "\(updatedStock)"
                }
            }
        }
    }
    private func selectedCellButton() {
        medicineAdditionButton.isEnabled = !selectedIndexPaths.isEmpty
    }
    private func buttonSetup() {
        medicineAdditionButton.backgroundColor = UIColor.clear // 背景色
        medicineAdditionButton.layer.borderWidth = 2.0 // 枠線の幅
        medicineAdditionButton.layer.borderColor = UIColor.blue.cgColor // 枠線の色
        medicineAdditionButton.layer.cornerRadius = 10.0 // 角丸のサイズ
        medicineAdditionButton.tintColor = UIColor.blue
    }
}

extension MedicineAdditionViewController: AdditionButtonCellDelegate {
    func didTapAdditionButton(in cell: AdditionButtonCell) {
    }
}
extension MedicineAdditionViewController: MedicineViewControllerDelegate {
    func didSaveMedicine(_ medicine: MedicineDataModel) {
        medicineDataModel.append(medicine)
        loadMedicines()
        tableView.reloadData()
    }
    func didDeleteMedicine(_ medicine: MedicineDataModel) {
        medicineDataModel.append(medicine)
        loadMedicines()
        tableView.reloadData()
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "FecesRecord" {
//            // 2. 遷移先のViewControllerを取得
//            let next = segue.destination as? FecesRecordViewController
//            // 3. １で用意した遷移先の変数に値を渡す
//            next?.selectedDate = selectedDate
//        }
//    }
}
