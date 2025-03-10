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
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
