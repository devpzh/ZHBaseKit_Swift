//
//  ZHBaseKit.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/6/24.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

class ZHBaseKit: NSObject
{
    static let shared:ZHBaseKit = ZHBaseKit();
    
    //MARK:背景色
    var backgroundColor         = UIColor.white;
    
    //MARK:导航栏背景色
    var naviBarBackgroundColor  = UIColor.white;
    
    //MARK:导航栏字体颜色
    var naviBarTitleColor       = UIColor.black;
    
    //MARK:导航栏 leftItem 字体颜色
    var leftItemTitleColor      = UIColor.black;
    
    //MARK:导航栏 rightItem 字体颜色
    var rightItemTitleColor     = UIColor.black;
    
    //MARK:导航栏标题字体大小
    var titleFont = kFont(16.0);
    
    //MARK:导航栏 leftItem 字体大小
    var leftItemTitleFont = kFont(14.0);
    
    //MARK:导航栏 rightItem 字体大小
    var rightItemTitleFont = kFont(14.0);
    
    //MARK:导航栏 leftItem  边距
    var leftItemMarginLeft = 15.0;
    
    //MARK:导航栏 rightItem 边距
    var rightItemMarginRight = 15.0;
    
    //MARK:导航栏下划线颜色
    var naviBarSeparatorColor = UIColor.lightGray;
    
    //MARK:返回按钮
    var backIcon:String  = "back";
    
    override init() {
        
    }
}
