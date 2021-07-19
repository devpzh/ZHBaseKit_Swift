//
//  ZHTableViewSection.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/7/1.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

class ZHTableViewSection: NSObject
{
    //MARK: Section Header Model
    var headerModel : ZHBaseCellModel?;
    
    //MARK: Section Footer Model
    var footerModel : ZHBaseCellModel?;
    
    //MARK: Cell Models
    lazy var rowsArray:[ZHBaseCellModel] =
    {
        return [ZHBaseCellModel]();
    }()
    
}
