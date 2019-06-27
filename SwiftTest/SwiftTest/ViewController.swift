//
//  ViewController.swift
//  SwiftTest
//
//  Created by bobao on 2019/6/21.
//  Copyright © 2019 bobao. All rights reserved.
//

import UIKit
import SDCycleScrollView
class Subjects {
    var physices: String
    init(physices: String) {
        self.physices = physices
    }
    
}
class Chemistry: Subjects {
    var eqautions: String
    init(physices: String,equations:String) {
        self.eqautions = equations
        super.init(physices: physices)
    }
}
class Math: Subjects {
    var formulae: String
    init(physices: String,formulae: String) {
        self.formulae = formulae
        super.init(physices: physices)
    }
}
struct sum {
    var num1 = 100,num2 = 200
    
}
struct diff {
    var no1 = 200,no2 = 100
    
}
struct mult {
    var a = sum()
    var b = diff()
    
    
}
extension mult {
    init(x:sum,y:diff) {
        _ = x.num1 + x.num2
        _ = y.no1 + y.no2
    }
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.isTranslucent = false
        super.viewDidLoad()
        let a = sum(num1: 100, num2: 200)
        let b = diff(no1: 200, no2: 100)
        let getMult = mult.init(x: a, y: b)
        print("getMult sum\((getMult.a.num1,getMult.a.num2))")
        print("getMult diff\((getMult.b.no1,getMult.b.no2))")
        
        
        
        
        let addition = 3.add
        print("加法运算后的值：\(addition)")
        let subtraction = 10.sub
        print("减法运算后的值：\(subtraction)")
        let multiplication = 5.mul
        print("乘法运算后的值\(multiplication)")
        let division =  50.div
        print("除法的运算后的值\(division)")
        
        let mix = 20.add + 55.div
        print("混合运算\(mix)")
        
        let  sa = [Chemistry.init(physices: "固定物理", equations: "赫兹"),Math.init(physices: "流动动力学", formulae: "千兆兹"),Chemistry(physices: "热物理学", equations: "分贝"),Math(physices: "天体物理学", formulae: "兆赫"),Math.init(physices: "微分方程", formulae: "余弦级数")]
        var chemCount = 0
        var mathCount = 0
        
        for item in sa {
            if item is Chemistry {
              chemCount += 1
            }else if item is Math {
             mathCount += 1
            }
        }
        print("化学科目包含\(chemCount)个主题,数学包含\(mathCount)主题")
        self.view.backgroundColor = changeColor()
        
        4.topics {
            print("扩展模块内")
        }
        3.topics {
        print("內型转换模块内")
        }
        func result(numb :[Int]) {
            for i in numb {
                switch i.print {
                case .add:
                    print("10")
                case .sub:
                    print("20")
                case .mult:
                    print("30")
                case .div:
                    print("40")
                default:
                    print("50")
                }
            }
        }
        result(numb: [0,1,2,3,4,7])
        self.createBUtton()
       // let cycleScrollView =
//        let imageNames = ["https://pic4.zhimg.com//v2-6464e1af5f9da2fd3b3112022b759ed7.jpg", "img2.png", "img.png", "img4.png"]
//        let titles = ["1","2","3","4"]
//        
//        let cycleScrollView = SDCycleScrollView.init(frame: CGRect (x: 0, y: 0, width: self.view.frame.size.width, height: 200), shouldInfiniteLoop: true, imageNamesGroup: imageNames)
//       cycleScrollView?.titlesGroup = titles
//        
//        self.view.addSubview(cycleScrollView!)
        // Do any additional setup after loading the view.
    }

    @objc func nextAction() {
       
    }
    @objc func buttonTap1(button:UIButton){
        let sevc = SecondViewController.init()
        self.navigationController?.pushViewController(sevc, animated: true)
    }
    func createBUtton() {
        let button = UIButton.init(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        button.center = self.view.center
        self.view.addSubview(button)
        button.setTitle("下一页", for: UIControl.State.normal)
        button.backgroundColor = UIColor.red
        //button.addTarget(self, action: #selector(nextAction), for: UIControl.Event.touchUpInside)
        button.addTarget(self, action: #selector(buttonTap1(button:)), for: UIControl.Event.touchUpInside)
    }
   
}
extension Int {
    var add:Int {return self + 10}
    var sub: Int {
        return self - 10
    }
    var mul: Int {
        return self * 10
    }
    var div: Int {
        return self / 5
    }
    
}
extension UIViewController {
    var addColor: UIColor {
        return UIColor.red
    }
    func changeColor() -> UIColor {
        return UIColor.white
    }
   
    
}
extension Int {
    func topics(sunmmation:()-> ()) {
        for _ in 0..<self {
            sunmmation()
        }
    }
}
extension Int {
    enum calc {
        case add
        case sub
        case mult
        case div
        case anthing
    }
    var print: calc {
        switch self {
        case 0:
            return .add
        case 1 :
            return .sub
        case 2:
             return.mult
        case 3 :
            return .div
        default:
            return .anthing
        }
    }
}

