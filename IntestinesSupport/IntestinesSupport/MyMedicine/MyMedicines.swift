//
//  MyMedicines.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/08/06.
//

import UIKit

class MyMedicines {
    static var sharedPickerData2: [String] = []  // 共有の配列
    
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
