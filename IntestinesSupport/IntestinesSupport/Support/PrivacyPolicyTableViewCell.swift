//
//  PrivacyPolicyTableViewCell.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/10/15.
//

import UIKit

class PrivacyPolicyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var supportImageView: UIImageView!
    @IBOutlet weak var supportImageView2: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // テンプレートモードで画像を読み込む
        let privacyPolicyImage = UIImage(named: "Setting.PrivacyPolicy")?.withRenderingMode(.alwaysTemplate)
        supportImageView.image = privacyPolicyImage
        supportImageView.tintColor = UIColor.blue
        
        supportImageView2.image = UIImage(named: "Setting.Support2")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
