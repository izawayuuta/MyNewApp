//
//  MoneyCell.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/07/22.
//

import UIKit
import RealmSwift

class MoneyCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField01: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField01.delegate = self
        
        textField01.keyboardType = UIKeyboardType.numberPad
        
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
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
        textField01.inputAccessoryView = toolBar
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 各フィールドの最大文字数
        let maxMoneyLength = 5
        
        // 入力済みの文字と入力された文字を合わせて取得.
        let currentText = (textField.text ?? "") as NSString
        let updatedText = currentText.replacingCharacters(in: range, with: string)
        
        // テキストフィールドごとの文字数制限
        switch textField {
        case textField:
            return updatedText.count <= maxMoneyLength
        default:
            return true
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        let inputValue = textField01.text ?? ""
        let convertedValue = Int(inputValue) ?? 0
        // Realmにデータを保存するロジック
        let realm = try! Realm()
        try! realm.write {
            // 保存するデータモデルの取得
            let certificate = CertificateDataModel()
            certificate.textField01 = Int(textField01.text ?? "") ?? 3
            realm.add(certificate, update: .modified)
        }
        //        let realm = try! Realm()
        //
        //            try! realm.write {
        //                if let existingCertificate = realm.objects(CertificateDataModel.self).first {
        //                    existingCertificate.textField01 = convertedValue
        //                } else {
        //                    let certificate = CertificateDataModel()
        //                    certificate.textField01 = convertedValue
        //                    realm.add(certificate, update: .modified)
        //                }
        //            }
        //        print("💾 保存された値: \(convertedValue)")
        //
        //        }
    }
}
