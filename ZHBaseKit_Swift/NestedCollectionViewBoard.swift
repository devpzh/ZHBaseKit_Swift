//
//  NestedCollectionViewBoard.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/7/20.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

class NestedCollectionViewBoard: ZHBaseCollectionViewBoard {

    override func onViewCreate() {
        super.onViewCreate();
        self.onShowNavigationTitle("NestedCollectionView")
        self.section.edgeInsets = UIEdgeInsets.init(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0);
        self.section.minimumLineSpacing = 10.0;
        self.section.minimumInteritemSpacing = 10.0;
        self.onConfiguration();
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
        
        for i in 0..<4
        {
            let item = CollectionCellModel();
            item.title = "item \(i)";
            self.section.rowsArray.append(item);
            self.collectionView.reloadData();
        }
        
        //MARK: 嵌套 tableView
        let tableViewModel = ZHBaseTableViewModel();
        tableViewModel.cellHeight = 200;
        for i in 0..<5
        {
            let item = NormalCellModel();
            item.title = "item \(i)";
            tableViewModel.section.rowsArray.append(item);
        }
        self.section.rowsArray.append(tableViewModel);
        
        
        for i in 0..<4
        {
            let item = CollectionCellModel();
            item.title = "item \(i)";
            self.section.rowsArray.append(item);
            self.collectionView.reloadData();
        }
        
        self.collectionView.reloadData();
        
        
    }
    
}
