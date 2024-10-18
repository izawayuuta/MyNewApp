//
//  SetupTableViewCell.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/10/16.
//

import UIKit

class SetupTableViewCell: UITableViewCell {
    
    @IBOutlet weak var supportImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let privacyPolicyImage = UIImage(named: "Setting.Setup")?.withRenderingMode(.alwaysTemplate)
        supportImageView.image = privacyPolicyImage
        supportImageView.tintColor = UIColor.blue
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
