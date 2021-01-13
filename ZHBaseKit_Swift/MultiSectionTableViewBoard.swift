//
//  MultiSectionTableViewBoard.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/7/16.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

class MultiSectionTableViewBoard: ZHBaseTableViewBoard {

    override func onViewCreate() {
        super.onViewCreate();
        self.onShowNavigationTitle("Multi Section")
        self.onConfiguration();
    }
    
    
    func onConfiguration()
       {
          self.tableView.sectionsArray.removeAll();
        
          let section1 = ZHTableViewSection();
          section1.headerModel = {
               let model = NormalCellModel();
               model.title = "Section1 Header";
               return model;
           }()
           
           section1.footerModel = {
               let model = NormalCellModel();
               model.title = "Section1 Footer";
               return model;
           }()
           
           for i in 0..<10
           {
               let item = NormalCellModel();
               item.title = "row = "+"\(i)" ;
               section1.rowsArray.append(item);
           }
           
          self.tableView.sectionsArray.append(section1);
        
        
          let section2 = ZHTableViewSection();
          section2.headerModel = {
               let model = NormalCellModel();
               model.title = "Section2 Header";
               return model;
           }()
           
           section2.footerModel = {
               let model = NormalCellModel();
               model.title = "Section2 Footer";
               return model;
           }()
           
           for i in 0..<10
           {
               let item = NormalCellModel();
               item.title = "row = "+"\(i)" ;
               section2.rowsArray.append(item);
           }
           self.tableView.sectionsArray.append(section2);
        
        self.tableView.reloadData();
           
       }
}
