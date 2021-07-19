//
//  ZHBaseCollectionViewModel.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/7/17.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

class ZHBaseCollectionViewModel: ZHBaseCellModel {

    //MARK: default section
    lazy var section: ZHCollectionViewSection = {
        return ZHCollectionViewSection();
    }()
    
    //MARK: sectionsArray
     lazy var sectionsArray:[ZHCollectionViewSection] = {
        return [ZHCollectionViewSection]();
    }()
    
    //MARK: scrollDirection
    var scrollDirection: UICollectionView.ScrollDirection = .horizontal;
    
    //MARK: pagingEnabled
    var pagingEnabled = false;
    
    //MARK: scrollEnabled
    var scrollEnabled = true;
    
    //MARK: showsHorizontalScrollIndicator
    var showsHorizontalScrollIndicator = false;
    
    //MARK: showsVerticalScrollIndicator
    var showsVerticalScrollIndicator = false;
    
    override init() {
        super.init();
        self.cellClassName = "ZHBaseCollectionView";
        self.sectionsArray.append(self.section);
        
    }
}
