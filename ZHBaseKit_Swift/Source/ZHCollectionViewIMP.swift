//
//  ZHCollectionViewIMP.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/7/9.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

public let kCollectionViewCellContentViewTag       = 10000;
public let kUICollectionReusableViewContentViewTag = 10001;
public typealias ZHCollectionViewDidScrollClosure = (UIScrollView)->();
public typealias ZHCollectionViewDidEndDeceleratingClosure = (UIScrollView)->();
public typealias ZHCollectionViewDidEndDraggingClosure = (UIScrollView,Bool)->();
public typealias ZHCollectionViewDidEndMovingClosure   = (ZHIndexPath,ZHIndexPath)->();

public struct ZHIndexPath {
    let section:Int
    let row:Int
}


open class ZHCollectionViewIMP: NSObject,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource{
    
    //MARK: Closure
   public var collectionViewDidScrollClosure: ZHCollectionViewDidScrollClosure?
   public var collectionViewDidEndDeceleratingClosure: ZHCollectionViewDidEndDeceleratingClosure?
   public var collectionViewDidEndDraggingClosure: ZHCollectionViewDidEndDraggingClosure?
   public var collectionViewDidEndMovingClosure: ZHCollectionViewDidEndMovingClosure?
    
    //MARK: SectionsArray
    public lazy var sectionsArray: [ZHCollectionViewSection] = {
        return [ZHCollectionViewSection]();
    }()

    //MARK: UIScrollViewDelegate
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.collectionViewDidScrollClosure?(scrollView);
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.collectionViewDidEndDeceleratingClosure?(scrollView);
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.collectionViewDidEndDraggingClosure?(scrollView,decelerate);
    }
    
    //MARK: UICollectionViewDelegateFlowLayout
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let rows = self.sectionsArray[indexPath.section].rowsArray
        if indexPath.row >= rows.count {
            return .zero
        }
        let model = rows[indexPath.row];
        return CGSize.init(width: model.cellWidth, height: model.cellHeight);
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let sectionMdl = self.sectionsArray[section];
        return sectionMdl.edgeInsets;
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let sectionMdl = self.sectionsArray[section];
        return sectionMdl.minimumLineSpacing;
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let sectionMdl = self.sectionsArray[section];
        return sectionMdl.minimumInteritemSpacing;
    }
    
    //MARK : UICollectionViewDataSource
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.sectionsArray.count;
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionMdl = self.sectionsArray[section];
        return sectionMdl.rowsArray.count;
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let sectionMdl = self.sectionsArray[section];
        if sectionMdl.headerModel != nil
        {
            return CGSize.init(width: sectionMdl.headerModel!.cellWidth
                , height: sectionMdl.headerModel!.cellHeight);
        }
        return CGSize.init(width: 0, height: 0);
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let sectionMdl = self.sectionsArray[section];
        if sectionMdl.footerModel != nil
        {
            return CGSize.init(width: sectionMdl.footerModel!.cellWidth
                , height: sectionMdl.footerModel!.cellHeight);
        }
        return CGSize.init(width: 0, height: 0);
    }

    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
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
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
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
    
    public func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        
        guard let zh_collectionView = collectionView as? ZHCollectionView else { return false }
        
        if zh_collectionView.allowMoveItems == false {
            return false
        }
        
        let sections = zh_collectionView.onlyMoveSections
        if sections.isEmpty {
            return true
        }
        return sections.contains(indexPath.section)
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        if sourceIndexPath.section == destinationIndexPath.section {
            
            let section = self.sectionsArray[sourceIndexPath.section];
            let model = section.rowsArray[sourceIndexPath.row];
            section.rowsArray.remove(at: sourceIndexPath.row);
            section.rowsArray.insert(model, at: destinationIndexPath.row);
            
        }else {
            
            let section    = self.sectionsArray[sourceIndexPath.section];
            let to_section = self.sectionsArray[destinationIndexPath.section];
            let model      = section.rowsArray[sourceIndexPath.row];
            let to_model   = section.rowsArray[destinationIndexPath.row];
            section.rowsArray.remove(at: sourceIndexPath.row);
            section.rowsArray.insert(to_model, at: sourceIndexPath.row);
            to_section.rowsArray.remove(at: destinationIndexPath.row);
            to_section.rowsArray.insert(model, at: destinationIndexPath.row);
        }
        
        let at = ZHIndexPath(section: sourceIndexPath.section, row: sourceIndexPath.row)
        let to = ZHIndexPath(section: destinationIndexPath.section, row: destinationIndexPath.row)
        collectionViewDidEndMovingClosure?(at,to)
        
    }
    
}


public extension UICollectionView
{
    class func collectionView(collectionView: UICollectionView, indexPath:IndexPath, cellClassName:String) -> UICollectionViewCell
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

