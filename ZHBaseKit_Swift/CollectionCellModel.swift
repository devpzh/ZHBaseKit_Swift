//
//  CollectionCellModel.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/7/15.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

class CollectionCellModel: ZHBaseCellModel {
    
    var title:String = "";
    
    override init() {
        super.init();
        self.cellClassName = "CollectionCell";
        self.cellWidth     = (kScreenWidth-30)/2;
        self.cellHeight    = self.cellWidth;
    }
}
