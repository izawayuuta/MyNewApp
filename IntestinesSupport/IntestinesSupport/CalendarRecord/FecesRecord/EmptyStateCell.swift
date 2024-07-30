//
//  EmptyStateCell.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/07/20.
//

import UIKit

class EmptyStateCell: UITableViewCell {
    
    @IBOutlet weak var messageLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
