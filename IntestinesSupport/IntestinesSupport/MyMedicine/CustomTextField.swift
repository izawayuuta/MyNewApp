//
//  CustomTextField.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/08/05.
//

import UIKit

class CustomTextField: UITextField {
    // 入力カーソル非表示
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
    // 範囲選択カーソル非表示
    private func selectionRects(for range: UITextRange) -> [Any] {
        return []
    }
    // コピー・ペースト・選択等のメニュー非表示
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
}
