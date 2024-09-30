//
//  MedicineRecordDetailCell.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/07/12.
//

import UIKit

protocol MedicineRecordDetailCellDelegate: AnyObject {
    func didChangeData(for cell: MedicineRecordDetailCell, newTime: Date)
    func didChangeTextData(for cell: MedicineRecordDetailCell, newText: Double)
}

class MedicineRecordDetailCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var medicineName: UILabel!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var unit: UILabel!
    
    weak var delegate: CalendarViewControllerDelegate?
    weak var delegate2: MedicineRecordDetailCellDelegate?
    var inputString: String = "" // 入力中の文字列を保持するためのプロパティ
    
    var selectedTime: Date {
        return timePicker.date
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textField.keyboardType = .decimalPad
        
        textField.delegate = self
        
        layoutSubviews()
        setupCell(borderColor: .gray)
        loadTimePickerDate()
        loadTextFieldDate()
        doneButton()
        timePicker.addTarget(self, action: #selector(timePickerChanged(_:)), for: .valueChanged) // 値が変更された時のアクションを追加
        textField.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // セルの横幅を調整する
        var frame = self.contentView.frame
        frame.size.width = UIScreen.main.bounds.width - 40 // 画面の幅から40ポイント引いたサイズに設定
        frame.origin.x = 20 // 左端から20ポイント内側に配置
        self.contentView.frame = frame
    }
    
    func setupCell(borderColor: UIColor) {
        contentView.layer.borderWidth = 1.5
        contentView.layer.borderColor = borderColor.cgColor
        contentView.layer.cornerRadius = 8.0
        contentView.clipsToBounds = true
    }
    
    private func formatDate(_ date: Date?) -> String {
        guard let date = date else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    @objc private func timePickerChanged(_ sender: UIDatePicker) {
        saveTimePickerDate(sender.date) // 時間を保存する
        delegate2?.didChangeData(for: self, newTime: sender.date)
    }
    
    private func saveTimePickerDate(_ date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let timeString = dateFormatter.string(from: date)
        UserDefaults.standard.set(timeString, forKey: "savedTime") // 軽量な永続ストレージ（保存）
    }
    
    private func loadTimePickerDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        if let timeString = UserDefaults.standard.string(forKey: "savedTime"),
           let savedDate = dateFormatter.date(from: timeString) {
            timePicker.date = savedDate
        } else {
            timePicker.date = Date() // 保存された時間がない場合は現在の時間をセット
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 現在のテキストを取得
        guard let currentText = textField.text else { return true }
        // 新しいテキストを取得
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        // 小数点が2個以上含まれないかチェック
        let decimalCount = newText.components(separatedBy: ".").count - 1
        if decimalCount > 1 {
            return false // 小数点が2個以上の場合は変更を許可しない
        }
        return true
    }
    
    @objc private func textFieldChanged(_ sender: UITextField) {
        if let text = sender.text {
            inputString = text
        }
    }
    
    @objc private func dismissKeyboard() {
        if inputString.isEmpty {
            // 空白の場合は0を代入
            inputString = "0"
        }
        // 入力中の文字列を Double に変換
        if let newValue = Double(inputString) {
            if newValue.truncatingRemainder(dividingBy: 1) == 0 {
                // 整数の場合は整数として保存
                let intValue = Int(newValue)
                textField.text = String(intValue) // 整数として表示
                saveTextFieldDate(intValue)
                delegate2?.didChangeTextData(for: self, newText: Double(intValue))
            } else {
                // 小数の場合はそのまま表示
                textField.text = String(newValue) // 小数としてそのまま表示
                saveTextFieldDate(Int(newValue))
                delegate2?.didChangeTextData(for: self, newText: newValue)
            }
        }
        textField.resignFirstResponder()
    }
    
    private func saveTextFieldDate(_ text: Int) {
        UserDefaults.standard.set(text, forKey: "savedText") // 軽量な永続ストレージ（保存）
    }
    
    private func loadTextFieldDate() {
        if let savedText = UserDefaults.standard.value(forKey: "savedText") as? Double {
            // 保存されたテキストを表示形式に応じて整える
            if savedText == Double(Int(savedText)) {
                textField.text = "\(Int(savedText))" // 整数として表示
            } else {
                textField.text = "\(savedText)" // 小数としてそのまま表示
            }
        } else {
            textField.text = "0" // 保存されたテキストがない場合は0を表示
        }
    }
    
    private func doneButton() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let closeButton = UIBarButtonItem(title: "閉じる", style: .done, target: self, action: #selector(dismissKeyboard))
        toolbar.items = [closeButton]
        textField.inputAccessoryView = toolbar
    }
    
    func configure(medicineName: String, timePicker: Date, text: String, unit: String) {
        self.medicineName.text = medicineName
        self.unit.text = unit
        self.timePicker.date = timePicker
        if let doseValue = Double(text) {
            if doseValue.truncatingRemainder(dividingBy: 1) == 0 {
                // 整数の場合は Int に変換して表示
                self.textField.text = String(Int(doseValue))
            } else {
                // 小数の場合はそのまま表示
                self.textField.text = String(doseValue) // Double 型として表示
            }
        }
    }
}
