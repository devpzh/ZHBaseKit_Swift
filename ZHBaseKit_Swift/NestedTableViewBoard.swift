//
//  NestedTableViewBoard.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/7/17.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

class NestedTableViewBoard: ZHBaseTableViewBoard {

    override func onViewCreate() {
        super.onViewCreate();
        self.onShowNavigationTitle("NestedTableView");
        self.onConfiguration();
    }
    
    func onConfiguration()  {
        
        
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
        
        for i in 0..<20
        {
            let item = NormalCellModel();
            item.title = "row = "+"\(i)" ;
            self.section.rowsArray.append(item);
        }
        
        
        //MARK: 嵌套 collectionView
        let collectionViewModel = ZHBaseCollectionViewModel();
        collectionViewModel.cellHeight = (kScreenWidth-30)/2+20;
        collectionViewModel.section.minimumLineSpacing = 10.0;
        collectionViewModel.section.minimumInteritemSpacing = 10.0;
        collectionViewModel.section.edgeInsets = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10);
        for i in 0..<10
        {
            let item = CollectionCellModel();
            item.title = "item \(i)";
            collectionViewModel.section.rowsArray.append(item);
        }
        self.section.rowsArray.append(collectionViewModel);
        
        
        for i in 0..<20
        {
            let item = NormalCellModel();
            item.title = "row = "+"\(i)" ;
            self.section.rowsArray.append(item);
        }
        
        self.tableView.reloadData();
    }

}
