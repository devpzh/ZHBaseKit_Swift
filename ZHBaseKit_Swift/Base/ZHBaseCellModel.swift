//
//  ZHBaseCellModel.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/5/15.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

class ZHBaseCellModel: NSObject {

    var cellClassName : String  = "";
    var cellWidth     : CGFloat = 0.0;
    var cellHeight    : CGFloat = 0.0;
    weak var delegate : AnyObject?
    
    override init()
    {
        super.init();
        self.cellWidth = kScreenWidth;
    }
    
}
