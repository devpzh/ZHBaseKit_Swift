//
//  NormalCellModel.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/7/6.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

class NormalCellModel: ZHBaseCellModel {

    var title:String = "";
    override init() {
        super.init();
        self.cellClassName = "NormalCell";
        self.cellHeight    = 44.0;
    }
}
