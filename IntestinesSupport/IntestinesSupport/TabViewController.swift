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
        
        UITabBar.appearance().tintColor = UIColor.systemGreen
        
        UITabBar.appearance().backgroundColor = UIColor(red: 0.4, green: 0.7, blue: 0.4, alpha: 0.2)
    }
    
    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    }
}
