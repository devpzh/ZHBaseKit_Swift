//
//  ZHBaseTableView.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/7/20.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

open class ZHBaseTableView: ZHBaseCell {
    
    //MARK: tableView
   public lazy var tableView: ZHTableView = {
        let tableView = ZHTableView()
        self.addSubview(tableView)
        return tableView
    }()
    
    //MARK: tableView.tableHeaderView,非 sectionHeader
    public var tableHeaderViewModel:ZHBaseCellModel?
    
    //MARK: tableView.tableFooterView,非 sectionFooter
    var tableFooterViewModel:ZHBaseCellModel?
    
    public lazy var config:ZHBaseTableViewModel = {
         
        if let model = data as? ZHBaseTableViewModel{
            return model
        }
        return ZHBaseTableViewModel()
    }()

    
    open override func onLoad() {
        super.onLoad()
        self.enabled = false
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    open override func dataDidChange() {
        
        guard let model = self.data as? ZHBaseTableViewModel else { return }
    
        self.onConfigurationTableHeaderView(model.tableHeaderViewModel)
        self.onConfigurationTableFooterView(model.tableFooterViewModel)
        self.tableView.isScrollEnabled = model.scrollEnabled
        self.tableView.showsVerticalScrollIndicator  = model.showsVerticalScrollIndicator
        self.tableView.showsHorizontalScrollIndicator = model.showsHorizontalScrollIndicator
        self.tableView.sections = model.sections
        self.tableView.reloadData()
    }
   
   open func reloadData() {
    
       if data != config {
           data = config
           return
       }
       
       if self.tableView.sections != config.sections {
           self.tableView.sections = config.sections
       }
       
       self.tableView.reloadData()
    }
    
   open func onConfigurationTableHeaderView(_ headerViewModel:ZHBaseCellModel?){
      
        if self.tableHeaderViewModel != nil && self.tableHeaderViewModel!.cellClassName == headerViewModel?.cellClassName
        {
            let header = self.tableView.tableHeaderView as! ZHBaseCell
            header.data = tableHeaderViewModel
        
        }else{
            
            let header = self.onMappingCell(headerViewModel)
            header?.frame = CGRect.init(x: 0, y: 0, width: headerViewModel!.cellWidth, height: headerViewModel!.cellHeight  ?? 0)
            self.tableView.tableHeaderView = header
        }
        
        self.tableHeaderViewModel = headerViewModel
    }
    
    
    open func onConfigurationTableFooterView(_ footerViewModel:ZHBaseCellModel?){
        
        if self.tableFooterViewModel != nil && self.tableFooterViewModel!.cellClassName == footerViewModel?.cellClassName
        {
            let footer = self.tableView.tableFooterView as! ZHBaseCell
            footer.data = tableHeaderViewModel
        
        }else{
            
            let footer = self.onMappingCell(footerViewModel)
            footer?.frame = CGRect.init(x: 0, y: 0, width: footerViewModel!.cellWidth, height: footerViewModel!.cellHeight ?? 0)
            self.tableView.tableFooterView = footer
        }
        
        self.tableFooterViewModel = footerViewModel
        
    }
    
    open func onMappingCell(_ model:ZHBaseCellModel?) -> ZHBaseCell?{
        
        if model == nil {
            return nil
        }
        
        let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"]
        let clazz : AnyClass = NSClassFromString((nameSpace as! String) + "." + model!.cellClassName)!
        let clazzType = clazz as! ZHBaseCell.Type
        return clazzType.init()
    }
    
    
}
