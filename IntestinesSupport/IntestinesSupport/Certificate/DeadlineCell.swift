//
//  DeadlineCell.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/07/22.
//

import UIKit
import RealmSwift

class DeadlineCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var year: UITextField!
    @IBOutlet weak var month: UITextField!
    @IBOutlet weak var day: UITextField!
    @IBOutlet weak var year2: UITextField!
    @IBOutlet weak var month2: UITextField!
    @IBOutlet weak var day2: UITextField!
    
    var certificateId: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        year.tag = 1
        
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        
        year.delegate = self
        month.delegate = self
        day.delegate = self
        year2.delegate = self
        month2.delegate = self
        day2.delegate = self
        
        year.keyboardType = UIKeyboardType.numberPad
        month.keyboardType = UIKeyboardType.numberPad
        day.keyboardType = UIKeyboardType.numberPad
        year2.keyboardType = UIKeyboardType.numberPad
        month2.keyboardType = UIKeyboardType.numberPad
        day2.keyboardType = UIKeyboardType.numberPad
        
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
        let commitButton = UIBarButtonItem(title: "保存", style: .done, target: self, action: #selector(tapDoneButton))
        toolBar.items = [commitButton]
        year.inputAccessoryView = toolBar
        month.inputAccessoryView = toolBar
        day.inputAccessoryView = toolBar
        year2.inputAccessoryView = toolBar
        month2.inputAccessoryView = toolBar
        day2.inputAccessoryView = toolBar
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 各フィールドの最大文字数
        let maxYearLength = 4
        let maxMonthLength = 2
        let maxDayLength = 2
        
        // 入力済みの文字と入力された文字を合わせて取得.
        let currentText = (textField.text ?? "") as NSString
        let updatedText = currentText.replacingCharacters(in: range, with: string)
        
        // テキストフィールドごとの文字数制限
        switch textField {
        case year, year2:
            return updatedText.count <= maxYearLength
        case month, month2:
            return updatedText.count <= maxMonthLength
        case day, day2:
            return updatedText.count <= maxDayLength
        default:
            return true
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let inputValue = textField.text, let convertedValue = Int(inputValue) else { return }

        let realm = try! Realm()

        try! realm.write {
            if let id = certificateId {
                // id で既存のデータを検索
                if let certificate = realm.object(ofType: CertificateDataModel.self, forPrimaryKey: id) {
                    // テキストフィールドによって異なるプロパティを更新
                    switch textField {
                    case year:
                        certificate.year = convertedValue
                    case month:
                        certificate.month = convertedValue
                    case day:
                        certificate.day = convertedValue
                    case year2:
                        certificate.year2 = convertedValue
                    case month2:
                        certificate.month2 = convertedValue
                    case day2:
                        certificate.day2 = convertedValue
                    default:
                        break
                    }
                } else {
                    // データが存在しない場合は新規作成
                    let newCertificate = CertificateDataModel()
                    newCertificate.id = id // 既存の ID を設定
                    
                    // テキストフィールドによって異なるプロパティを設定
                    switch textField {
                    case year:
                        newCertificate.year = convertedValue
                    case month:
                        newCertificate.month = convertedValue
                    case day:
                        newCertificate.day = convertedValue
                    case year2:
                        newCertificate.year2 = convertedValue
                    case month2:
                        newCertificate.month2 = convertedValue
                    case day2:
                        newCertificate.day2 = convertedValue
                    default:
                        break
                    }
                    
                    realm.add(newCertificate, update: .modified)
                }
            }
        }
    }
}
