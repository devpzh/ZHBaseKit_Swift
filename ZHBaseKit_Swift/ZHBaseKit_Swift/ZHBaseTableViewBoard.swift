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
    var sectionsArray:[ZHTableViewSection] = [ZHTableViewSection]() {
        didSet{
            if sectionsArray != self.tableView.sectionsArray {
                self.tableView.sectionsArray = sectionsArray;
            }
        }
    }
    
    //MARK: Func
    override func onViewCreate() {
        super.onViewCreate();
        
        // refresh
        self.onRefreshHeaderCreate();
        self.onRefreshFooterCreate();
        
        // add default section
        self.sectionsArray.append(self.section);
        
    }
    
    override func onViewLayout() {
        super.onViewLayout();
        self.tableView.frame = CGRect.init(x: 0, y: kNavigationBarHeight, width: kScreenWidth, height: kScreenHeight-kNavigationBarHeight);
    }

    func onRefreshHeaderCreate(){
        
    }
    
    func onRefreshFooterCreate(){
        
    }
    
}
