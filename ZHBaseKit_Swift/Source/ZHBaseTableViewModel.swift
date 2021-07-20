//
//  ZHBaseTableViewModel.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/7/20.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

class ZHBaseTableViewModel: ZHBaseCellModel {

    //MARK: default section
    lazy var section: ZHTableViewSection = {
        return ZHTableViewSection();
    }()
    
    //MARK: sectionsArray
    lazy var sectionsArray: [ZHTableViewSection] = {
        return [ZHTableViewSection]();
    }()
    
    //MARK: tableView.tableHeaderView,非 sectionHeader
    var tableHeaderViewModel:ZHBaseCellModel?
    
    //MARK: tableView.tableFooterView,非 sectionFooter
    var tableFooterViewModel:ZHBaseCellModel?
    
    //MARK: scrollEnabled
    var scrollEnabled = true;
    
    //MARK: showsHorizontalScrollIndicator
    var showsHorizontalScrollIndicator = false;
    
    //MARK: showsVerticalScrollIndicator
    var showsVerticalScrollIndicator = false;
    
    
    override init() {
        super.init();
        self.cellClassName = "ZHBaseTableView";
        self.sectionsArray.append(self.section);
    }
    
}
