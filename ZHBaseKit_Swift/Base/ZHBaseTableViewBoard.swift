//
//  ZHBaseTableViewBoard.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/7/6.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

class ZHBaseTableViewBoard: ZHBaseBoard {

    //MARK: Lazy loading
    lazy var tableView: ZHTableView = {
        let tableView = ZHTableView();
        self.view.addSubview(tableView);
        return tableView;
    }()
    
    //MARK: default section
    lazy var section: ZHTableViewSection = {
        return ZHTableViewSection();
    }()
    
    //MARK: sectionsArray
    lazy var sectionsArray:[ZHTableViewSection] = {
       return [ZHTableViewSection]();
    }()
    
    
    //MARK: Func
    override func onViewCreate() {
        super.onViewCreate();
        // add default section
        self.sectionsArray.append(self.section);
        self.tableView.sectionsArray = self.sectionsArray;
    }
    
    override func onViewLayout() {
        super.onViewLayout();
        self.tableView.frame = CGRect.init(x: 0, y: kNavigationBarHeight, width: kScreenWidth, height: kScreenHeight-kNavigationBarHeight);
    }

}
