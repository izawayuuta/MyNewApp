//
//  MedicineRecordDetailCell.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/07/12.
//

import UIKit

class MedicineRecordDetailCell: UITableViewCell {
    
    @IBOutlet weak var medicineName: UILabel!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var unit: UILabel!
    
//    private var model: CalendarDataModel?
//    private var selectedDate: Date?
    weak var delegate: CalendarViewControllerDelegate?
    
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
    
//    func saveData() { // ok
//        print("Model: \(String(describing: model))") // nil
//        print("SelectedDate: \(String(describing: selectedDate))") // nil
//        // modelがnilではない場合(Realmデータの編集)
//        if let model = model { // ok
//            // 更新したデータを保存する
//            let editModel = makeEditCalendarDataModel(medicineName: medicineName.text ?? "", selectedTime: selectedTime, model: model)
//            delegate?.saveCalendarData(editModel)
//            print("EditModel: \(editModel)")
//        } else {
//            // modelがnilの場合は新規作成のため、ここでModelを作成してそれを保存する
//            guard let selectedDate = selectedDate else { return } // ok
//            let newModel = makeNewCalendarDataModel(selectedDate: selectedDate, medicineName: medicineName.text ?? "", selectedTime: selectedTime)
//            delegate?.saveCalendarData(newModel)
//            print("NewModel: \(newModel)")
//        }
//    }
//    
//    private func makeEditCalendarDataModel(medicineName: String, selectedTime: Date, model: CalendarDataModel) -> CalendarDataModel {
//        // 既存モデルの編集
//        return CalendarDataModel(
//            id: model.id,
//            date: model.date,
//            selectedPhysicalConditionIndex: model.selectedPhysicalConditionIndex,
//            selectedFecesConditionIndex: model.selectedFecesConditionIndex,
//            medicineRecord: MedicineRecordDataModel(id: model.medicineRecord?.id ?? UUID().uuidString, date: Date(), medicineName: medicineName, timePicker: selectedTime, textField: Int(textField.text ?? "0") ?? 0, unit: unit.text ?? ""),
//            memo: model.memo
//        )
//    }
//    
//    private func makeNewCalendarDataModel(selectedDate: Date, medicineName: String, selectedTime: Date) -> CalendarDataModel {
//        // 新しいモデルを作成
//        let newModel = CalendarDataModel()
//        newModel.date = selectedDate
//        newModel.medicineRecord = MedicineRecordDataModel(id: UUID().uuidString, date: Date(), medicineName: medicineName, timePicker: selectedTime, textField: Int(textField.text ?? "0") ?? 0, unit: unit.text ?? "")
//        return newModel
//    }
//    
//    func configure(medicineRecord: MedicineRecordDataModel?, model: CalendarDataModel? = nil, selectedDate: Date) {
//        self.model = model
//        self.selectedDate = selectedDate
//        
//        if let medicineRecord = medicineRecord { // ok
//            print("Medicine Name: \(medicineRecord.medicineName)")
//            print("Text Field: \(medicineRecord.textField)")
//            print("Unit: \(medicineRecord.unit)")
//            print("Time Picker Date: \(medicineRecord.timePicker)")
//            // 保存された薬の名前と時間を表示
//            medicineName.text = medicineRecord.medicineName
//            textField.text = "\(medicineRecord.textField)"
//            unit.text = medicineRecord.unit
//            timePicker.date = medicineRecord.timePicker
//            //        } else {
//            //            // 新規の場合の初期設定
//            //            medicineName.text = ""
//            //            textField.text = ""
//            //            unit.text = ""
//            //            timePicker.date = Date() // デフォルトの時間を設定
//        }
//    }
}
