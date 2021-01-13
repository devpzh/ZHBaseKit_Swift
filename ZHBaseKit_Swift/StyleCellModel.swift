//
//  StyleCellModel.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/11/3.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

class StyleCellModel: ZHBaseCellModel {

    var title:String?
    var iconName:String?
    
    override init() {
        super.init();
        self.cellClassName = "StyleCell";
        self.cellHeight    = 44.0;
    }
    
}
