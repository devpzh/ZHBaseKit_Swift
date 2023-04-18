//
//  ZHBaseCellModel.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/5/15.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

open class ZHBaseCellModel: NSObject {
    
    public var spaceName     : String? = Bundle.main.infoDictionary?["CFBundleExecutable"] as? String
    public var cellClassName : String  = "";
    public var cellWidth     : CGFloat = 0.0;
    public var cellHeight    : CGFloat = 0.0;
    public weak var delegate : AnyObject?
    
    public override init()
    {
        super.init();
        self.cellWidth = kScreenWidth;
    }
    
}
