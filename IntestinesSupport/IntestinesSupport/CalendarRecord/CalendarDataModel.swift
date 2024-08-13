//
//  CalendarDataModel.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/08/13.
//

import RealmSwift

protocol CalendarViewControllerDelegate: AnyObject {
    func didSaveCalendar(_ calendar: CalendarDataModel)
}

class CalendarDataModel: Object {
    @objc dynamic var number01Button: Int = 0
    @objc dynamic var number02Button: Int = 0
    @objc dynamic var number03Button: Int = 0
    @objc dynamic var number04Button: Int = 0
    @objc dynamic var number05Button: Int = 0
    @objc dynamic var number1Button: Int = 0
    @objc dynamic var number2Button: Int = 0
    @objc dynamic var number3Button: Int = 0
    @objc dynamic var number4Button: Int = 0
    @objc dynamic var number5Button: Int = 0
    @objc dynamic var fecesDetail1: Int = 0
    @objc dynamic var fecesDetail2: Int = 0
    @objc dynamic var fecesDetail3: Int = 0
    @objc dynamic var fecesDetail4: Int = 0
    @objc dynamic var fecesDetail5: Int = 0
    @objc dynamic var fecesDetail6: Int = 0
    @objc dynamic var memo: String = ""
}
