//
//  ZHBaseTableViewModel.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/7/20.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

open class ZHBaseTableViewModel: ZHBaseCellModel {

    //MARK: default section
    public lazy var section: ZHTableViewSection = {
        return ZHTableViewSection()
    }()
    
    //MARK: sections
    public lazy var sections: [ZHTableViewSection] = {
        return [ZHTableViewSection]()
    }()
    
    //MARK: tableView.tableHeaderView,非 sectionHeader
    public var tableHeaderViewModel:ZHBaseCellModel?
    
    //MARK: tableView.tableFooterView,非 sectionFooter
    public var tableFooterViewModel:ZHBaseCellModel?
    
    //MARK: scrollEnabled
    public var scrollEnabled = true
    
    //MARK: showsHorizontalScrollIndicator
    public var showsHorizontalScrollIndicator = false
    
    //MARK: showsVerticalScrollIndicator
    public var showsVerticalScrollIndicator = false
    
    
    public override init() {
        super.init()
        self.cellClassName = "ZHBaseTableView"
        self.sections.append(self.section)
    }
    
}
