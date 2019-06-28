//
//  LoadingTool.swift
//  SwiftTest
//
//  Created by bobao on 2019/6/28.
//  Copyright © 2019 bobao. All rights reserved.
//

import UIKit
import UIKit
import MBProgressHUD
enum AlertViewMode {
    case alertViewLoading
    case alertViewText
}
class LoadingTool: NSObject {
    var hud : MBProgressHUD?
    
    static let shared = LoadingTool()
    private override init() {}
    
    override func copy() -> Any {
        return self // SingletonClass.shared
    }
    
    override func mutableCopy() -> Any {
        return self // SingletonClass.shared
    }
    
    func createHUD(lableTexst:String,showView:UIView,type:AlertViewMode)  {
        if LoadingTool.shared.hud != nil {
            LoadingTool.shared.hud?.hide(animated: true)
        }
        LoadingTool.shared.hud = MBProgressHUD.showAdded(to: showView, animated: true)
        LoadingTool.shared.hud?.label.text = lableTexst
        LoadingTool.shared.hud?.animationType = MBProgressHUDAnimation.zoom
        LoadingTool.shared.hud?.bezelView.style = MBProgressHUDBackgroundStyle.blur
        switch type {
        case .alertViewLoading:
        
            LoadingTool.shared.hud?.mode = MBProgressHUDMode.indeterminate
        
            break
            
        default:
           LoadingTool.shared.hud?.mode = MBProgressHUDMode.text
            break
            
        }
    }
    func showMessageHUD(msg:String,showView:UIView,showSyle:AlertViewMode) {
        createHUD(lableTexst:msg, showView: showView, type: showSyle)
    }
    func showMessage(msg:String,inView:UIView) {
       showMessageHUD(msg: msg, showView: inView, showSyle: .alertViewText)
        LoadingTool.shared.hud?.hide(animated: true, afterDelay: 2)
    }
    func showProgressMessage(msg:String,inView:UIView) {
       showMessageHUD(msg: msg, showView: inView, showSyle: .alertViewLoading)
    }
    func hudHidden() {
        if LoadingTool.shared.hud != nil {
             LoadingTool.shared.hud?.hide(animated: true)
        }
       
    }

}
