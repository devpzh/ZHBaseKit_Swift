//
//  ZHCollectionViewSection.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/7/9.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

class ZHCollectionViewSection: NSObject{
    
    //MARK: minimumLineSpacing
    var minimumLineSpacing:CGFloat = 0.0;
    
    //MARK: minimumInteritemSpacing
    var minimumInteritemSpacing:CGFloat = 0.0;
    
    //MARK: edgeInset
    var edgeInsets: UIEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0);
    
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
