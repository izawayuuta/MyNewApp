//
//  CertificateDataModel.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/08/11.
//

import RealmSwift

protocol CertificateViewControllerDelegate: AnyObject {
    func didSaveCertificate(_ certificate: CertificateDataModel)
}

class CertificateDataModel: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var textField0: String?
    @objc dynamic var textField01: Int = 0
    @objc dynamic var textField02: String?
    @objc dynamic var year: Int = 0
    @objc dynamic var month: Int = 0
    @objc dynamic var day: Int = 0
    @objc dynamic var year2: Int = 0
    @objc dynamic var month2: Int = 0
    @objc dynamic var day2: Int = 0
    @objc dynamic var textField1: Int = 0
    @objc dynamic var textField2: Int = 0
    @objc dynamic var textField3: Int = 0
    @objc dynamic var textField4: Int = 0
    @objc dynamic var textField5: Int = 0
    @objc dynamic var pickerView: Int = 0
    
    override static func primaryKey() -> String? {
           return "id"
       }
}
