//
//  TableViewBoard.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/7/9.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

class TableViewBoard: ZHBaseTableViewBoard {

    override func onViewCreate() {
        super.onViewCreate();
        self.onShowNavigationTitle("Single Section");
        self.onConfiguration();
       
        print("routerParams: \(self.routerParams!)");
        
    }

    func onConfiguration()
    {
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
