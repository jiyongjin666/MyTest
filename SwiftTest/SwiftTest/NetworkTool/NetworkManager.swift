//
//  NetworkManager.swift
//  SwiftTest
//
//  Created by bobao on 2019/6/25.
//  Copyright © 2019 bobao. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import SwiftyJSON
//超时时长
private var requestTimeOut:Double = 30
//成功数据回调
typealias sucessCallback = ((String) -> (Void))
//失败回调
typealias failedCallback = ((String) -> (Void))
// 网络错误的回调
typealias errorCallback = (() -> (Void))
//网络请求的基本设置，这里可以拿到的是具体的那个网络请求，可以在这里做一些设置
private let myEndpointClosure = {(target: API) -> Endpoint in
   // 这里endpoint重新构造一遍主要为了解决网络请求网址里面含有？时无法解析的bug
    let url = target.baseURL.absoluteString + target.path
    var task = target.task
    /***
     *如果需要在每个请求中都添加类似token参数的参数请取消注释下面代码
     **/
    //let additionalParameters = ["token":"888888"]
//    let defaultEncoding = URLEncoding.default
//    switch target.task {
//        ///在你需要添加的请求方式中做修改就行，不用的case 可以删掉。。
//    case .requestPlain:
//        task = .requestParameters(parameters: additionalParameters, encoding: defaultEncoding)
//    case .requestParameters(var parameters, let encoding):
//        additionalParameters.forEach { parameters[$0.key] = $0.value }
//        task = .requestParameters(parameters: parameters, encoding: encoding)
//    default:
//        break
//    }

    
    var endpoint = Endpoint(
        url: url,
        sampleResponseClosure: { .networkResponse(200, target.sampleData)},
        method: target.method, task: task,
        httpHeaderFields: target.headers
    )
    requestTimeOut = 30//每次请求都会调用endpointClosure 到这里设置超时时长 也可单独每个接口设置
    switch target {
    case .easyRequest:
        return endpoint
    case .register:
        requestTimeOut = 5
        return endpoint
    default:
        return endpoint
    }
}
//网络请求的设置
private let requestClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
    do {
        var request = try endpoint.urlRequest()
        //设置请求时长
        request.timeoutInterval = requestTimeOut
        // 打印请求参数
        if let requestData = request.httpBody {
            print("\(request.url!)"+"\n"+"\(request.httpMethod ?? "")"+"发送参数"+"\(String(data: request.httpBody!, encoding: String.Encoding.utf8) ?? "")")
        }else{
            print("\(request.url!)"+"\(String(describing: request.httpMethod))")
        }
        done(.success(request))
    } catch {
        done(.failure(MoyaError.underlying(error, nil)))
    }
}
//NetworkActivityPlugin插件用来监听网络请求，界面上做相应的展示
private let networkPlugin = NetworkActivityPlugin.init{(chngeType,targerType) in
    print("networkplugin\(chngeType)")
    //tsrgettype是当前请求的基本信息
    switch (chngeType){
    case .began:
        print("网络请求开始")
    case .ended:
        print("结束")
    }
}
//stubClosure   用来延时发送网络请求

// 网络请求发送的核心功能核心初始化方法，创建网络请求对象
let Provider = MoyaProvider<API>(endpointClosure: myEndpointClosure, requestClosure: requestClosure, plugins: [networkPlugin], trackInflights: false)

//最常用的网络请求，只需知道正确的结果无需其他z操作的时候用这个
/***
 *targer: 网络请求
 * completion 请求成功回调
 **/
func NetWorkRequest(_ target: API,completion: @escaping sucessCallback) {
   NetWorkRequest(target, complection: completion, failed: nil, errorResult: nil)
}
//需要知道成功或者失败，要知道code码为其他情况时候用这个
/***
 target 网络请求
 complection 成功的回调
 failed 请求d失败的回调
 **/
func NetWorkRequest(_ target: API,complection: @escaping sucessCallback,failed:failedCallback?) {
    NetWorkRequest(target, complection: complection, failed: failed, errorResult: nil)
}

///  需要知道成功、失败、错误情况回调的网络请求   像结束下拉刷新各种情况都要判断
///
/// - Parameters:
///   - target: 网络请求
///   - completion: 成功
///   - failed: 失败
///   - error: 错误
func NetWorkRequest(_ target:API,complection: @escaping sucessCallback,failed:failedCallback?,errorResult:errorCallback?) {
    //先判断网络是否有链接 没有的话直接返回代码
    if !isNetworkConnect {
        print("提示用户网络似乎出现了问题")
        return
    }
    //这里显示loading图
    print("loading..")
    Provider.request(target){ (result) in
        //隐藏hud
        print("隐藏loading..")
        switch result {
        case let .success(respose):
            do {
                let jsonData = try JSON(data: respose.data)
                print(jsonData)
                //               这里的completion和failed判断条件依据不同项目来做，为演示demo我把判断条件注释了，直接返回completion。
                complection(String(data:respose.data,encoding:String.Encoding.utf8)!)
                print("flag不为1000 HUD显示后台返回message + ")
            }
            catch {
                
            }
        case let .failure(error):
            guard (error as? CustomStringConvertible) != nil else {
                //网络连接失败，提示用户
                print("网络连接失败")
                break
            }
            if errorResult != nil {
                errorResult!()
        }
    }
  }
}
/// 基于Alamofire,网络是否连接，，这个方法不建议放到这个类中,可以放在全局的工具类中判断网络链接情况
/// 用get方法是因为这样才会在获取isNetworkConnect时实时判断网络链接请求，
var isNetworkConnect : Bool {
    get{
        let netwrok = NetworkReachabilityManager()
        return netwrok?.isReachable ?? true//我返回就默认网络已连接
        
    }
}

    


