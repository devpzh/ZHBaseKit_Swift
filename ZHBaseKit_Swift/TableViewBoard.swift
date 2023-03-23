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
       
        print("routerParams: \(String(describing: self.routerParams))");
        
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
            item.delegate = self
            item.title = "row = "+"\(i)" ;
            self.section.rowsArray.append(item);
            self.tableView.reloadData();
        }
        
    }

    
}

extension TableViewBoard:ZHProtocol {
    
    func onTouch(_ cell: ZHBaseCell, data: ZHBaseCellModel) {
        ZH.router.router(url: "TableViewBoard", present: true,presentationStyle: .pageSheet)
    }
}
