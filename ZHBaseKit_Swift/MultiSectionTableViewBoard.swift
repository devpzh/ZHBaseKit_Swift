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
          self.tableView.sections.removeAll();
        
          let section1 = ZHTableViewSection();
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
           
           for i in 0..<10
           {
               let item = NormalCellModel();
               item.title = "row = "+"\(i)" ;
               section1.rows.append(item);
           }
           
          self.tableView.sections.append(section1);
        
        
          let section2 = ZHTableViewSection();
          section2.header = {
               let model = NormalCellModel();
               model.title = "Section2 Header";
               return model;
           }()
           
           section2.footer = {
               let model = NormalCellModel();
               model.title = "Section2 Footer";
               return model;
           }()
           
           for i in 0..<10
           {
               let item = NormalCellModel();
               item.title = "row = "+"\(i)" ;
               section2.rows.append(item);
           }
           self.tableView.sections.append(section2);
        
        self.tableView.reloadData();
           
       }
}
