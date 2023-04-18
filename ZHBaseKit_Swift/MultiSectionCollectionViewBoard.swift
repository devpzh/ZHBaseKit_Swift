//
//  MultiSectionCollectionViewBoard.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/7/16.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

class MultiSectionCollectionViewBoard: ZHBaseCollectionViewBoard {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.onShowNavigationTitle("Multi Section")
        self.onConfiguration();
    }
    
    func onConfiguration(){
        
        self.sections.removeAll();
        
        let section1 = ZHCollectionViewSection();
        section1.edgeInsets = UIEdgeInsets.init(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0);
        section1.minimumLineSpacing = 10.0;
        section1.minimumInteritemSpacing = 10.0;
        
        section1.header = {
            let model = NormalCellModel();
            model.title = "Section1 Header";
            return model;
        }()
        
        section1.footer = {
            let model = NormalCellModel();
            model.title = "Section1 Footer";
            return model;
        }()
        
        for i in 0..<4
        {
            let item = CollectionCellModel();
            item.title = "item \(i)";
            section1.rows.append(item);
        }
        
        self.collectionView.sections.append(section1);
        
        
        let section2 = ZHCollectionViewSection();
        section2.edgeInsets = UIEdgeInsets.init(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0);
        section2.minimumLineSpacing = 10.0;
        section2.minimumInteritemSpacing = 10.0;
        
        section2.header = {
            let model = NormalCellModel();
            model.title = "Section1 Header";
            return model;
        }()
        
        section2.footer = {
            let model = NormalCellModel();
            model.title = "Section1 Footer";
            return model;
        }()
        
        for i in 0..<4
        {
            let item = CollectionCellModel();
            item.title = "item \(i)";
            section2.rows.append(item);
        }
        
        self.collectionView.sections.append(section2);
        
    }

}
