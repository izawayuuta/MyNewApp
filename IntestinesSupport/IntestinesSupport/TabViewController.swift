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
        
        UITabBar.appearance().tintColor = UIColor.orange
        
        UITabBar.appearance().backgroundColor = .white
    }
    
    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    }
    
}
