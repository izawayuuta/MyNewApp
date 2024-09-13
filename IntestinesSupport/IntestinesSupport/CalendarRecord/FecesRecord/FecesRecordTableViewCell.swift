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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        updateCount()
        loadTimePickerDate() // 保存された時間を読み込む
        timePicker.addTarget(self, action: #selector(timePickerChanged(_:)), for: .valueChanged) // 値が変更された時のアクションを追加
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    let verticalLine: UIView = {
        let view = UIView()
        view.backgroundColor = .gray  // 縦線の色
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createLines()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createLines()
    }
    
    private func createLines() {
        
        let line1 = createLine()
        let line2 = createLine()
        
        contentView.addSubview(line1)
        contentView.addSubview(line2)
        
        let lineWidth: CGFloat = 1
        let spacing: CGFloat = 196 // ライン間の間隔
        
        line1.translatesAutoresizingMaskIntoConstraints = false
        line2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            // line1 の制約
            line1.widthAnchor.constraint(equalToConstant: lineWidth),
            line1.topAnchor.constraint(equalTo: contentView.topAnchor),
            line1.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            line1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 100),
            
            // line2 の制約
            line2.widthAnchor.constraint(equalToConstant: lineWidth),
            line2.topAnchor.constraint(equalTo: contentView.topAnchor),
            line2.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            line2.leadingAnchor.constraint(equalTo: line1.trailingAnchor, constant: spacing),
            
        ])
    }
    // ラインビューを作成するヘルパーメソッド
    private func createLine() -> UIView {
        let line = UIView()
        line.backgroundColor = .black // ラインの色
        return line
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
        
        print("Configured cell with time: \(time), count: \(count)")
    }
    func updateCount() {
        currentCount += 1
        countLabel.text = "\(currentCount)"
    }
    @objc private func timePickerChanged(_ sender: UIDatePicker) {
        saveTimePickerDate(sender.date) // 時間を保存する
        delegate2?.didChangeTime(for: self, newTime: sender.date) // デリゲートメソッドを呼び出す
    }
    private func saveTimePickerDate(_ date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let timeString = dateFormatter.string(from: date)
        UserDefaults.standard.set(timeString, forKey: "savedTime")
    }
    // 保存された時間を読み込むメソッド
    private func loadTimePickerDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        if let timeString = UserDefaults.standard.string(forKey: "savedTime"),
           let savedDate = dateFormatter.date(from: timeString) {
            timePicker.date = savedDate
            print("変更された時間: \(timeString)")
        } else {
            timePicker.date = Date() // 保存された時間がない場合は現在の時間をセット
        }
    }
}
