//
//  MessageTableViewCell.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/10/20.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var supportImageView: UIImageView!
    @IBOutlet weak var supportImageView2: UIImageView!
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let privacyPolicyImage = UIImage(named: "Setting.Support1-2")?.withRenderingMode(.alwaysTemplate)
        supportImageView.image = privacyPolicyImage
        supportImageView.tintColor = UIColor.blue
        
        supportImageView2.image = UIImage(named: "Setting.arrow")
        
        // ストーリーボードで設定されたテキストを取得
                let fullText = label.text ?? ""
                
                // Attributed Stringの作成
                let attributedString = NSMutableAttributedString(string: fullText)
                // 変更したい部分の範囲を指定
                let range = (fullText as NSString).range(of: "不要")
                // 属性を設定
                attributedString.addAttribute(.foregroundColor, value: UIColor.red, range: range)
                // UILabelに設定
                label.attributedText = attributedString
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
