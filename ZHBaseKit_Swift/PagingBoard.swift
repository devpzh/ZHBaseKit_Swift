//
//  PagingBoard.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/11/3.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit
import JXSegmentedView

let kMenuHeight = 40.0;
class PagingBoard: ZHBaseBoard {

    lazy var listContainerView: JXSegmentedListContainerView = {
        let listContainerView = JXSegmentedListContainerView(dataSource: self);
        self.view.addSubview(listContainerView);
        return listContainerView;
    }()
    
    lazy var segmentedDataSource: JXSegmentedTitleDataSource = {
        let segmentedDataSource = JXSegmentedTitleDataSource();
        segmentedDataSource.titles = ["page1","page2","page3"];
        return segmentedDataSource;
    }()
    
    lazy var segmentedView: JXSegmentedView = {
        
        let segmentedView = JXSegmentedView()
        segmentedView.dataSource = self.segmentedDataSource;
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorHeight = 1;
        segmentedView.indicators = [indicator]
        segmentedView.listContainer = self.listContainerView;
        self.view.addSubview(segmentedView);
        return segmentedView;
        
    }()
    
    override func onViewCreate() {
        super.onViewCreate();
        self.onShowNavigationTitle("Paging Board");
        
    }
    
    override func onViewLayout() {
        
        self.segmentedView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(kNavigationBarHeight);
            make.left.right.equalTo(self.view);
            make.height.equalTo(kMenuHeight);
        }
        
        self.listContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.segmentedView.snp.bottom);
            make.left.right.bottom.equalTo(self.view);
        }
    }
    
}

extension PagingBoard:JXSegmentedListContainerViewDataSource
{
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        self.segmentedDataSource.titles.count;
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        return  PagingItemBoard();
    }
    
    
}
