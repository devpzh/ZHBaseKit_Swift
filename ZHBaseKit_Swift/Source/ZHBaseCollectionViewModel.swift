//
//  ZHBaseCollectionViewModel.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/7/17.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

open class ZHBaseCollectionViewModel: ZHBaseCellModel {

    //MARK: default section
    public lazy var section: ZHCollectionViewSection = {
        return ZHCollectionViewSection();
    }()
    
    //MARK: sections
    public lazy var sections:[ZHCollectionViewSection] = {
        return [ZHCollectionViewSection]();
    }()
    
    //MARK: scrollDirection
    public var scrollDirection: UICollectionView.ScrollDirection = .horizontal;
    
    //MARK: pagingEnabled
    public var pagingEnabled = false;
    
    //MARK: scrollEnabled
    public var scrollEnabled = true;
    
    //MARK: showsHorizontalScrollIndicator
    public var showsHorizontalScrollIndicator = false;
    
    //MARK: showsVerticalScrollIndicator
    public var showsVerticalScrollIndicator = false;
    
    public override init() {
        super.init();
        self.cellClassName = "ZHBaseCollectionView";
        self.sections.append(self.section);
        
    }
}
