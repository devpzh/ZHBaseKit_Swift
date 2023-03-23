//
//  ZHBaseTableViewBoard.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/7/6.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

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
    
    //MARK: sectionsArray
    public var sectionsArray:[ZHTableViewSection] = [ZHTableViewSection]() {
        didSet{
            if sectionsArray != self.tableView.sectionsArray {
                self.tableView.sectionsArray = sectionsArray;
            }
        }
    }
    
    //MARK: Func
    open override func onViewCreate() {
        super.onViewCreate();
        
        // add default section
        self.sectionsArray.append(self.section);
        
    }
    
    open override func onViewLayout() {
        super.onViewLayout();
        
        let offsety = isFullScreen ? kNavigationBarHeight:kNavigationBarHeight - kStatusBarHeight
        self.tableView.frame = CGRect.init(x: 0, y: offsety, width: kScreenWidth, height: kScreenHeight-kNavigationBarHeight);
    }

    
}
