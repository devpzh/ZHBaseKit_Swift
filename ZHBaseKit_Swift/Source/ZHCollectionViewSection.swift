//
//  ZHCollectionViewSection.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/7/9.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

open class ZHCollectionViewSection: NSObject{
    
  //MARK: minimumLineSpacing
  public var minimumLineSpacing:CGFloat = 0.0
    
  //MARK: minimumInteritemSpacing
  public var minimumInteritemSpacing:CGFloat = 0.0
    
  //MARK: edgeInset
  public var edgeInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
  //MARK: Section Header Model
  public var header : ZHBaseCellModel?
    
  //MARK: Section Footer Model
  public var footer : ZHBaseCellModel?
    
    //MARK: Cell Models
  public lazy var rows:[ZHBaseCellModel] =
  {
        return [ZHBaseCellModel]()
            
  }()
    

}
