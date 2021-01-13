//
//  CollectionViewBoard.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/7/15.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

class CollectionViewBoard: ZHBaseCollectionViewBoard {

    override func onViewCreate() {
        super.onViewCreate();
        self.onShowNavigationTitle("Single Section");
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
        
        for i in 0..<10
        {
            let item = CollectionCellModel();
            item.title = "item \(i)";
            self.section.rowsArray.append(item);
            self.collectionView.reloadData();
        }
        
    }
}
