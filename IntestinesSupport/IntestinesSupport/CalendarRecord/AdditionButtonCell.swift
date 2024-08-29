//
//  AdditionButtonCell.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/07/12.
//

import UIKit

protocol AdditionButtonCellDelegate: AnyObject {
    func didTapAdditionButton(in cell: AdditionButtonCell)
}

class AdditionButtonCell: UITableViewCell {
        
    @IBOutlet weak var additionButton: UIButton!
    
    weak var delegate: AdditionButtonCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        additionButton.addTarget(self, action: #selector(additionButtonTapped(_:)), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func additionButtonTapped(_ sender: UIButton) {
        delegate?.didTapAdditionButton(in: self)
    }
}
