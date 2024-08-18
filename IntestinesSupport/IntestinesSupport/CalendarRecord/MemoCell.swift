//
//  MemoCell.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/07/12.
//

import UIKit

class MemoCell: UITableViewCell, UITextViewDelegate {
    
    @IBOutlet weak var memoLabel: UILabel!
    @IBOutlet weak var memo: UITextView!
    
    private var model: CalendarDataModel?
    private var selectedDate: Date?
    weak var delegate: CalendarViewControllerDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        memo.delegate = self
        memo.isScrollEnabled = false
        memo.layer.borderColor = UIColor(red: 0.2, green: 0.7, blue: 0.5, alpha: 1.0).cgColor
        
        memo.layer.borderWidth = 1.0
        memo.layer.masksToBounds = true
        
        setDoneButton()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func tapDoneButton() {
        self.endEditing(true)
        saveData()
    }
    func setDoneButton() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        let commitButton = UIBarButtonItem(title: "保存", style: .done, target: self, action: #selector(tapDoneButton))
        toolBar.items = [commitButton]
        memo.inputAccessoryView = toolBar
    }
    // textViewを可変
    func textViewDidChange(_ textView: UITextView) {
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
            
            if let indexPath = tableView.indexPath(for: self) {
                tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
            
            UIView.setAnimationsEnabled(true)
        }
    }
    // キーボード追従
    @objc func keyboardWillShow(_ notification: Notification) {
        adjustForKeyboard(notification: notification, willShow: true)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        adjustForKeyboard(notification: notification, willShow: false)
    }
    
    func adjustForKeyboard(notification: Notification, willShow: Bool) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        let keyboardHeight = keyboardFrame.height
        let additionalMargin: CGFloat = -60
        let adjustmentHeight = willShow ? keyboardHeight + additionalMargin : 0
        let adjustmentInsets = UIEdgeInsets(top: 0, left: 0, bottom: adjustmentHeight, right: 0)
        
        if let tableView = superview as? UITableView {
            tableView.contentInset = adjustmentInsets
            tableView.scrollIndicatorInsets = adjustmentInsets
            
            if willShow {
                if let indexPath = tableView.indexPath(for: self) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                    }
                }
            }
        }
    }
    private func saveData(selectedIndex: String = "") {
        if let model = model {
            let editModel = makeEditCalendarDataModel(memo: memo.text, model: model)
            delegate?.saveCalendarData(editModel)
        } else {
            // 新しいモデルを作成
            guard let selectedDate = selectedDate else { return }
            let newModel = makeNewCalendarDataModel(selectedDate: selectedDate, selectedIndex: memo.text)
            delegate?.saveCalendarData(newModel)
        }
    }
    private func makeEditCalendarDataModel(memo: String, model: CalendarDataModel) -> CalendarDataModel {
        return CalendarDataModel(
            id: model.id,
            date: model.date,
            selectedPhysicalConditionIndex: model.selectedPhysicalConditionIndex,
            selectedFecesConditionIndex: model.selectedFecesConditionIndex,
            selectedFecesDetailIndex: model.selectedFecesConditionIndex,
            memo: memo
        )
    }
    
    private func makeNewCalendarDataModel(selectedDate: Date, selectedIndex: String) -> CalendarDataModel {
        // 日付とButtonのIndexをセットする
        let newModel = CalendarDataModel()
        newModel.memo = String(selectedIndex)
        newModel.date = selectedDate
        return newModel
    }
    func configure(selectedIndex: String, model: CalendarDataModel? = nil, selectedDate: Date) {
        self.model = model
        self.selectedDate = selectedDate
        
        if let model = model {
            memo.text = model.memo // 保存されているメモを表示
        } else {
            memo.text = ""
        }
    }
}
