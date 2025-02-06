//
//  AllDataCalendar.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2025/02/05.
//

import UIKit

class AllDataCalendarViewController: UIViewController {
    
    let calendar = UICalendarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white // 背景色を設定（必要に応じて）
                
                // カレンダーの設定
                calendar.translatesAutoresizingMaskIntoConstraints = false // Auto Layoutを有効にするため
                
                // カレンダーをビューに追加
                view.addSubview(calendar)
                
                // カレンダーのレイアウト制約を設定
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            calendar.heightAnchor.constraint(equalToConstant: 400)
        ])

            }
}
