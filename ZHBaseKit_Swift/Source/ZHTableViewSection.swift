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
    public var header:ZHBaseCellModel?;
    
    //MARK: Section Footer Model
    public var footer:ZHBaseCellModel?;
    
    //MARK: Cell Models
    public lazy var rows:[ZHBaseCellModel] =
    {
        return [ZHBaseCellModel]();
    }()
    
}
