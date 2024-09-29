//
//  MyMedicines.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/08/06.
//

import UIKit

class MyMedicines {
    static var sharedPickerData2: [String] = ["錠", "包", "個", "ml", "mg"]  // 共有の配列
    
    var medicineName: String?
    var doseNumber: Double?
    var stock: Double?
    var url: String?
    var memo: String?
    var datePickerTextField: String?
    var textField: String?
    var customPickerTextField: String?
    var pickerView1: Int?
    var pickerView2: String?
    var datePicker: Date?
    
    init(medicineName: String, doseNumber: Double, stock: Double, url: String, memo: String, datePickerTextField: String, textField: String, customPickerTextField: String, pickerView1: Int, pickerView2: String, datePicker: Date) {
        self.medicineName = medicineName
        self.doseNumber = doseNumber
        self.stock = stock
        self.url = url
        self.memo = memo
        self.datePickerTextField = datePickerTextField
        self.textField = textField
        self.customPickerTextField = customPickerTextField
        self.pickerView1 = pickerView1
        self.pickerView2 = pickerView2
        self.datePicker = datePicker
    }
}
extension MyMedicines {
    // 新しい項目を追加するメソッド
    static func addPickerData(item: String) {
        sharedPickerData2.append(item)
        savePickerData()
    }
    
    // 指定したインデックスの項目を削除するメソッド
    static func removePickerData(at index: Int) {
        guard index >= 0 && index < sharedPickerData2.count else { return }
        print("Before remove: \(sharedPickerData2)")

        sharedPickerData2.remove(at: index)
        print("After remove: \(sharedPickerData2)")
        savePickerData()
    }
    // UserDefaults にデータを保存するメソッド
    static func savePickerData() {
        UserDefaults.standard.set(sharedPickerData2, forKey: "pickerData")
        UserDefaults.standard.synchronize() // 追加でデータの同期を確実に行う（必須ではないが安全のため）
            print("PickerData saved: \(sharedPickerData2)") // デバッグ用に出力
    }
    // UserDefaults からデータを読み込むメソッド
    static func loadPickerData() {
        if let savedData = UserDefaults.standard.array(forKey: "pickerData") as? [String] {
            print("PickerData loaded: \(sharedPickerData2)")
            sharedPickerData2 = savedData
        }
    }
}
