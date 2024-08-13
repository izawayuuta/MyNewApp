//
//  MedicineTableViewCell.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/08/06.
//

import UIKit

class MedicineTableViewCell: UITableViewCell {
    @IBOutlet weak var medicineNameLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var stockNumberLabel: UILabel!
    @IBOutlet weak var stockUnitLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        medicineNameLabel.numberOfLines = 1 // 1行で表示する
        stockLabel.numberOfLines = 1 // 1行で表示する
        stockNumberLabel.numberOfLines = 1 // 1行で表示する
        stockUnitLabel.numberOfLines = 1 // 1行で表示する
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
