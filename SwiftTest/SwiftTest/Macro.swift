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
@_exported import MBProgressHUD

func kFont(font:CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: font) 
}
func kFontSize(size:CGFloat) -> CGFloat {
    return size / 375.0 * screenWidth
}
func kRealValue(width:CGFloat) -> CGFloat {
    return width / 375.0 * screenWidth
}
func createPasswd() -> Any {
    let user = UserDefaults.standard
    let passwd = user.object(forKey: "passwd")
    return passwd ?? (Any).self
    
}
func saveAcountAndPasswd(acount:String,passwd:String) {
    let user = UserDefaults.standard
    user.set(acount, forKey: "acount")
    user.set(passwd, forKey: "passwd")
    user.synchronize()
}

func createAcount() -> Any {
    let user = UserDefaults.standard
    let acount = user.object(forKey: "acount")
    return acount ?? (Any).self
    
}
func deletePasswd() {
    let user = UserDefaults.standard
    user.removeObject(forKey: "passwd")
    user.synchronize()
}
