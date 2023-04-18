//
//  ZHBaseTableViewBoard.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/7/6.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit
import SnapKit

open class ZHBaseTableViewBoard: ZHBaseBoard {

    //MARK: Lazy loading
    public var tableViewStyle:UITableView.Style = .plain;
    
    //MARK: Lazy loading
    public lazy var tableView: ZHTableView = {
        let tableView =  ZHTableView(frame: CGRect.zero, style: tableViewStyle);
        self.view.addSubview(tableView);
        return tableView;
    }()
    
    //MARK: default section
    public lazy var section: ZHTableViewSection = {
        return ZHTableViewSection();
    }()
    
    //MARK: sections
    public var sections:[ZHTableViewSection] = [ZHTableViewSection]() {
        didSet{
            if sections != self.tableView.sections {
                self.tableView.sections = sections;
            }
        }
    }
    
    //MARK: Func
    open override func onViewCreate() {
        super.onViewCreate();
        
        // add default section
        self.sections.append(self.section);
        
    }
    
    open override func onViewLayout() {
        super.onViewLayout();
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom)
            make.leading.trailing.bottom.equalTo(view)
        }
        
    }

    
}
