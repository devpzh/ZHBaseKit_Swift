//
//  ZHCollectionViewIMP.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/7/9.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

let kCollectionViewCellContentViewTag       = 10000;
let kUICollectionReusableViewContentViewTag = 10001;

typealias ZHCollectionViewDidScrollClosure = (UIScrollView)->();
typealias ZHCollectionViewDidEndDeceleratingClosure = (UIScrollView)->();
typealias ZHCollectionViewDidEndDraggingClosure = (UIScrollView,Bool)->();

class ZHCollectionViewIMP: NSObject,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource{
    
    //MARK: Closure
    var collectionViewDidScrollClosure: ZHCollectionViewDidScrollClosure?
    var collectionViewDidEndDeceleratingClosure: ZHCollectionViewDidEndDeceleratingClosure?
    var collectionViewDidEndDraggingClosure: ZHCollectionViewDidEndDraggingClosure?
    
    //MARK: SectionsArray
    lazy var sectionsArray: [ZHCollectionViewSection] = {
        return [ZHCollectionViewSection]();
    }()

    //MARK: UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.collectionViewDidScrollClosure?(scrollView);
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.collectionViewDidEndDeceleratingClosure?(scrollView);
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.collectionViewDidEndDraggingClosure?(scrollView,decelerate);
    }
    
    //MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let model = self.sectionsArray[indexPath.section].rowsArray[indexPath.row];
        return CGSize.init(width: model.cellWidth, height: model.cellHeight);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let sectionMdl = self.sectionsArray[section];
        return sectionMdl.edgeInsets;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let sectionMdl = self.sectionsArray[section];
        return sectionMdl.minimumLineSpacing;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let sectionMdl = self.sectionsArray[section];
        return sectionMdl.minimumInteritemSpacing;
    }
    
    //MARK : UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.sectionsArray.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionMdl = self.sectionsArray[section];
        return sectionMdl.rowsArray.count;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let sectionMdl = self.sectionsArray[section];
        if sectionMdl.headerModel != nil
        {
            return CGSize.init(width: sectionMdl.headerModel!.cellWidth
                , height: sectionMdl.headerModel!.cellHeight);
        }
        return CGSize.init(width: 0, height: 0);
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let sectionMdl = self.sectionsArray[section];
        if sectionMdl.footerModel != nil
        {
            return CGSize.init(width: sectionMdl.footerModel!.cellWidth
                , height: sectionMdl.footerModel!.cellHeight);
        }
        return CGSize.init(width: 0, height: 0);
    }

    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableView : UICollectionReusableView!;
        let sectionMdl = self.sectionsArray[indexPath.section];
      
        if kind == UICollectionView.elementKindSectionHeader && sectionMdl.headerModel != nil
        {
            reusableView = UICollectionView.collectionView(collectionView: collectionView, viewForSupplementaryElementOfKind: kind, indexPath: indexPath, cellClassName:sectionMdl.headerModel!.cellClassName)
            let contentView:ZHBaseCell = reusableView.viewWithTag(kUICollectionReusableViewContentViewTag) as! ZHBaseCell;
            contentView.data = sectionMdl.headerModel!;
            contentView.reloadSectionsClosure = { [weak collectionView] (animation) in
                UIView.setAnimationsEnabled(false)
                collectionView?.reloadSections(IndexSet.init(integer: indexPath.section));
                UIView.setAnimationsEnabled(true)
            }
            
        }
        
        if kind == UICollectionView.elementKindSectionFooter && sectionMdl.footerModel != nil {
            
            reusableView = UICollectionView.collectionView(collectionView: collectionView, viewForSupplementaryElementOfKind: kind, indexPath: indexPath, cellClassName:sectionMdl.footerModel!.cellClassName);
            let contentView:ZHBaseCell = reusableView.viewWithTag(kUICollectionReusableViewContentViewTag) as! ZHBaseCell;
            contentView.data = sectionMdl.footerModel!;
            contentView.reloadSectionsClosure = { [weak collectionView] (animation) in
                UIView.setAnimationsEnabled(false)
                collectionView?.reloadSections(IndexSet.init(integer: indexPath.section));
                UIView.setAnimationsEnabled(true)
            }
            
        }
        
        return reusableView;
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let model = self.sectionsArray[indexPath.section].rowsArray[indexPath.row];
        let cell =  UICollectionView.collectionView(collectionView: collectionView, indexPath: indexPath, cellClassName: model.cellClassName);
        let contentView:ZHBaseCell = cell.contentView.viewWithTag(kCollectionViewCellContentViewTag) as! ZHBaseCell;
        contentView.data = model;
        contentView.reloadRowsClosure = {[weak collectionView] (animation) in
            UIView.setAnimationsEnabled(false)
            collectionView?.reloadItems(at: [indexPath]);
            UIView.setAnimationsEnabled(true)
        }
        contentView.reloadSectionsClosure = { [weak collectionView] (animation) in
            UIView.setAnimationsEnabled(false)
            collectionView?.reloadSections(IndexSet.init(integer: indexPath.section));
            UIView.setAnimationsEnabled(true)
        }
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        
        guard let zh_collectionView = collectionView as? ZHCollectionView else { return false }
        return zh_collectionView.allowMoveItems;
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        if sourceIndexPath.section == destinationIndexPath.section {
            
            let section = self.sectionsArray[sourceIndexPath.section];
            let model = section.rowsArray[sourceIndexPath.row];
            section.rowsArray.remove(at: sourceIndexPath.row);
            section.rowsArray.insert(model, at: destinationIndexPath.row);
            
        }else
        {
            let section   = self.sectionsArray[sourceIndexPath.section];
            let to_sectiion = self.sectionsArray[destinationIndexPath.section];
            
            let model = section.rowsArray[sourceIndexPath.row];
            let to_model = section.rowsArray[destinationIndexPath.row];
            
            section.rowsArray.remove(at: sourceIndexPath.row);
            section.rowsArray.insert(to_model, at: sourceIndexPath.row);
            
            to_sectiion.rowsArray.remove(at: destinationIndexPath.row);
            to_sectiion.rowsArray.insert(model, at: destinationIndexPath.row);
            
        }
        
        
    }
    
}


