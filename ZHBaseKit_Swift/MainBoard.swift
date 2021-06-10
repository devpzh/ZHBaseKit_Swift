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

class MainBoard: ZHBaseTableViewBoard{
    
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
            
    
        self.MSG(TestInterface.checkVersion(msg:)).send().response = { msg in
            
            print("status = \(msg.status!)");
            
        };
        
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
    

    func onCheckVersion(msg:ZHMessage) {
        
        print("status = \(msg.status!)");
        
    }
    
    
}

extension MainBoard:ZHProtocol {

    func onTouch(_ cell: ZHBaseCell, data: ZHBaseCellModel) {
        
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
    
}

class TestInterface: ZHController{
    
    class func checkVersion(msg:ZHMessage)
    {
       
        switch msg.status!
        {
            case .Sending:
                ZHController.HTTP_GET(msg,"supplement/sys/version/check")
                Toast.presentLoadingTips("加载...")

            case .Succeed:
                print("\(msg.responseData!)");
                Toast.dismiss();
                Toast.presentTips("请求成功");

            case .Cancel:
                break

            case .Failed:
                Toast.dismiss();
                Toast.presentTips("请求失败");
                break;
        }
        
    }
    
}
