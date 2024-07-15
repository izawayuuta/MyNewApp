//
//  fecesDetailCell.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/07/13.
//

import UIKit

class fecesDetailCell: UITableViewCell {
    
    @IBOutlet weak var fecesDetail1: UIButton!
    @IBOutlet weak var fecesDetail2: UIButton!
    @IBOutlet weak var fecesDetail3: UIButton!
    @IBOutlet weak var fecesDetail4: UIButton!
    @IBOutlet weak var fecesDetail5: UIButton!
    @IBOutlet weak var fecesDetail6: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let fecesDetail: [UIButton] = [fecesDetail1, fecesDetail2, fecesDetail3, fecesDetail4, fecesDetail5, fecesDetail6]
        fecesDetailButtons(fecesDetail)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func fecesDetailButtons(_ buttons: [UIButton]) {
        for button in buttons {
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .white
            button.tintColor = .black
            button.layer.borderWidth = 2.0
            button.layer.borderColor = UIColor(red: 0.23, green: 0.55, blue: 0.35, alpha: 1.0).cgColor
            button.layer.cornerRadius = 5.0
        }
    }
}
