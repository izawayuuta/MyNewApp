//
//  PlusButtonCell.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/07/22.
//

import UIKit

protocol PlusButtonCellDelegate: AnyObject {
    func didTapPlusButton(in cell: PlusButtonCell)
}

class PlusButtonCell: UITableViewCell {
    
    @IBOutlet weak var plusButton: UIButton!
    
    weak var delegate: PlusButtonCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @objc private func plusButtonTapped() {
        delegate?.didTapPlusButton(in: self)
    }
}
