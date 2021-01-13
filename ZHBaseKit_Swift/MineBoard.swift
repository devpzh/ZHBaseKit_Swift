//
//  MineBoard.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/12/2.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

class MineBoard: ZHBaseBoard {

    override func onViewCreate() {
        super.onViewCreate();
        self.onShowNavigationTitle("我的");
    }
   
    override func onBarLeftItemCreate() {
        
    }
}
