//
//  ColorViewController.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/10/16.
//

import Foundation
import UIKit

class ColorViewController: UIViewController {
    
    @IBOutlet weak var red: UIButton!
    @IBOutlet weak var blue: UIButton!
    @IBOutlet weak var yellow: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "テーマカラー"
    }
    @IBAction func tabRed() {
            changeTabBarColor(to: .red)
        }

        @IBAction func tabBlue() {
            changeTabBarColor(to: .blue)
        }

        @IBAction func tabYellow() {
            changeTabBarColor(to: .yellow)
        }

        private func changeTabBarColor(to color: UIColor) {
            if let tabBar = self.tabBarController?.tabBar {
                tabBar.barTintColor = color
                // tabBar.tintColor = UIColor.white // アイコンの色を変更する場合
            } else {
                print("タブバーコントローラが見つかりません")
            }
        }
}
