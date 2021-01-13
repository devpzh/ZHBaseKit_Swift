//
//  ZHCollectionView.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/7/15.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

@objc protocol ZHCollectionViewLayoutDelegate:class
{
   @objc optional func collectionViewLayout() -> UICollectionViewLayout;
}

class ZHCollectionView: UICollectionView {

    lazy var imp: ZHCollectionViewIMP = {
        let imp = ZHCollectionViewIMP();
        
        imp.collectionViewDidScrollClosure = { [weak self] scorllView in
            self?.collectionViewDidScrollClosure?(scorllView);
        }
        imp.collectionViewDidEndDeceleratingClosure = { [weak self] scorllView in
            self?.collectionViewDidEndDeceleratingClosure?(scorllView)
        }
        imp.collectionViewDidEndDraggingClosure = { [weak self] scorllView,decelerate in
            self?.collectionViewDidEndDraggingClosure?(scorllView,decelerate);
        }
        
        return imp;
    }()
    
    var sectionsArray:[ZHCollectionViewSection] = [ZHCollectionViewSection]() {
        didSet
        {
            self.imp.sectionsArray = sectionsArray;
        }
    }
    
    //MARK: Closure
    var collectionViewDidScrollClosure: ZHCollectionViewDidScrollClosure?
    var collectionViewDidEndDeceleratingClosure: ZHCollectionViewDidEndDeceleratingClosure?
    var collectionViewDidEndDraggingClosure: ZHCollectionViewDidEndDraggingClosure?
    
    func onConfiguration()
    {
        self.backgroundColor = UIColor.clear;
        self.delegate   = self.imp;
        self.dataSource = self.imp;
        self.showsHorizontalScrollIndicator = false;
        if #available(iOS 11.0, *) {
            self.contentInsetAdjustmentBehavior = .never;
        }
    
    }
    
    init(_ delegate : AnyObject?) {
    
        var flowLayout:UICollectionViewLayout?
        
        if delegate != nil
        {
            if delegate!.responds(to:#selector(ZHCollectionViewLayoutDelegate.collectionViewLayout))
            {
                flowLayout =  delegate!.collectionViewLayout();
            }else
            {
                let layout = UICollectionViewFlowLayout.init();
                layout.scrollDirection = .vertical
                flowLayout = layout;
            }
        }else
        {
            let layout = UICollectionViewFlowLayout.init();
            layout.scrollDirection = .vertical
            flowLayout = layout;
        }
        
        super.init(frame: CGRect.zero, collectionViewLayout:flowLayout!)
        self.onConfiguration();
        
    
         
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout);
        self.onConfiguration();
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
   
}
