//
//  TabbarBoard.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/11/13.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit
import CYLTabBarController

class TabbarBoard : CYLTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.onTabbarAppearance();
        self.onTabbarControllers()
    }
    
    func onTabbarAppearance() {
        UITabBar.appearance().tintColor = UIColor.black;
        UITabBar.appearance().unselectedItemTintColor = UIColor.lightGray;
    }
    
    func onTabbarControllers()
    {
        let main = ZHNavigationBoard.addChildControllers(MainBoard());
        let mine = ZHNavigationBoard.addChildControllers(MineBoard());
                
        let mainItem = [CYLTabBarItemTitle:"首页",CYLTabBarItemImage:"tabbar_home_default",CYLTabBarItemSelectedImage:"tabbar_home_select"];
        
        let mineItem = [CYLTabBarItemTitle:"我的",CYLTabBarItemImage:"tabbar_mine_default",CYLTabBarItemSelectedImage:"tabbar_mine_select"];
        
        
        self.tabBarItemsAttributes = [mainItem,mineItem];
        self.viewControllers = [main,mine];
        
    }
    
}
