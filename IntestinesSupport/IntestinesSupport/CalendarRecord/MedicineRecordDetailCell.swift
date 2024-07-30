//
//  medicineRecordDetailCell.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/07/12.
//

import UIKit

class medicineRecordDetailCell: UITableViewCell {

    @IBOutlet weak var medicineName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var unit: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
