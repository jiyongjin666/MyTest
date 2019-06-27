//
//  UserExtention.swift
//  SwiftTest
//
//  Created by bobao on 2019/6/26.
//  Copyright © 2019 bobao. All rights reserved.
//

import Foundation
extension UserDefaults {
  static  func isFirstLauchofNewVersion() -> Bool {
        //主程序版本号
    let infoDictinary = Bundle.main.infoDictionary
    let majorVersion = infoDictinary?["CFBundleShortVersionString"] as! String
    //上次启动版本号
    let hasBeenLauchesNewVersion = "hasBeenLauchedofNewVersion"
    let lastLauchVersion = UserDefaults.standard.string(forKey: hasBeenLauchesNewVersion)
    //版本号比较
    let isFirstLauchOfNewVersion = majorVersion != lastLauchVersion
    if isFirstLauchOfNewVersion {
        UserDefaults.standard.set(majorVersion, forKey: hasBeenLauchesNewVersion)
        UserDefaults.standard.synchronize()
    }
    return isFirstLauchOfNewVersion
    }
}
