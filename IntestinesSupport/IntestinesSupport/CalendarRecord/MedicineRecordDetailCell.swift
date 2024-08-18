//
//  MedicineRecordDetailCell.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/07/12.
//

import UIKit

class MedicineRecordDetailCell: UITableViewCell {

    @IBOutlet weak var medicineName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var unit: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
        contentView.layer.borderColor = UIColor.blue.cgColor
        contentView.layer.cornerRadius = 8.0
        contentView.clipsToBounds = true
    }

}
