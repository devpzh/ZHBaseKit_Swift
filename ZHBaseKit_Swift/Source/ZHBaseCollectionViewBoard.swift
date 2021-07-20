//
//  ZHBaseCollectionViewBoard.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/7/15.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

open class ZHBaseCollectionViewBoard: ZHBaseBoard,ZHCollectionViewLayoutDelegate{

    //MARK: collectionView
    public lazy var collectionView: ZHCollectionView = {
        let collectionView = ZHCollectionView.init(self);
        collectionView.alwaysBounceVertical = true;
        self.view.addSubview(collectionView);
        return collectionView;
    }()
    
    //MARK: default section
    public lazy var section: ZHCollectionViewSection = {
        return ZHCollectionViewSection();
    }()
    
    //MARK: sectionsArray
    public var sectionsArray:[ZHCollectionViewSection] = [ZHCollectionViewSection]() {
        didSet{
            if sectionsArray != self.collectionView.sectionsArray {
                self.collectionView.sectionsArray = sectionsArray;
            }
        }
    }
    
    open override func onViewCreate() {
        super.onViewCreate();
        
        // refresh
        self.onRefreshHeaderCreate();
        self.onRefreshFooterCreate();
        
        // add default section
        self.sectionsArray.append(self.section);
       
    }
    
    open override func onViewLayout() {
        super.onViewLayout();
        self.collectionView.frame = CGRect.init(x: 0, y: kNavigationBarHeight, width: kScreenWidth, height: kScreenHeight-kNavigationBarHeight);
    }
    
    
    open func onRefreshHeaderCreate(){
        
    }
    
    open func onRefreshFooterCreate(){
        
    }
}
