//
//  AppDelegate.swift
//  SwiftTest
//
//  Created by bobao on 2019/6/21.
//  Copyright © 2019 bobao. All rights reserved.
//

import UIKit
import IQKeyboardManager
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,psVCDelegate {
    var guidevc = PSGuideViewController()
    
    func removeDelegateMethod() {
        print("揍你")
        self.guidevc.view.removeFromSuperview()
        self.guidevc.view = nil
    }
    

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        let vc = LoginViewController.init()
        let mainVC = ViewController.init()
        let  main = UINavigationController.init(rootViewController: mainVC)
        let passwd:String = createAcount() as! String
        if passwd.isEmpty == true {
             self.window?.rootViewController = vc
        }else {
            self.window?.rootViewController = main
        }
       
        self.window?.makeKeyAndVisible()
        if UserDefaults.isFirstLauchofNewVersion() {
            print("第一次启动")
            self.guidevc = PSGuideViewController()
            self.guidevc.guidePageCpntollerWithImage(images: ["artpat_normal","artpat_normal"])
//            guidevc.removeFromBlcok = {
//                print("滚蛋")
//            }
            self.guidevc.delegateMeothod = self
            self.window?.addSubview(self.guidevc.view)
            
        }else {
            print("不是第一次启动")
           
        }
        
        configKeyBaordManger()
        if#available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        }
        // Override point for customization after application launch.
        return true
    }
    func configKeyBaordManger() {
        let keyBoardManager = IQKeyboardManager.shared()
        keyBoardManager.isEnabled = true
        keyBoardManager.toolbarDoneBarButtonItemText = "完成"
        keyBoardManager.isEnableAutoToolbar = true
        keyBoardManager.toolbarManageBehaviour = IQAutoToolbarManageBehaviour.bySubviews
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

