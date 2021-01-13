//
//  ZHProtocol.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/5/19.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

@objc protocol ZHProtocol : class
{
    @objc optional func onTouch(_ cell:ZHBaseCell, _ data:ZHBaseCellModel);
}


