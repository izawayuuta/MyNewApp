//
//  PeriodCell.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/07/22.
//

import UIKit
import SwiftUI
import RealmSwift

class PeriodCell: UITableViewCell, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField4: UITextField!
    @IBOutlet weak var textField5: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    
    let pickerData = ["上旬", "中旬", "下旬"]
    var currentCertificate: CertificateDataModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        
        textField1.delegate = self
        textField2.delegate = self
        textField3.delegate = self
        textField4.delegate = self
        textField5.delegate = self
        pickerView.delegate = self
        pickerView.dataSource = self
        
        textField1.keyboardType = .numberPad
        textField2.keyboardType = .numberPad
        textField3.keyboardType = .numberPad
        textField4.keyboardType = .numberPad
        textField5.keyboardType = .numberPad
        
        let realm = try! Realm()
        currentCertificate = realm.objects(CertificateDataModel.self).first
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @objc func tapDoneButton() {
        self.endEditing(true)
    }
    func setDoneButton() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        let commitButton = UIBarButtonItem(title: "閉じる", style: .done, target: self, action: #selector(tapDoneButton))
        toolBar.items = [commitButton]
        textField1.inputAccessoryView = toolBar
        textField2.inputAccessoryView = toolBar
        textField3.inputAccessoryView = toolBar
        textField4.inputAccessoryView = toolBar
        textField5.inputAccessoryView = toolBar
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 各フィールドの最大文字数
        let maxMonthLength = 2
        let maxDayLength = 2
        
        // 入力済みの文字と入力された文字を合わせて取得.
        let currentText = (textField.text ?? "") as NSString
        let updatedText = currentText.replacingCharacters(in: range, with: string)
        
        // テキストフィールドごとの文字数制限
        switch textField {
        case textField1, textField3, textField5:
            return updatedText.count <= maxMonthLength
        case textField2, textField4:
            return updatedText.count <= maxDayLength
        default:
            return true
        }
    }
    struct ContentView: View {
        @State var pickerIndex: Int = 0
        var body: some View {
            Form {
                Section {
                    Picker("季節", selection: $pickerIndex) {
                        Text("上旬").tag(0)
                        Text("中旬").tag(1)
                        Text("下旬").tag(2)
                    }
                    .pickerStyle(.menu)
                }
            }
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Realm のインスタンスを取得
        let realm = try! Realm()

        // 既存のデータモデルがあるか確認
        if let certificate = realm.objects(CertificateDataModel.self).first {
            // 既存のデータがあれば更新
            try! realm.write {
                certificate.pickerView = row
                realm.add(certificate, update: .modified)
            }
        } else {
            // 新しいデータモデルを作成
            let newCertificate = CertificateDataModel()
            newCertificate.pickerView = row
            
            try! realm.write {
                realm.add(newCertificate)
            }
        }
    }
        func textFieldDidEndEditing(_ textField: UITextField) {
            // Realmにデータを保存するロジック
            let realm = try! Realm()
            try! realm.write {
                // 保存するデータモデルの取得
                let certificate = CertificateDataModel()
                certificate.textField1 = Int(textField.text ?? "") ?? 0
                certificate.textField2 = Int(textField.text ?? "") ?? 0
                certificate.textField3 = Int(textField.text ?? "") ?? 0
                certificate.textField4 = Int(textField.text ?? "") ?? 0
                certificate.textField5 = Int(textField.text ?? "") ?? 0
                realm.add(certificate, update: .modified)
            }
        }
    }
