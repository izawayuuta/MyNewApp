//
//  FecesDetailCell.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/07/13.
//

import UIKit

protocol FecesDetailCellDelegate: AnyObject {
    func didTapRecordButton(in cell: FecesDetailCell)
}

class FecesDetailCell: UITableViewCell {
    
    @IBOutlet weak var fecesDetail1: UIButton!
    @IBOutlet weak var fecesDetail2: UIButton!
    @IBOutlet weak var fecesDetail3: UIButton!
    @IBOutlet weak var fecesDetail4: UIButton!
    @IBOutlet weak var fecesDetail5: UIButton!
    @IBOutlet weak var fecesDetail6: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var history: UIButton!
    
    var selectedButtons: [UIButton] = []
    weak var delegate: FecesDetailCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let fecesDetail: [UIButton] = [fecesDetail1, fecesDetail2, fecesDetail3, fecesDetail4, fecesDetail5, fecesDetail6]
        fecesDetailButtons(fecesDetail)
        plusButton(plusButton)
        history.addTarget(self, action: #selector(RecordButtonTapped), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    private func fecesDetailButtons(_ buttons: [UIButton]) {
        for button in buttons {
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .white
            button.tintColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
            
            button.layer.borderWidth = 2.0
            button.layer.borderColor = UIColor(white: 0.9, alpha: 1.0).cgColor
            
            button.layer.cornerRadius = 5.0
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }
    }
    @objc func buttonTapped(_ sender: UIButton) {
        if sender.layer.borderColor == UIColor(white: 0.9, alpha: 1.0).cgColor {
            sender.layer.borderColor = UIColor(red: 0.23, green: 0.55, blue: 0.35, alpha: 1.0).cgColor
            sender.tintColor = .black
            selectedButtons.append(sender)
        } else {
            sender.layer.borderColor = UIColor(white: 0.9, alpha: 1.0).cgColor
            sender.tintColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
            if let index = selectedButtons.firstIndex(of: sender) {
                selectedButtons.remove(at: index)
            }
        }
    }
    
    private func plusButton(_ button: UIButton) {
        _ = self.plusButton.frame.width
        _ = self.plusButton.frame.height
        plusButton.setTitleColor(.black, for: .normal)
        plusButton.backgroundColor = .white
        plusButton.tintColor = .black
        plusButton.layer.cornerRadius = self.plusButton.frame.height / 2
        
        plusButton.layer.shadowColor = UIColor.black.cgColor
        plusButton.layer.shadowRadius = 3
        plusButton.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        plusButton.layer.shadowOpacity = 0.3
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    }
    @objc func plusButtonTapped() {
        for button in selectedButtons {
            button.layer.borderColor = UIColor(white: 0.9, alpha: 1.0).cgColor
            button.tintColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0)
        }
        selectedButtons.removeAll()
        showBannerMessage()
    }
    // メッセージ
    private func showBannerMessage() {
        guard let parentView = self.superview?.superview else { return }
        
        let banner = UIView()
        banner.backgroundColor = UIColor.black
        banner.alpha = 1.0
        banner.layer.cornerRadius = 10
        banner.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(banner)
        
        let messageLabel = UILabel()
        messageLabel.text = "便の状態を記録しました"
        messageLabel.textColor = .white
        messageLabel.textAlignment = .center
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        banner.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            banner.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 20),
            banner.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -20),
            banner.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -50),
            banner.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: banner.leadingAnchor, constant: 10),
            messageLabel.trailingAnchor.constraint(equalTo: banner.trailingAnchor, constant: -10),
            messageLabel.topAnchor.constraint(equalTo: banner.topAnchor, constant: 10),
            messageLabel.bottomAnchor.constraint(equalTo: banner.bottomAnchor, constant: -10)
        ])
        
        UIView.animate(withDuration: 0.3, animations: {
            banner.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: 1.0, options: [], animations: {
                banner.alpha = 0.0
            }) { _ in
                banner.removeFromSuperview()
            }
        }
    }
    @IBAction func RecordButtonTapped(_ sender: UIButton) {
        delegate?.didTapRecordButton(in: self)
    }
}
