//
//  physicalConditionCell.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/07/11.
//

import UIKit

class physicalConditionCell: UITableViewCell {

    @IBOutlet weak var physicalCondition: UILabel!
    @IBOutlet weak var evaluation1Button: UIButton!
    @IBOutlet weak var evaluation2Button: UIButton!
    @IBOutlet weak var evaluation3Button: UIButton!
    @IBOutlet weak var evaluation4Button: UIButton!
    @IBOutlet weak var evaluation5Button: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
