//
//  CalendarDataModel.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/08/13.
//

import RealmSwift

protocol CalendarViewControllerDelegate: AnyObject {
    func saveCalendarData(_ calendar: CalendarDataModel)
}

class CalendarDataModel: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var date: Date = Date()
    // 99の番号は未選択状態を表す
    @objc dynamic var selectedPhysicalConditionIndex: Int = 99
    @objc dynamic var selectedFecesConditionIndex: Int = 99
    @objc dynamic var selectedFecesDetailIndex: Int = 99
    @objc dynamic var memo: String = ""
    
    convenience init(id: String, date: Date, selectedPhysicalConditionIndex: Int, selectedFecesConditionIndex: Int, selectedFecesDetailIndex: Int, memo: String) {
        // まずself.init()を呼び出して、デフォルトの初期化を行う
        self.init()
        self.id = id
        self.date = date
        self.selectedPhysicalConditionIndex = selectedPhysicalConditionIndex
        self.selectedFecesConditionIndex = selectedFecesConditionIndex
        self.selectedFecesDetailIndex = selectedFecesDetailIndex
        self.memo = memo
    }
}
