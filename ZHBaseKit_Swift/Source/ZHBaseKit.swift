//
//  ZHBaseKit.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/6/24.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

public struct ZH {
   public static let kit = ZHBaseKit.shared
}

open class ZHBaseKit: NSObject
{
    public static let shared:ZHBaseKit = ZHBaseKit();
    
    //MARK:背景色
    public var backgroundColor         = UIColor.white;
    
    //MARK:导航栏背景色
    public var naviBarBackgroundColor  = UIColor.white;
    
    //MARK:导航栏字体颜色
    public var naviBarTitleColor       = UIColor.black;
    
    //MARK:导航栏 leftItem 字体颜色
    public var leftItemTitleColor      = UIColor.black;
    
    //MARK:导航栏 rightItem 字体颜色
    public var rightItemTitleColor     = UIColor.black;
    
    //MARK:导航栏标题字体大小
    public var titleFont = kFont(16.0);
    
    //MARK:导航栏 leftItem 字体大小
    public var leftItemTitleFont = kFont(14.0);
    
    //MARK:导航栏 rightItem 字体大小
    public var rightItemTitleFont = kFont(14.0);
    
    //MARK:导航栏 leftItem  边距
    public var leftItemMarginLeft = 15.0;
    
    //MARK:导航栏 rightItem 边距
    public var rightItemMarginRight = 15.0;
    
    //MARK:导航栏下划线颜色
    public var naviBarSeparatorColor = UIColor.lightGray;
    
    //MARK:返回按钮
    public var backIcon:String  = "back";
    
    //MARK:状态栏模式
    public var statusBarStyle:ZHStatusBarStyle = .system;
    
    //MARK:init
    public override init() {
        
    }
}
