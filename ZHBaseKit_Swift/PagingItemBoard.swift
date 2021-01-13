//
//  PagingItemBoard.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/11/3.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit
import JXSegmentedView
class PagingItemBoard: ZHBaseTableViewBoard {

    override func onViewCreate() {
        super.onViewCreate();
        self.onHiddenNavigationBar();
        self.onConfiguration();
    }
    
    override func onViewLayout() {
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view);
        }
    }
    
    func onConfiguration()  {
        
        self.section.headerModel = {
            let model = NormalCellModel();
            model.title = "Section Header";
            return model;
        }()
        
        self.section.footerModel = {
            let model = NormalCellModel();
            model.title = "Section Footer";
            return model;
        }()
        
        for i in 0..<10
        {
            let item = NormalCellModel();
            item.title = "row = "+"\(i)" ;
            self.section.rowsArray.append(item);
            self.tableView.reloadData();
        }
        
    }
    
}

extension PagingItemBoard:JXSegmentedListContainerViewListDelegate
{
    func listView() -> UIView {
        return self.view;
    }
}