extension UICollectionView
{
    class  func collectionView(collectionView: UICollectionView, indexPath:IndexPath, cellClassName:String) -> UICollectionViewCell
    {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellClassName);
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellClassName, for: indexPath);
        
        let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"];
        let clazz : AnyClass = NSClassFromString((nameSpace as! String) + "." + cellClassName)!
        let clazzType = clazz as? ZHBaseCell.Type;
        var contentView = cell.contentView.viewWithTag(kCollectionViewCellContentViewTag);
        
        if contentView == nil
        {
            contentView = clazzType?.init();
            contentView?.tag = kCollectionViewCellContentViewTag;
            cell.contentView.addSubview(contentView!);
            contentView?.snp.makeConstraints({ (make) in
                make.edges.equalTo(cell.contentView);
            })
        }
        
        return cell;
    }
    
    
   class func collectionView(collectionView:UICollectionView,viewForSupplementaryElementOfKind kind:String,indexPath: IndexPath,cellClassName:String) -> UICollectionReusableView
    {
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: cellClassName)
        
        let resuablView = collectionView.dequeueReusableSupplementaryView(ofKind: kind
            , withReuseIdentifier: cellClassName, for: indexPath);
        
        let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"];
        let clazz : AnyClass = NSClassFromString((nameSpace as! String) + "." + cellClassName)!
        let clazzType = clazz as? ZHBaseCell.Type;
        var contentView = resuablView.viewWithTag(kUICollectionReusableViewContentViewTag);
        
        if contentView == nil
        {
           contentView = clazzType?.init();
           contentView?.tag = kUICollectionReusableViewContentViewTag;
           resuablView.addSubview(contentView!);
           contentView?.snp.makeConstraints({ (make) in
              make.edges.equalTo(resuablView);
           })
        }
        
        return resuablView;
    }
    
}
