//
//  FecesRecordTableViewCell.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/08/14.
//

import UIKit
protocol FecesDetailTableViewCellDelegate: AnyObject {
    func didChangeTime(for cell: FecesRecordTableViewCell, newTime: Date)
}

class FecesRecordTableViewCell: UITableViewCell {
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    weak var delegate: FecesDetailCellDelegate?
    weak var delegate2: FecesDetailTableViewCellDelegate?
    private var currentCount: Int = 0
    var timePickerConstraints: [NSLayoutConstraint] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateCount()
        setupTimePicker()
        loadTimePickerDate() // 保存された時間を読み込む
        timePicker.addTarget(self, action: #selector(timePickerChanged(_:)), for: .valueChanged) // 値が変更された時のアクションを追加
    }
    
    func configure(with record: [FecesDetailType], time: String, count: [Int]) {
        
        record.forEach { record in
            switch record {
            case .hardFeces:
                label1.textColor = .red
            case .normalFeces:
                label2.textColor = .red
            case .diarrhea:
                label3.textColor = .red
            case .constipation:
                label4.textColor = .red
            case .softFeces:
                label5.textColor = .red
            case .bloodyFeces:
                label6.textColor = .red
            }
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        if let timeDate = dateFormatter.date(from: time) {
            timePicker.date = timeDate
        } else {
            timePicker.date = Date()
        }
        let countString = count.map { String($0) }.joined(separator: ", ")
        countLabel.text = countString
    }
    
    func updateCount() {
        currentCount += 1
        countLabel.text = "\(currentCount)"
    }
    
    @objc private func timePickerChanged(_ sender: UIDatePicker) {
        saveTimePickerDate(sender.date) // 時間を保存する
        delegate2?.didChangeTime(for: self, newTime: sender.date)
        hideTimePicker()
        showTimePicker()
    }
    // ピッカーを非表示
    func hideTimePicker() {
        timePicker?.removeFromSuperview()
        timePickerConstraints.forEach { $0.isActive = false }
    }
    // ピッカーを再表示
    func showTimePicker() {
        guard timePicker != nil else { return }
        // ピッカーを表示
        self.addSubview(timePicker)
        // 制約を再適用
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        if timePickerConstraints != nil {
            NSLayoutConstraint.activate(timePickerConstraints)
        }
        // レイアウトを更新
        self.layoutIfNeeded()
    }
    // ピッカー再表示後のレイアウトの設定
    func setupTimePicker() {
        if timePicker == nil {
            timePicker = UIDatePicker()
            timePicker.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(timePicker)
        }
        timePickerConstraints = [
            timePicker.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -13),
            timePicker.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ]
        NSLayoutConstraint.activate(timePickerConstraints)
    }
    private func saveTimePickerDate(_ date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let timeString = dateFormatter.string(from: date)
        UserDefaults.standard.set(timeString, forKey: "savedTime") // 軽量な永続ストレージ（保存）
    }
    // 保存された時間を読み込むメソッド
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
}
