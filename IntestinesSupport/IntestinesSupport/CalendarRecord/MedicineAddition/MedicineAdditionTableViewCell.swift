//
//  MedicineAdditionTableViewCell.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/08/28.
//

import UIKit

class MedicineAdditionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var medicineName: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        doneButton()
        setupCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    private func doneButton() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let closeButton = UIBarButtonItem(title: "閉じる", style: .done, target: self, action: #selector(dismissKeyboard))
        toolbar.items = [closeButton]
        textField.inputAccessoryView = toolbar
    }
    @objc private func dismissKeyboard() {
        textField.resignFirstResponder()
    }
    // 枠線
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // セルの横幅を調整する
        var frame = self.contentView.frame
        frame.size.width = UIScreen.main.bounds.width - 55 // 画面の幅から40ポイント引いたサイズに設定
        frame.origin.x = 5 // 左端から20ポイント内側に配置
        self.contentView.frame = frame
        
    }
    private func setupCell() {
        contentView.layer.borderWidth = 1.5
        contentView.backgroundColor = UIColor.systemYellow
        contentView.layer.borderColor = UIColor.orange.cgColor
        contentView.layer.cornerRadius = 10.0
    }
}
