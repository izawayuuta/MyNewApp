//
//  applicationClassificationCell.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/07/21.
//

import UIKit
import RealmSwift

class ApplicationClassificationCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField0: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textField0.delegate = self
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
        textField0.inputAccessoryView = toolBar
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
            // Realmにデータを保存するロジック
            let realm = try! Realm()
            try! realm.write {
                // 保存するデータモデルの取得
                let certificate = CertificateDataModel()
                certificate.textField0 = textField.text ?? ""
                realm.add(certificate, update: .modified)
            }
        }
}
