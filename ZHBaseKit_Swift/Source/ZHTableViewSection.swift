//
//  ZHTableViewSection.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/7/1.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

open class ZHTableViewSection: NSObject
{
    //MARK: Section Header Model
    public var headerModel : ZHBaseCellModel?;
    
    //MARK: Section Footer Model
    public var footerModel : ZHBaseCellModel?;
    
    //MARK: Cell Models
    public lazy var rowsArray:[ZHBaseCellModel] =
    {
        return [ZHBaseCellModel]();
    }()
    
}
