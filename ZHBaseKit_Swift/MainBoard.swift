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
        self.onShowRightItemWithTitle("Request");
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
            ZH.router.router(url:"PagingBoard");
            return;
        }
        
        let model = data as! NormalCellModel;
        
        if model.title == kSingleSectionTableView {
           
            ZH.router.router(url:"TableViewBoard",params:["key":1,"key1":"2","key3":"3.0"], present:false)
            
        }else if model.title == kMultiSectionTableView
        {
            ZH.router.router(url:"MultiSectionTableViewBoard");
        
        }else if model.title == kSingleSectionCollectionView
        {
            ZH.router.router(url:"CollectionViewBoard");
        
        }else if model.title == kMultiSectionCollectionView
        {
            ZH.router.router(url:"MultiSectionCollectionViewBoard");
       
        }else if model.title == kNestedTableView
        {
            ZH.router.router(url: "NestedTableViewBoard");
        
        }else if model.title == kNestedCollectionView
        {
            ZH.router.router(url:"NestedCollectionViewBoard");
        }
        
    }
    
}

class TestInterface: ZHController{
    
    class func checkVersion(msg:ZHMessage)
    {
       
        switch msg.status!
        {
            case .Sending:
                ZHController.HTTP_GET(msg,"")
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
