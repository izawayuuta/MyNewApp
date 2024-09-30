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
    
    var certificateId: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField01.delegate = self
        
        textField01.keyboardType = UIKeyboardType.numberPad
        
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
    }
    
    @objc func tapDoneButton() {
        self.endEditing(true)
    }
    
    func setDoneButton() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        let commitButton = UIBarButtonItem(title: "保存", style: .done, target: self, action: #selector(tapDoneButton))
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
        guard let inputValue = textField.text, let convertedValue = Int(inputValue) else { return }
        
        let realm = try! Realm()
        
        try! realm.write {
            if let id = certificateId {
                // id で既存のデータを検索
                if let certificate = realm.object(ofType: CertificateDataModel.self, forPrimaryKey: id) {
                    // データが存在する場合は更新
                    certificate.textField01 = convertedValue
                } else {
                    // データが存在しない場合は新規作成
                    let newCertificate = CertificateDataModel()
                    newCertificate.id = id // 既存の ID を設定
                    newCertificate.textField01 = convertedValue
                    realm.add(newCertificate, update: .modified)
                }
            }
        }
    }
}
