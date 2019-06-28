//
//  LoginViewController.swift
//  SwiftTest
//
//  Created by bobao on 2019/6/28.
//  Copyright © 2019 bobao. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var acountTextField: UITextField!
    @IBOutlet weak var passwdTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let acount:String = createAcount() as! String
        if acount.isEmpty == false {
            acountTextField.text = acount
        }
       
        
        // Do any additional setup after loading the view.
    }

    @IBAction func rootAction(_ sender: Any) {
        if acountTextField.text == "111111" && passwdTextField.text == "123456" {
            LoadingTool.shared.showMessage(msg: "登录中...", inView: self.view)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                let vc = ViewController.init()
                let  main = UINavigationController.init(rootViewController: vc)
                self.view.window?.rootViewController = main
                saveAcountAndPasswd(acount: self.acountTextField.text!, passwd: self.passwdTextField.text!)
                
            }
            
          
            
        }else if acountTextField.text?.isEmpty == true {
            LoadingTool.shared.showMessage(msg: "账号不能为空！", inView: self.view)
        }else if passwdTextField.text?.isEmpty == true {
            LoadingTool.shared.showMessage(msg: "密码不能为空！", inView: self.view)

        }else {
            LoadingTool.shared.showMessage(msg: "账号或者密码错误！", inView: self.view)

        }
        
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
