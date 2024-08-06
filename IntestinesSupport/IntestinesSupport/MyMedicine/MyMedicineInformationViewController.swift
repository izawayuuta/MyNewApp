//
//  MyMedicineInformationViewController.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/07/15.
//

import Foundation
import SwiftUI

class MyMedicineInformation: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var medicineName: UITextField!
    @IBOutlet weak var doseNumber: UITextField!
    @IBOutlet weak var stock: UITextField!
    @IBOutlet weak var url: UITextField!
    @IBOutlet weak var memo: UITextView!
    @IBOutlet weak var datePickerTextField: UITextField!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var customPickerTextField: UITextField!
    @IBOutlet weak var label: UILabel!
    
//    var selectedOption: String?
    let pickerView1 = UIPickerView()
    let pickerView2 = UIPickerView()
    let datePicker = UIDatePicker()
    var pickerData1 = ["起床時", "食前", "食直前", "食直後", "食後", "食間", "就寝前", "頓服"]
    var pickerData2 = ["錠", "個", "包", "mg", "ml"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        medicineName.delegate = self
        doseNumber.delegate = self
        stock.delegate = self
        url.delegate = self
        memo.delegate = self
        pickerView1.delegate = self
        pickerView1.dataSource = self
        pickerView2.delegate = self
        pickerView2.dataSource = self
        
        memo.layer.borderColor = UIColor(red: 0.2, green: 0.7, blue: 0.5, alpha: 1.0).cgColor
        
        memo.layer.borderWidth = 1.0
        setDoneButton()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        createDatePicker()
        pickerView1.showsSelectionIndicator = true
        pickerView2.showsSelectionIndicator = true

        let toolbar = UIToolbar(frame: CGRectMake(0, 0, 0, 35))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(MyMedicineInformation.done))
        let customItem = UIBarButtonItem(title: "編集", style: .plain, target: self, action: #selector(showCustomOption))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems ([doneItem, flexibleSpace, customItem], animated: true)
        let toolbar2 = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 35))
                let doneItem2 = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
                toolbar2.setItems([doneItem2], animated: true)
        textField.inputView = pickerView1
        textField.inputAccessoryView = toolbar
        customPickerTextField.inputView = pickerView2
        customPickerTextField.inputAccessoryView = toolbar
        // pickerの初期表示を設定
               let initialIndex1 = 0
               pickerView1.selectRow(initialIndex1, inComponent: 0, animated: false)
               self.textField.text = pickerData1[initialIndex1]
        
        let initialIndex2 = 0
        pickerView2.selectRow(initialIndex2, inComponent: 0, animated: false)
        self.customPickerTextField.text = pickerData2[initialIndex2]
    }
    @objc func tapDoneButton() {
        self.view.endEditing(true)
    }
    func setDoneButton() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        let commitButton = UIBarButtonItem(title: "閉じる", style: .done, target: self, action: #selector(tapDoneButton))
        toolBar.items = [commitButton]
        medicineName.inputAccessoryView = toolBar
        doseNumber.inputAccessoryView = toolBar
        stock.inputAccessoryView = toolBar
        url.inputAccessoryView = toolBar
        memo.inputAccessoryView = toolBar
    }
    // textViewを可変
    func textViewDidChange(_ textView: UITextView) {
        // サイズ変更を計算
        let size = textView.sizeThatFits(CGSize(width: textView.frame.width, height: CGFloat.greatestFiniteMagnitude))
        
        // 高さを更新
        if textView.frame.size.height != size.height {
            UIView.animate(withDuration: 0.2) {
                textView.constraints.forEach { constraint in
                    if constraint.firstAttribute == .height {
                        constraint.constant = size.height
                    }
                }
                self.view.layoutIfNeeded()
            }
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
        let additionalMargin: CGFloat = -215
        let adjustmentHeight = willShow ? keyboardHeight + additionalMargin : 0
        UIView.animate(withDuration: 0.3) {
            // ビュー全体のインセットを調整
            if let scrollView = self.view as? UIScrollView {
                scrollView.contentInset.bottom = adjustmentHeight
                scrollView.scrollIndicatorInsets.bottom = adjustmentHeight
            } else {
                // `UIScrollView`を持たない場合はビューのbottomの位置を調整
                self.view.frame.origin.y = willShow ? -adjustmentHeight : 0
            }
        }
    }
    // DatePicker
    private func createDatePicker(){
        // DatePickerModeをDate(日付)に設定
        datePicker.datePickerMode = .time
        // DatePickerを日本語化
        datePicker.locale = NSLocale(localeIdentifier: "ja_JP") as Locale
        // textFieldのinputViewにdatepickerを設定
        datePickerTextField.inputView = datePicker
        // UIToolbarを設定
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        // Doneボタンを設定(押下時doneClickedが起動)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
        // Doneボタンを追加
        toolbar.setItems([doneButton], animated: true)
        // FieldにToolbarを追加
        datePickerTextField.inputAccessoryView = toolbar
        // Pickerのスタイルをホイールに設定
        datePicker.preferredDatePickerStyle = .wheels
    }
    @objc func doneClicked(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        // textFieldに選択した日付を代入
        datePickerTextField.text = dateFormatter.string(from: datePicker.date)
        // キーボードを閉じる
        self.view.endEditing(true)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerView1 {
                    return pickerData1.count
                } else if pickerView == pickerView2 {
                    return pickerData2.count
                } else {
                    return 0
                }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerView1 {
                    return pickerData1[row]
                } else if pickerView == pickerView2 {
                    return pickerData2[row]
                } else {
                    return nil
                }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerView1 {
            self.textField.text = pickerData1[row]
            print("選択された行のインデックス (pickerView1): \(row)")
        } else if pickerView == pickerView2 {
            let selectedValue = pickerData2[row]
            self.customPickerTextField.text = pickerData2[row]
            self.label.text = pickerData2[row] // 選んだ値がUILabelに反映
            print("選択された行のインデックス (pickerView2): \(row)")
        }
    }
    @objc func showCustomOption() {
        let alert = UIAlertController(title: "カスタム", message: "選択してください", preferredStyle: .actionSheet)
        
        let addAction = UIAlertAction(title: "新規追加", style: .default) { [weak self] _ in
            self?.showAddCustomOptionAlert()
        }
        let selectedRow = pickerView2.selectedRow(inComponent: 0)
            let selectedOption = pickerData2[selectedRow]
        let deleteAction = UIAlertAction(title: "\(selectedOption)を削除", style: .destructive) { [weak self] _ in
            self?.showDeleteCustomOptionAlert()
        }
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        
        alert.addAction(addAction)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func showAddCustomOptionAlert() {
        let alert = UIAlertController(title: "新規追加", message: "オプションを追加してください", preferredStyle: .alert)
            alert.addTextField { textField in
                textField.placeholder = "新しいオプション"
            }
            let addAction = UIAlertAction(title: "追加", style: .default) { [weak self] _ in
                if let newOption = alert.textFields?.first?.text, !newOption.isEmpty {
                    self?.pickerData2.insert(newOption, at: self!.pickerData2.count - 1)
                    self?.pickerView2.reloadAllComponents()
                    self?.customPickerTextField.text = newOption
                    self?.label.text = newOption
                }
            }
            let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
            alert.addAction(addAction)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
        }

        func showDeleteCustomOptionAlert() {
            let selectedRow = pickerView2.selectedRow(inComponent: 0)
                let selectedOption = pickerData2[selectedRow]
            guard selectedRow < pickerData2.count else {
                    return
                }
            let alert = UIAlertController(title: "オプションを削除", message: "\(selectedOption)を削除しますか", preferredStyle: .alert)
            
            let pickerView = UIPickerView()
            pickerView.delegate = self
            pickerView.dataSource = self
            pickerView.tag = 999 // 削除用のpickerViewにタグを設定
            
            let pickerContainer = UIViewController()
            pickerContainer.preferredContentSize = CGSize(width: 250, height: 10)
            pickerContainer.view.addSubview(pickerView)
            
            pickerView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                pickerView.leadingAnchor.constraint(equalTo: pickerContainer.view.leadingAnchor),
                pickerView.trailingAnchor.constraint(equalTo: pickerContainer.view.trailingAnchor),
                pickerView.topAnchor.constraint(equalTo: pickerContainer.view.topAnchor),
                pickerView.bottomAnchor.constraint(equalTo: pickerContainer.view.bottomAnchor)
            ])
            
            alert.setValue(pickerContainer, forKey: "contentViewController")
            
            let deleteAction = UIAlertAction(title: "削除", style: .destructive) { [weak self] _ in
//                let selectedRow = pickerView.selectedRow(inComponent: 0)
                guard let self = self else { return }
                    self.pickerData2.remove(at: selectedRow)
                    self.pickerView2.reloadAllComponents()
                    self.customPickerTextField.text = ""
                    self.label.text = ""
            }
            
            let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
            alert.addAction(deleteAction)
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion: nil)
        }
    @objc func done() {
        self.view.endEditing(true)
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
}
