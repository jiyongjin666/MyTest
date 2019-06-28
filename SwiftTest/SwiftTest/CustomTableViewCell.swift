//
//  CustomTableViewCell.swift
//  SwiftTest
//
//  Created by bobao on 2019/6/27.
//  Copyright © 2019 bobao. All rights reserved.
//

import UIKit
class CustomTableViewCell: UITableViewCell {
    var titleLabel:UILabel!
    var leftImageView:UIImageView!
    var newModel: GHItem!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style:style, reuseIdentifier: reuseIdentifier)
       setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUI() {
        self.leftImageView = UIImageView.init()
        self.contentView.addSubview(self.leftImageView)
        self.leftImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(5)
            make.width.height.equalTo(40)
        }
        self.leftImageView.backgroundColor = UIColor.red
        self.titleLabel = UILabel.init()
        self.titleLabel.font = kFont(font: kFontSize(size: 14))
        self.contentView.addSubview(self.titleLabel!)
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.leftImageView)
            make.left.equalTo(self.leftImageView.snp.right).offset(10)
            make.right.equalToSuperview().offset(0)
        }
    }
    var model: GHItem {
        get {
          return self.newModel
        }
        set {
            self.newModel = newValue
            let str:String = self.newModel.images!.first as! String
            
            let  url = URL(string:str)
            
            self.leftImageView.kf.setImage(with:url)
            self.titleLabel.text = self.newModel.title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
