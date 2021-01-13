//
//  MainBoard.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/4/10.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

let kSingleSectionTableView             = "TableView Single Section"
let kMultiSectionTableView              = "TableView Multi Section"
let kSingleSectionCollectionView        = "CollectionView Single Section"
let kMultiSectionCollectionView         = "CollectionView Multi  Section"
let kNestedTableView       = "TableView Nested CollectionView"
let kNestedCollectionView  = "CollectionView Nested TableView"

class MainBoard: ZHBaseTableViewBoard,ZHProtocol{
    
    override func onViewCreate() {
        super.onViewCreate();
        self.onShowNavigationTitle("首页");
        self.onShowRightItemWithTitle("next");
        self.onConfiguration();
        
        //MARK: tableViewDidScroll
        self.tableView.tableViewDidScrollClosure = { scrollView in
        
        }
        
       

    }


    override func onBarLeftItemCreate() {
        
    }

    override func onRightTouch() {
              
//      Routes.routesURL(url: RoutesPath("SecondaryBoard"),params: ["name":"123456789","age":"18"],present: true);
        
        self.MSG(TestInterface.checkVersion(msg:),onCheckVersion(msg:)).send();
        
    }
    
    func onConfiguration(){
        
        let singleSectionTableViewModel = { ()-> NormalCellModel in
             let model = NormalCellModel();
             model.delegate = self;
             model.title     = kSingleSectionTableView;
             return model
        }()
        self.section.rowsArray.append(singleSectionTableViewModel);
        
        let multiSectionTableViewModel = { ()-> NormalCellModel in
             let model = NormalCellModel();
             model.delegate = self;
             model.title     = kMultiSectionTableView;
             return model
        }()
        self.section.rowsArray.append(multiSectionTableViewModel);
        
        let singleSectionCollectionViewModel = { ()-> NormalCellModel in
             let model = NormalCellModel();
             model.delegate = self;
             model.title     = kSingleSectionCollectionView;
             return model
        }()
        self.section.rowsArray.append(singleSectionCollectionViewModel);
        
        let multiSectionCollectionViewModel = { ()-> NormalCellModel in
             let model = NormalCellModel();
             model.delegate = self;
             model.title     = kMultiSectionCollectionView;
             return model
        }()
        self.section.rowsArray.append(multiSectionCollectionViewModel);
        
        let nestedTableViewModel = { ()-> NormalCellModel in
             let model = NormalCellModel();
             model.delegate = self;
             model.title     = kNestedTableView;
             return model
        }()
        self.section.rowsArray.append(nestedTableViewModel);
        
        let nestedCollectionViewModel = { ()-> NormalCellModel in
             let model = NormalCellModel();
             model.delegate = self;
             model.title     = kNestedCollectionView;
             return model
        }()
        self.section.rowsArray.append(nestedCollectionViewModel);
        
        
        let styleCellModel = { ()-> StyleCellModel in
            let model = StyleCellModel();
            model.delegate = self;
            model.title    = "PagingViewController";
            model.iconName = "drink_cola";
            return model;
        }()
        self.section.rowsArray.append(styleCellModel);

        self.tableView.reloadData();
    }
    
    func onTouch(_ cell: ZHBaseCell, _ data: ZHBaseCellModel) {
        
        if data.isKind(of: StyleCellModel.self) {
            
            Routes.routesURL(url: RoutesPath("PagingBoard"));
            return;
        }
        
        let model = data as! NormalCellModel;
        
        if model.title == kSingleSectionTableView {
            
            Routes.routesURL(url: RoutesPath("TableViewBoard"));
       
        }else if model.title == kMultiSectionTableView
        {
            Routes.routesURL(url: RoutesPath("MultiSectionTableViewBoard"));
        
        }else if model.title == kSingleSectionCollectionView
        {
            Routes.routesURL(url: RoutesPath("CollectionViewBoard"));
        
        }else if model.title == kMultiSectionCollectionView
        {
            Routes.routesURL(url: RoutesPath("MultiSectionCollectionViewBoard"));
       
        }else if model.title == kNestedTableView
        {
            Routes.routesURL(url: RoutesPath("NestedTableViewBoard"));
        
        }else if model.title == kNestedCollectionView
        {
            Routes.routesURL(url: RoutesPath("NestedCollectionViewBoard"));
        }
        
    }
    
    
    func onCheckVersion(msg:ZHMessage) {
        
        print("status = \(msg.status!)");
        
    }
    
    
}

class TestInterface: ZHInterface{
    
    class func checkVersion(msg:ZHMessage)
    {
       
        switch msg.status!
        {
            case .Sending:
                ZHInterface.HTTP_GET(msg,"supplement/sys/version/check")
                Toast.presentLoadingTips("加载...")

            case .Succeed:
                print("\(msg.responseData!)");
                Toast.dismiss();
                Toast.presentTips("请求成功");

            case .Cancel:
                break

            case .Failed:
                break;
        }
        
    }
    
}
