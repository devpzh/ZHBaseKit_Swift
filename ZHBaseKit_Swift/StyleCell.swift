//
//  StyleCell.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/11/3.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

class StyleCell: ZHBaseCell {
    lazy var icon:UIImageView = {
        let icon = UIImageView.init();
        self.addSubview(icon);
        return icon;
    }()
    
    lazy var titleLb: UILabel = {
        let titleLb = UILabel.init();
        titleLb.font = kFont(14);
        titleLb.textColor = UIColor.black;
        self.addSubview(titleLb);
        return titleLb;
    }()
    
    lazy var separator: UIView = {
        let separator = UIView.init();
        separator.backgroundColor = UIColor.lightGray;
        self.addSubview(separator);
        return separator;
    }()
    
    override func onLoad() {
        super.onLoad();
        self.icon.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(kPadding);
            make.centerY.equalTo(self);
            make.size.equalTo(CGSize.init(width: 20.0, height: 20.0))
        }
        self.titleLb.snp.makeConstraints { (make) in
            make.left.equalTo(self.icon.snp.right).offset(kMargin);
            make.centerY.equalTo(self.icon);
        }
        
        self.separator.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(kMargin);
            make.right.equalTo(self).offset(-kMargin);
            make.bottom.equalTo(self);
            make.height.equalTo(0.5);
        }
    }
    
    override func dataDidChange() {
       if self.data == nil {
           return;
       }
        
        let model = self.data as! StyleCellModel;
        self.icon.image = kImageName(model.iconName!);
        self.titleLb.text = model.title;
        
    }
    
    override func onTouch() {
        if self.delegate != nil {
            if self.delegate!.responds(to: #selector(ZHProtocol.onTouch(_:_:))) {
                self.delegate!.onTouch(self, self.data!);
            }
        }
    }
    
}
