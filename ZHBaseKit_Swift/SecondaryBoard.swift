//
//  SecondaryBoard.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/6/29.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

class SecondaryBoard: ZHBaseBoard{

    var name = "";
    var age = ""
    
    override func onViewCreate() {
        super.onViewCreate();
        self.onShowNavigationTitle("secondary")
        self.onShowRightItemWithTitle("next")
        print("name == \(self.name) age:\(self.age)");
      
    }
    
    override func onLeftTouch() {
        self.dismiss(animated: true, completion: nil);
    }
    
    override func onRightTouch() {
        Router.routerURL(url: RouterPath("MineBoard"))
    }
    

}

