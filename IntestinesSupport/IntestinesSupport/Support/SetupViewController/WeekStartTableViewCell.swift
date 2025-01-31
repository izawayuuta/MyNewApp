//
//  WeekStartTableViewCell.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/10/16.
//

import UIKit

protocol WeekStartTableViewCellDelegate: AnyObject {
    func didSelectDay(at index: Int, day: String)
}

class WeekStartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pickerView: UIButton!
    
    weak var delegate: WeekStartTableViewCellDelegate?
    
    let pickerOptions = ["日", "月", "火", "水", "木", "金", "土"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pickerView.setTitle(pickerOptions[0], for: .normal)
        // ボタンにメニューを設定
        pickerView.menu = createPickerMenu()
        pickerView.showsMenuAsPrimaryAction = true // タップでメニューを表示
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func createPickerMenu() -> UIMenu {
           var actions: [UIAction] = []
           
           // ピッカーのオプションをUIActionとして追加
           for (index, option) in pickerOptions.enumerated() {
               let action = UIAction(title: option) { action in
                   // ボタンのタイトルを選択された値に変更
                   self.pickerView.setTitle(option, for: .normal)
//                   self.performAction(for: index)
                   self.delegate?.didSelectDay(at: index, day: option)
//                   print("選択された曜日: \(option) (Index: \(index))")
               }
               actions.append(action)
           }
           
           // UIMenuとして返す
           return UIMenu(title: "選択してください", children: actions)
       }
}
