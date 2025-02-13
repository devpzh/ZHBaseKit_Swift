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
        let collectionView = ZHCollectionView.init(self)
        collectionView.alwaysBounceVertical = true
        self.view.addSubview(collectionView)
        return collectionView
    }()
    
    //MARK: default section
    public lazy var section: ZHCollectionViewSection = {
        return ZHCollectionViewSection()
    }()
    
    //MARK: sections
    public var sections:[ZHCollectionViewSection] = [ZHCollectionViewSection]() {
        didSet{
            if sections != self.collectionView.sections {
                self.collectionView.sections = sections
            }
        }
    }
    
    open override func onViewCreate() {
        super.onViewCreate()
                
        // add default section
        self.sections.append(self.section)
       
    }
    
    //onViewLayout
    open override func onViewLayout() {
        super.onViewLayout()
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom)
            make.leading.trailing.bottom.equalTo(view)
        }
        
    }
    
}
