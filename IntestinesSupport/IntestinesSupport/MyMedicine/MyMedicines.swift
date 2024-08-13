//
//  MyMedicines.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/08/06.
//

import UIKit

class MyMedicines {
    
   var medicineName: String?
   var doseNumber: Int?
   var stock: Int?
   var url: String?
   var memo: String?
   var datePickerTextField: String?
   var textField: String?
   var customPickerTextField: String?
    var pickerView1: Int?
    var pickerView2: String?
    var datePicker: Date?

    init(medicineName: String, doseNumber: Int, stock: Int, url: String, memo: String, datePickerTextField: String, textField: String, customPickerTextField: String, pickerView1: Int, pickerView2: String, datePicker: Date) {
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
