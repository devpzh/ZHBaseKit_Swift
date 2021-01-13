//
//  ZHBaseCollectionViewBoard.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/7/15.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

class ZHBaseCollectionViewBoard: ZHBaseBoard,ZHCollectionViewLayoutDelegate{

    //MARK: collectionView
    lazy var collectionView: ZHCollectionView = {
        let collectionView = ZHCollectionView.init(self);
        self.view.addSubview(collectionView);
        return collectionView;
    }()
    
    //MARK: default section
    lazy var section: ZHCollectionViewSection = {
        return ZHCollectionViewSection();
    }()
    
    //MARK: sectionsArray
    lazy var sectionsArray:[ZHCollectionViewSection] = {
          return [ZHCollectionViewSection]();
    }()
    
    override func onViewCreate() {
        super.onViewCreate();
        
        // add default section
        self.sectionsArray.append(self.section);
        self.collectionView.sectionsArray = self.sectionsArray;
    }
    
    override func onViewLayout() {
        super.onViewLayout();
        self.collectionView.frame = CGRect.init(x: 0, y: kNavigationBarHeight, width: kScreenWidth, height: kScreenHeight-kNavigationBarHeight);
    }
    
}
