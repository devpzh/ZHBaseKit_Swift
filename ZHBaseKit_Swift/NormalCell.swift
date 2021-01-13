//
//  NormalCell.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/7/6.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

class NormalCell: ZHBaseCell {

    lazy var titleLb: UILabel = {
        let titleLb = UILabel.init();
        titleLb.textColor = UIColor.black;
        titleLb.font      = kFont(14);
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
        super.onLoad()
        
        self.backgroundColor = UIColor.white;
        
        self.titleLb.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(kPadding);
            make.centerY.equalTo(self);
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
        
        let model = self.data as! NormalCellModel;
        self.titleLb.text = model.title;
        
    }
    
    override func onTouch() {
        
        if self.delegate != nil {

            if self.delegate!.responds(to: #selector(ZHProtocol.onTouch(_:_:)))
            {
                self.delegate?.onTouch(self, self.data!);

            }

         }
    }
    

}
