//
//  TabbarBoard.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/11/13.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

class TabbarBoard : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onTabbarAppearance()
        onTabbarControllers()
    }
    
    func onTabbarAppearance() {
        UITabBar.appearance().tintColor = .black
        UITabBar.appearance().unselectedItemTintColor = .lightGray
    }
    
    func onTabbarControllers() {
        
        let home  = ZHNavigationBoard.init(rootViewController: MainBoard())
        let me    = ZHNavigationBoard.init(rootViewController: MineBoard())
        
        home.tabBarItem  = UITabBarItem(title:"首页", image:  UIImage(named: "tabbar_home_default"), selectedImage: UIImage(named: "tabbar_home_select"))
        me.tabBarItem  = UITabBarItem(title:"排行", image: UIImage(named: "tabbar_mine_default"), selectedImage: UIImage(named: "tabbar_mine_select"))
       
        viewControllers = [home,me]
    }
    
}
