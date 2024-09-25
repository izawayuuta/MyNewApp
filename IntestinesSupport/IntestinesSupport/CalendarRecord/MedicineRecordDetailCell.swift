//
//  MedicineRecordDetailCell.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/07/12.
//

import UIKit

protocol MedicineRecordDetailCellDelegate: AnyObject {
    func didChangeData(for cell: MedicineRecordDetailCell, newTime: Date)
    func didChangeTextData(for cell: MedicineRecordDetailCell, newText: Int)
}

class MedicineRecordDetailCell: UITableViewCell {
    
    @IBOutlet weak var medicineName: UILabel!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var unit: UILabel!
    
//    private var model: CalendarDataModel?
//    private var selectedDate: Date?
    weak var delegate: CalendarViewControllerDelegate?
    weak var delegate2: MedicineRecordDetailCellDelegate?
    
    var selectedTime: Date {
        return timePicker.date
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //        delegateSelf()
//        saveData()
        layoutSubviews()
        setupCell()
        loadTimePickerDate()
        loadTextFieldDate()
        doneButton()
        timePicker.addTarget(self, action: #selector(timePickerChanged(_:)), for: .valueChanged) // 値が変更された時のアクションを追加
        textField.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    // 枠線
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // セルの横幅を調整する
        var frame = self.contentView.frame
        frame.size.width = UIScreen.main.bounds.width - 40 // 画面の幅から40ポイント引いたサイズに設定
        frame.origin.x = 20 // 左端から20ポイント内側に配置
        self.contentView.frame = frame
    }
    private func setupCell() {
        contentView.layer.borderWidth = 1.5
        contentView.layer.borderColor = UIColor.gray.cgColor
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
    @objc private func textFieldChanged(_ sender: UITextField) {
        if let text = sender.text, let newText = Int(text) {
            saveTextFieldDate(newText)
            delegate2?.didChangeTextData(for: self, newText: newText)
        }
    }
    private func saveTextFieldDate(_ text: Int) {
        UserDefaults.standard.set(text, forKey: "savedText") // 軽量な永続ストレージ（保存）
    }
    private func loadTextFieldDate() {
        if let savedText = UserDefaults.standard.string(forKey: "savedText") as? Int {
                textField.text = "\(savedText)"
            } else {
                textField.text = "" // 保存されたテキストがない場合は空にする
            }
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
    func configure(medicineName: String, timePicker: Date, text: String, unit: String) {
            self.medicineName.text = medicineName
        self.unit.text = unit
            self.timePicker.date = timePicker
            self.textField.text = text
        }
}
