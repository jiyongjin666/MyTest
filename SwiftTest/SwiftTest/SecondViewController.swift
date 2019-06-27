//
//  SecondViewController.swift
//  SwiftTest
//
//  Created by bobao on 2019/6/21.
//  Copyright © 2019 bobao. All rights reserved.
//

import UIKit
import SDCycleScrollView
protocol classa {
    var marks: Int {get set}
    var result: Bool {get}
    func attendance() -> String
    func markssecured() -> String
}
protocol classb:classa {
    var present: Bool {
        get set
    }
    var subject: String {
        get set
    }
    var stname: String {
        get set
    }
}

class classc: classb {
    var result = true
    
    var marks: Int = 96
    
    
    
    var present: Bool = false
    var subject: String = "Swift 协议"
    var stname: String = "Protocols"
    func attendance() -> String {
        return "The \(stname) has secured 99% attendance"
    }
    func markssecured() -> String {
        return "\(stname) has scored \(marks)"
    }
    
    
    
    
}
protocol daysofaweek {
    mutating func show ()
}
enum days:daysofaweek {
    case sun,mon,tue,wed,thurs,fri,sat
    mutating func show() {
        switch self {
        case .sun:
            self = .sun
            print("Sunday")
        case .mon:
            print("Monday")
        case .tue:
            self = .tue
            print("Tuesday")
        case .wed:
            self = .wed
            print("Wednesday")
        case .thurs:
            self = .thurs
            print("Wednesday")
        case .fri:
            self = .fri
            print("Wednesday")
        case .sat:
            self = .sat
            print("Saturday")
        default:
            print("No Such day")
        }
    }
}
protocol tcpprotocol {
    init(no1:Int)
}
class mainClass {
    var no1: Int = 0//b局部变量
    init(no1:Int) {
        self.no1 = no1//初始化
    }
    
}
// 类的专属协议
class subClass: mainClass,tcpprotocol {
    
    
    var no2: Int
    init(no1:Int, no2:Int) {
        self.no2 = no2
        super.init(no1: no1)
    }
    //因为遵循协议，需要加上“required”;因为继承父类，需要加上"override";
    required override convenience init(no1: Int) {
        self.init(no1:no1,no2:0)
    }
}
// 在扩展中添加协议成员
protocol AgeClasificationProtocol {
    var age: Int {
        get
    }
    func agetype() -> String
}
class Person {
    let firstname : String
    let lastname : String
    var age : Int
    init(firstname: String,lastname :String) {
        self.firstname = firstname
        self.lastname = lastname
        self.age = 10
    }
    
}
extension Person:AgeClasificationProtocol {
    func fullname() -> String {
        var c : String
        c = firstname + "" + lastname
        return c
        
    }
    func agetype() -> String {
        switch age {
        case 0...2:
            return "Bady"
        case 2...12:
            return "Child"
        case 13...19:
            return "Teenager"
        case let x where x > 65:
            return "Elderly"
        default:
            return "Normal"
        }
    }
}
// 协议合成
protocol Stname {
    var name: String {get}
   
}
protocol Stage {
    var age: Int {get}
}
struct Dog:Stname,Stage {
    var name: String
    var age: Int
    
}
func show(celebrator:Stname & Stage)  {
    print("\(celebrator.name) is \(celebrator.age) years old")
}
//检查协议的一致性 is  as
protocol HasArea {
    var area : Double{get}
}
//定义了Circle类 ,都遵循了HasArea协议
class Circle: HasArea {
    let pi = 3.1415927
    var radius : Double
    var area : Double {return pi * radius * radius}
    init(radius: Double) {
        self.radius = radius
    }
}
//定义country类，遵循HasArea协议
class Country: HasArea {
    var area: Double
    init(area:Double) {
        self.area = area
    }
    
}
//Animal是一个没有遵循HasArea协议
class Animal {
    var legs: Int
    init(legs:Int) {
        self.legs = legs
    }
}
//泛型
func swaptwoValues<T>(swapa: inout T, swapb : inout T) {
    let tmep = swapa
    swapa = swapb
    swapb = tmep
    
}
// 类型约束
func findIndex(ofString valueToFind: String,in array :[String]) -> Int? {
    for (index,value) in array.enumerated() {
        if value == valueToFind {
            //f找到返回索引值
            return index
        }
        
    }
    return nil
}
class SecondViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    var array:[GHItem] = []
    var array1:[String] = []
    var cycleScrollView = SDCycleScrollView()
    
    var tableView = UITableView()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let student = classc()
        student.stname = "Swift"
        student.marks = 98
        student.markssecured()
        print(student.marks)
        print(student.result)
        print(student.present)
        print(student.subject)
        print(student.stname)
        
        var res = days.wed
        res.show()
        
        let res1 = mainClass(no1: 20)
        let show = subClass.init(no1: 30, no2: 50)
        print("res1 is :\(res1.no1)");
        print("res1 is :\(show.no1)");

        print("res1 is :\(show.no2)");
        let per = Person.init(firstname: "Zhang", lastname: "san")
        print("per`s fullname is \(per.fullname())")
        per.age = 10
        print("per is \(per.agetype())")
        
        let dog = Dog.init(name: "Tom", age: 12)
        print(dog)
        
        let objects:[AnyObject] = [Circle.init(radius: 2.0),Country.init(area: 243_908),Animal.init(legs: 4)]
        for item in objects {
            if let objectWithArea = item as? HasArea{
                print("面积为\(objectWithArea.area)")
            }
            else {
                print("没有a面积")
            }
        }
        
        var num1 = 100
        var num2 = 200
        print("交换数据之前 \(num1) \(num2)")
        swap(&num1, &num2)
        print("交换数据后：\(num1) \(num2)")
        
        var str1 = "B"
        var str2 = "S"
        
        print("交换数据之前 \(str1)\(str2)")
        swap(&str1, &str2)
        print("交换数据后：\(str1)\(str2)")
        
        let strings = ["google","weibo","taobao","runoob","facbook"]
        if let foundIndex = findIndex(ofString: "weibo", in: strings){
        print("weibo index is \(foundIndex)");
        
        }
        testZhihuDily()
        createTableView()
        // Do any additional setup after loading the view.
    }
    func testZhihuDily()  {
        NetWorkRequest(.easyRequest, complection: { (resut) -> (Void) in
            if let daliyItems = [GHItem].deserialize(from: resut, designatedPath: "stories"){
                daliyItems.forEach({(item) in
                    self.array.append(item!)
                    
                    
                })
            }
            if let headItems = [HeadModel].deserialize(from: resut, designatedPath: "top_stories"){
                headItems.forEach({ (head) in
                    self.array1.append(head!.image!)
                    self.cycleScrollView.imageURLStringsGroup = self.array1
                })
            }
            self.tableView.reloadData()
            
        }) { (fail) -> (Void) in
            
        }
    }
    func createTableView() {
     self.tableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height - 49), style: UITableView.Style.plain)
        self.view.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "pool")
//        let imageNames = ["https://pic4.zhimg.com//v2-6464e1af5f9da2fd3b3112022b759ed7.jpg", "img2.png", "img.png", "img4.png"]
//        let titles = ["1","2","3","4"]
        
//        let cycleScrollView = SDCycleScrollView.init(frame: CGRect (x: 0, y: 0, width: self.view.frame.size.width, height: 200), shouldInfiniteLoop: true, imageNamesGroup: imageNames)
        self.cycleScrollView = SDCycleScrollView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: 200))
        
        self.cycleScrollView.placeholderImage = UIImage.init(named: "img1")
       // cycleScrollView.titlesGroup = titles
        self.tableView.tableHeaderView  = self.cycleScrollView
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pool", for: indexPath) as! CustomTableViewCell
        let item = self.array[indexPath.row]
        
        cell.model = item
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
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
