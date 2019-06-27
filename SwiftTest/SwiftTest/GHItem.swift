//
//  GHItem.swift
//  SwiftTest
//
//  Created by bobao on 2019/6/25.
//  Copyright © 2019 bobao. All rights reserved.
//

import UIKit
class GHItem: HandyJSON {
    var title:  String?
    var ga_prefix: String?
    var images: Array<String>?
    var multipic: String?
    var type: Int?
    var id: Int?
    //用HandyJSON必须要实现这个方法
    required init(){}
}
