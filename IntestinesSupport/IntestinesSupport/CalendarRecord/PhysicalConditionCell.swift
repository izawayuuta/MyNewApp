//
//  PhysicalConditionCell.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/07/16.
//

import UIKit

class PhysicalConditionCell: UITableViewCell {
    
    @IBOutlet weak var number01Button: UIButton!
    @IBOutlet weak var number02Button: UIButton!
    @IBOutlet weak var number03Button: UIButton!
    @IBOutlet weak var number04Button: UIButton!
    @IBOutlet weak var number05Button: UIButton!
    
    var selectedButton: UIButton?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let physicalCondition: [UIButton] = [number01Button, number02Button, number03Button, number04Button, number05Button]
        physicalConditionButtons(physicalCondition)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func physicalConditionButtons(_ buttons: [UIButton]) {
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
            sender.backgroundColor = .systemYellow
            if let selectedButton = self.selectedButton, selectedButton != sender {
                selectedButton.backgroundColor = .white
            }
            self.selectedButton = sender
        }
}
