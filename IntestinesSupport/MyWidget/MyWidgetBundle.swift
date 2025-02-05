//
//  MyWidgetBundle.swift
//  MyWidget
//
//  Created by 俺の MacBook Air on 2025/02/04.
//

import WidgetKit
import SwiftUI

@main
struct MyWidgetBundle: WidgetBundle {
    var body: some Widget {
        MyWidget()
        MyWidgetControl()
    }
}
