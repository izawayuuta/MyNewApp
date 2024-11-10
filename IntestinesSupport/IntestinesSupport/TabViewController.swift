//
//  TabViewController.swift
//  IntestinesSupport
//
//  Created by 俺の MacBook Air on 2024/07/05.
//

import Foundation
import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = UIColor.black
        
        UITabBar.appearance().unselectedItemTintColor = UIColor.systemGray2
        
        UITabBar.appearance().backgroundColor = UIColor(red: 0.4, green: 0.7, blue: 0.4, alpha: 0.2)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
//    private func applyTabBarColor(tabBarColor: UIColor, textColor: UIColor) {
//            let appearance = UITabBarAppearance()
//            appearance.configureWithOpaqueBackground()
//            appearance.backgroundColor = tabBarColor
//            
//            let itemAppearance = UITabBarItemAppearance()
//            itemAppearance.normal.titleTextAttributes = [.foregroundColor: textColor]
//            itemAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.black]
//            itemAppearance.normal.iconColor = textColor
//            itemAppearance.selected.iconColor = UIColor.black
//            
//            appearance.stackedLayoutAppearance = itemAppearance
//            tabBar.standardAppearance = appearance
//            tabBar.scrollEdgeAppearance = appearance // iOS 15以降対応
//        }
}
