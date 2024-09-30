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
    
    private var buttons: [UIButton] {
        return  [number01Button, number02Button, number03Button, number04Button, number05Button]
    }
    private var selectedButton: UIButton?
    private var model: CalendarDataModel?
    private var selectedDate: Date?
    weak var delegate: CalendarViewControllerDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupButton()
    }
    
    private func setupButton() {
        for (index, button) in buttons.enumerated() {
            // 選択中の状態をtagで管理する
            button.tag = index
            button.setTitleColor(.black, for: .normal)
            button.tintColor = .black
            button.layer.borderWidth = 1.0
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.cornerRadius = 5.0
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        sender.backgroundColor = .orange
        
        if let selectedButton, selectedButton != sender {
            selectedButton.backgroundColor = .white
        }
        self.selectedButton = sender
        saveData(selectedIndex: sender.tag)
    }
    
    private func saveData(selectedIndex: Int) {
        // modelがnilではない場合(Realmデータの編集)
        if let model {
            // indexを更新して保存する
            let editModel = makeEditCalendarDataModel(selectedIndex: selectedIndex, model: model)
            delegate?.saveCalendarData(editModel)
        } else {
            guard let selectedDate else { return }
            // modelがnilの場合は新規作成ため、ここでModelを作成してそれを保存する
            let newModel = makeNewCalendarDataModel(selectedDate: selectedDate, selectedIndex: selectedIndex)
            delegate?.saveCalendarData(newModel)
        }
    }
    
    private func makeEditCalendarDataModel(selectedIndex: Int, model: CalendarDataModel) -> CalendarDataModel {
        return CalendarDataModel(
            id: model.id,
            date: model.date,
            selectedPhysicalConditionIndex: selectedIndex,
            selectedFecesConditionIndex: model.selectedFecesConditionIndex,
            memo: model.memo
        )
    }
    
    private func makeNewCalendarDataModel(selectedDate: Date, selectedIndex: Int) -> CalendarDataModel {
        // 日付とButtonのIndexをセットする
        let newModel = CalendarDataModel()
        newModel.selectedPhysicalConditionIndex = selectedIndex
        newModel.date = selectedDate
        return newModel
    }
    
    func configure(selectedIndex: Int = 99, model: CalendarDataModel? = nil, selectedDate: Date) {
        self.model = model
        self.selectedDate = selectedDate
        
        for (index, button) in buttons.enumerated() {
            // indexを取得し、保存していたselectedIndexと一致する場合backgroundColorをYellowにする
            button.backgroundColor = index == selectedIndex ? .systemOrange : .white
        }
    }
}
