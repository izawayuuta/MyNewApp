//
//  ColorViewController.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/10/16.
//

import Foundation
import UIKit

class ColorViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "タブカラー"
        
    }
    // タブのカラー
    @IBAction func tabDefaultGreen() {
        let defaultTabBarColor = UIColor(red: 0.4, green: 0.7, blue: 0.4, alpha: 0.2)
        changeTabBarColor(to: defaultTabBarColor, textColor: .systemGray2)
    }
    @IBAction func tabRed() {
        changeTabBarColor(to: .red.withAlphaComponent(0.5), textColor: .white)
    }
    
    @IBAction func tabBlue() {
        changeTabBarColor(to: .blue.withAlphaComponent(0.6), textColor: .white)
    }
    
    @IBAction func tabYellow() {
        changeTabBarColor(to: .yellow.withAlphaComponent(0.5), textColor: .systemGray2)
    }
    @IBAction func tabPink() {
        changeTabBarColor(to: .systemPink.withAlphaComponent(0.5), textColor: .white)
    }
    @IBAction func tabIndigo() {
        changeTabBarColor(to: .systemIndigo.withAlphaComponent(0.7), textColor: .white)
    }
    @IBAction func tabCyan() {
        changeTabBarColor(to: .cyan.withAlphaComponent(0.5), textColor: .systemGray2)
    }
    @IBAction func tabOrange() {
        changeTabBarColor(to: .orange.withAlphaComponent(0.5), textColor: .white)
    }
    @IBAction func tabWhite() {
        changeTabBarColor(to: .white.withAlphaComponent(1.0), textColor: .systemGray2)
    }
    @IBAction func tabBlack() {
        changeTabBarColor(to: .black.withAlphaComponent(0.6), textColor: .white)
    }
    @IBAction func tabGray() {
        changeTabBarColor(to: .gray.withAlphaComponent(0.5), textColor: .white)
    }
    @IBAction func tabBrown() {
        changeTabBarColor(to: .brown.withAlphaComponent(0.5), textColor: .white)
    }
    private func changeTabBarColor(to color: UIColor?, textColor: UIColor?) {
        if let tabBar = self.tabBarController?.tabBar {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            
            // 引数 color が nil ならデフォルトの色に戻す
            appearance.backgroundColor = color ?? .systemBackground
            
            // タブバーアイテムの文字色とアイコンの色を設定
            let itemAppearance = UITabBarItemAppearance()
            itemAppearance.normal.titleTextAttributes = [.foregroundColor: textColor] // 通常時の文字色
            itemAppearance.selected.titleTextAttributes = [.foregroundColor: textColor] // 選択時の文字色
            itemAppearance.normal.iconColor = textColor // 通常時のアイコン色
            itemAppearance.selected.iconColor = textColor // 選択時のアイコン色
            
            appearance.stackedLayoutAppearance = itemAppearance
            
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance // iOS 15以降対応
        } else {
            print("タブバーコントローラが見つかりません")
        }
    }
}
