//
//  ZHTableView.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/7/6.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

class ZHTableView: UITableView {

    //MARK: Lazy loading
    lazy var imp: ZHTableViewIMP = {
        let imp  = ZHTableViewIMP();
        imp.tableViewDidScrollClosure = { [weak self] scorllView in
           self?.tableViewDidScrollClosure?(scorllView);
        }
        
        imp.tableViewDidEndDeceleratingClosure = { [weak self] scorllView in
           self?.tableViewDidEndDeceleratingClosure?(scorllView)
        }
        
        imp.tableViewDidEndDraggingClosure = { [weak self] scorllView,decelerate in
           self?.tableViewDidEndDraggingClosure?(scorllView,decelerate);
        }
        return imp;
    }()
    
    var sectionsArray:[ZHTableViewSection] = [ZHTableViewSection]() {
        didSet
        {
            self.imp.sectionsArray = sectionsArray;
        }
    }
    
    //MARK: Closure
    var tableViewDidScrollClosure:ZHTableViewDidScrollClosure?
    var tableViewDidEndDeceleratingClosure:ZHTableViewDidEndDeceleratingClosure?
    var tableViewDidEndDraggingClosure:ZHTableViewDidEndDraggingClosure?
    
    
    func onConguration()
    {
        self.backgroundColor = UIColor.clear;
        self.showsHorizontalScrollIndicator = false;
        self.separatorStyle = .none;
        
        if #available(iOS 11.0, *)
        {
            self.estimatedRowHeight = 0.0;
            self.estimatedSectionHeaderHeight = 0.0;
            self.estimatedSectionFooterHeight = 0.0;
            self.contentInsetAdjustmentBehavior = .never;
        }else
        {
            if #available(iOS 13.0, *) {
                self.automaticallyAdjustsScrollIndicatorInsets = false
            } else {
                // Fallback on earlier versions
            };
        }
        
        self.delegate   = self.imp;
        self.dataSource = self.imp;
    }
    
    override init(frame: CGRect, style: UITableView.Style)
    {
        super.init(frame: frame, style: style);
        self.onConguration();
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
