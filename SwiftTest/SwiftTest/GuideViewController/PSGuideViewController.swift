//
//  PSGuideViewController.swift
//  SwiftTest
//
//  Created by bobao on 2019/6/26.
//  Copyright © 2019 bobao. All rights reserved.
//

import UIKit
//屏幕宽度
let screenHeight = UIScreen.main.bounds.height
// 屏幕高度
let screenWidth = UIScreen.main.bounds.width
typealias removeBlock = () -> Void//声明闭包
//创建协议
protocol psVCDelegate {
    //回到方法
    func removeDelegateMethod()
}
class PSGuideViewController: UIViewController,UIScrollViewDelegate{
    var removeFromBlcok : removeBlock? //把闭包声明成属性
    var delegateMeothod : psVCDelegate?//代理属性
    var imageView = UIImageView()
    var pageControl = UIPageControl()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    func guidePageCpntollerWithImage(images:Array<Any>){
        let scr = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        scr.delegate = self
        scr.showsVerticalScrollIndicator = false
        scr.showsHorizontalScrollIndicator = false
        scr.backgroundColor = UIColor.white
        scr.bounces = false
        scr.isPagingEnabled = true
        scr.isUserInteractionEnabled = true
        
        for i in 0..<images.count {
            self.imageView = UIImageView.init(frame: CGRect.init(x: CGFloat(i) * screenWidth, y: 0, width: screenWidth, height: screenHeight))
            self.imageView.image = UIImage.init(named: images[i] as! String)
            self.imageView.isUserInteractionEnabled = true
            scr.addSubview(self.imageView)
            let btn = UIButton.init(type: UIButton.ButtonType.custom)
            btn.setTitle("点击进入", for: UIControl.State.normal)
            btn.frame = CGRect.init(x: screenWidth * CGFloat(i), y: screenHeight - 100, width: 120, height: 35)
            btn.center = CGPoint.init(x: screenWidth / 2, y: screenHeight - 100)
            btn.layer.cornerRadius = 17.5
            btn.clipsToBounds = true
            btn.setTitleColor(UIColor.red, for: UIControl.State.normal)
            btn.layer.borderWidth = 1
            btn.backgroundColor = UIColor .cyan
            btn.addTarget(self, action: #selector(clickEnter), for: .touchUpInside)
            if i == images.count - 1 {
                self.imageView.addSubview(btn)
                
            }
        }
        scr.contentSize = CGSize.init(width: screenWidth * CGFloat(images.count), height: 0)
        self.view.addSubview(scr)
        
        self.pageControl = UIPageControl.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth / 2, height: 30))
        self.pageControl.center = CGPoint.init(x: screenWidth / 2, y: screenHeight - 50)
        self.pageControl.numberOfPages =  images.count
        self.pageControl.currentPageIndicatorTintColor = UIColor.gray
        self.pageControl.pageIndicatorTintColor = UIColor.blue
        self.view.addSubview(self.pageControl)
    }
    @objc func clickEnter() {
//        if removeFromBlcok != nil {
//            removeFromBlcok!()
//        }
        if delegateMeothod != nil {
            delegateMeothod?.removeDelegateMethod()
        }
        
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.pageControl.currentPage = Int(scrollView.contentOffset.x / screenWidth) 
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
