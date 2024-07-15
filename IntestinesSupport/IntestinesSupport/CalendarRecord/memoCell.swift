//
//  memoCell.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/07/12.
//

import UIKit

class memoCell: UITableViewCell, UITextViewDelegate {
    
    @IBOutlet weak var memoLabel: UILabel!
    @IBOutlet weak var memo: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        memo.delegate = self
        memo.isScrollEnabled = false
        memo.layer.borderColor = UIColor(red: 0.2, green: 0.7, blue: 0.5, alpha: 1.0).cgColor
        
        memo.layer.borderWidth = 1.0
        memo.layer.masksToBounds = true
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @objc func tapDoneButton() {
        self.endEditing(true)
    }
    func setDoneButton() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        let commitButton = UIBarButtonItem(title: "閉じる", style: .done, target: self, action: #selector(tapDoneButton))
        toolBar.items = [commitButton]
        memo.inputAccessoryView = toolBar
    }
    func textViewDidChange(_ textView: UITextView) {
            // テキストの変更を検知した際に高さを調整
            let size = textView.sizeThatFits(CGSize(width: textView.frame.width, height: CGFloat.greatestFiniteMagnitude))
            if let tableView = self.superview as? UITableView {
                UIView.setAnimationsEnabled(false)
                tableView.beginUpdates()
                textView.constraints.forEach { (constraint) in
                    if constraint.firstAttribute == .height {
                        constraint.constant = size.height
                    }
                }
                tableView.endUpdates()
                UIView.setAnimationsEnabled(true)
            }
        }
}
