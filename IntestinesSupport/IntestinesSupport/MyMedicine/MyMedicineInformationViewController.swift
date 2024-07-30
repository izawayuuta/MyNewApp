//
//  MyMedicineInformationViewController.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/07/15.
//

import Foundation
import SwiftUI

class MyMedicineInformation: UIViewController {
    
    @IBOutlet weak var MedicineName: UITextField!
    @IBOutlet weak var doseNumber: UITextField!
    @IBOutlet weak var stock: UITextField!
    @IBOutlet weak var URL: UITextField!
    @IBOutlet weak var memo: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        MedicineName.delegate = self
//        doseNumber.delegate = self
//        stock.delegate = self
//        URL.delegate = self
//        memo.delegate = self
        memo.layer.borderColor = UIColor(red: 0.2, green: 0.7, blue: 0.5, alpha: 1.0).cgColor
        
        memo.layer.borderWidth = 1.0
    }
    @objc func tapDoneButton() {
        self.view.endEditing(true)
    }
    func setDoneButton() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        let commitButton = UIBarButtonItem(title: "閉じる", style: .done, target: self, action: #selector(tapDoneButton))
        toolBar.items = [commitButton]
        MedicineName.inputAccessoryView = toolBar
        doseNumber.inputAccessoryView = toolBar
        stock.inputAccessoryView = toolBar
        URL.inputAccessoryView = toolBar
        memo.inputAccessoryView = toolBar
    }
    // textViewを可変
//    func textViewDidChange(_ textView: UITextView) {
//        let size = textView.sizeThatFits(CGSize(width: textView.frame.width, height: CGFloat.greatestFiniteMagnitude))
//        
////        if let tableView = self.superview as? UITableView {
////            UIView.setAnimationsEnabled(false)
////            tableView.beginUpdates()
////
//            memo.constraints.forEach { (constraint) in
//                if constraint.firstAttribute == .height {
//                    constraint.constant = size.height
//                }
//            
////            tableView.endUpdates()
//            
//            if let indexPath = view.indexPath(for: self) {
//                memo.scrollToRow(at: indexPath, at: .bottom, animated: true)
//            }
//            
//            UIView.setAnimationsEnabled(true)
//        }
//    }
//    func textViewDidChange(_ textView: UITextView) {
//            var frame = textView.frame
//            frame.size.height = textView.contentSize.height
//            textView.frame = frame
//        let height = textView.sizeThatFits(CGSize(width: textView.frame.size.width, height: CGFloat.greatestFiniteMagnitude)).height
//        textView.heightAnchor.constraint(equalToConstant: height).isActive = true
//
//        }
    // キーボード追従
//    @objc func keyboardWillShow(_ notification: Notification) {
//        adjustForKeyboard(notification: notification, willShow: true)
//    }
//    
//    @objc func keyboardWillHide(_ notification: Notification) {
//        adjustForKeyboard(notification: notification, willShow: false)
//    }
//    
//    func adjustForKeyboard(notification: Notification, willShow: Bool) {
//        guard let userInfo = notification.userInfo else { return }
//        guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
//        
//        let keyboardHeight = keyboardFrame.height
//        let additionalMargin: CGFloat = -60
//        let adjustmentHeight = willShow ? keyboardHeight + additionalMargin : 0
//        let adjustmentInsets = UIEdgeInsets(top: 0, left: 0, bottom: adjustmentHeight, right: 0)
//        memo.contentInset = adjustmentInsets
//                memo.scrollIndicatorInsets = adjustmentInsets
//                
//                if willShow {
//                    // キーボード表示後に表示領域が見えるようにする
//                    let selectedRange = memo.selectedRange
//                    memo.scrollRangeToVisible(selectedRange)
//                }
////        if let tableView = superview as? UITableView {
////            tableView.contentInset = adjustmentInsets
////            tableView.scrollIndicatorInsets = adjustmentInsets
//            
////            if willShow {
////                if let indexPath = tableView.indexPath(for: self) {
////                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
////                        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
////                }
//    }
}
