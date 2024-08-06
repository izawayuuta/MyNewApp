//
//  FecesConditionCell.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/07/12.
//

import UIKit

class FecesConditionCell: UITableViewCell {
    
    @IBOutlet weak var number1Button: UIButton! // 便の状態
    @IBOutlet weak var number2Button: UIButton!
    @IBOutlet weak var number3Button: UIButton!
    @IBOutlet weak var number4Button: UIButton!
    @IBOutlet weak var number5Button: UIButton!
    
    var selectedButton: UIButton?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let fecesCondition: [UIButton] = [number1Button, number2Button, number3Button, number4Button, number5Button]
        fecesConditionButtons(fecesCondition)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    func fecesConditionButtons(_ buttons: [UIButton]) {
        for button in buttons {
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .white
            button.tintColor = .black
            button.layer.borderWidth = 1.0
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.cornerRadius = 5.0
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }
        
    }
    @objc func buttonTapped(_ sender: UIButton) {
            sender.backgroundColor = .orange
            if let selectedButton = self.selectedButton, selectedButton != sender {
                selectedButton.backgroundColor = .white
            }
            self.selectedButton = sender
        }
}
