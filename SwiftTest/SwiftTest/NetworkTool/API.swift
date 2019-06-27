//
//  API.swift
//  SwiftTest
//
//  Created by bobao on 2019/6/25.
//  Copyright © 2019 bobao. All rights reserved.
//

import Foundation
import Moya
enum API {
    case updateAPi(parameters:[String:Any])
    case register(email:String,password:String)
    //上传头像
    case uploadHeadImage(parameters:[String:Any],imageDate:Data)
    case easyRequest
}

extension API:TargetType {
    var baseURL: URL {
        switch self {
        case .easyRequest:
            return URL(string: "http://news-at.zhihu.com/api/")!
        default:
            return URL.init(string: Moya_baseURL)!
        }
    }
    
    var path: String {
        switch self {
        case .register:
            return "register"
        case .easyRequest:
            return "4/news/latest"
        case .updateAPi:
            return "versionService.getAppUpdateApi"
        case .uploadHeadImage( _):
            return "/file/user/upload.jhtml"
        
        }
        
    }
    
    var method: Moya.Method {
        switch self {
        case .easyRequest:
            return .get
        default:
            return .post
        }
    }
        //    这个是做单元测试模拟的数据，必须要实现，只在单元测试文件中有作用
    var sampleData: Data {
       return "".data(using:String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
        case let .register(email, password):
            return .requestParameters(parameters: ["email": email, "password": password], encoding: JSONEncoding.default)
        case .easyRequest:
            return .requestPlain
        case let .updateAPi(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        //图片上传
        case .uploadHeadImage(let parameters, let imageDate):
            ///name 和fileName 看后台怎么说，   mineType根据文件类型上百度查对应的mineType
            let formData = MultipartFormData(provider: .data(imageDate), name: "file",
                                             fileName: "hangge.png", mimeType: "image/png")
            return .uploadCompositeMultipart([formData], urlParameters: parameters)
        
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type":"application/x-www-form-urlencoded"]

    }
    
}
