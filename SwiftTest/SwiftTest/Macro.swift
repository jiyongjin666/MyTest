//
//  Macro.swift
//  SwiftTest
//
//  Created by bobao on 2019/6/26.
//  Copyright © 2019 bobao. All rights reserved.
//

import UIKit


import Moya
import SwiftyJSON
import SDCycleScrollView
@_exported import HandyJSON
@_exported import SnapKit
@_exported import Kingfisher
func kFont(font:CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: font) 
}
func kFontSize(size:CGFloat) -> CGFloat {
    return size / 375.0 * screenWidth
}
func kRealValue(width:CGFloat) -> CGFloat {
    return width / 375.0 * screenWidth
}

