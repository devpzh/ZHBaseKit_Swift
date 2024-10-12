//
//  ZHCollectionViewIMP.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/7/9.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

public typealias ZHCollectionViewDidScrollClosure = (UIScrollView)->()
public typealias ZHCollectionViewDidEndDeceleratingClosure = (UIScrollView)->()
public typealias ZHCollectionViewDidEndDraggingClosure = (UIScrollView,Bool)->()
public typealias ZHCollectionViewDidEndMovingClosure   = (ZHIndexPath,ZHIndexPath)->()

public struct ZHIndexPath {
    let section:Int
    let row:Int
}


open class ZHCollectionViewIMP: NSObject,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource{
    
    public struct Tag {
      public static let cell         = 10000
      public static let headerFooter = 10001
    }
    
    //MARK: Closure
   public var collectionViewDidScrollClosure: ZHCollectionViewDidScrollClosure?
   public var collectionViewDidEndDeceleratingClosure: ZHCollectionViewDidEndDeceleratingClosure?
   public var collectionViewDidEndDraggingClosure: ZHCollectionViewDidEndDraggingClosure?
   public var collectionViewDidEndMovingClosure: ZHCollectionViewDidEndMovingClosure?
    
    //MARK: sections
    public lazy var sections: [ZHCollectionViewSection] = {
        return [ZHCollectionViewSection]()
    }()

    //MARK: UIScrollViewDelegate
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.collectionViewDidScrollClosure?(scrollView)
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.collectionViewDidEndDeceleratingClosure?(scrollView)
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.collectionViewDidEndDraggingClosure?(scrollView,decelerate)
    }
    
    //MARK: UICollectionViewDelegateFlowLayout
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let rows = self.sections[indexPath.section].rows
        if indexPath.row >= rows.count {
            return .zero
        }
        let model = rows[indexPath.row]
        return CGSize(width: model.cellWidth, height: model.cellHeight ?? 0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let sec = self.sections[section]
        return sec.edgeInsets
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let sec = self.sections[section]
        return sec.minimumLineSpacing
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let sec = self.sections[section]
        return sec.minimumInteritemSpacing
    }
    
    //MARK : UICollectionViewDataSource
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.sections.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sec = self.sections[section]
        return sec.rows.count
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        guard let header = self.sections[section].header else { return .zero }
        return CGSize(width:header.cellWidth, height: header.cellHeight ?? 0)
        
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        guard let footer = self.sections[section].footer else { return .zero }
        return CGSize(width:footer.cellWidth, height: footer.cellHeight ?? 0)
    
    }

    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableView : UICollectionReusableView!
        let model = self.sections[indexPath.section]
      
        if kind == UICollectionView.elementKindSectionHeader && model.header != nil
        {
            reusableView = UICollectionView.collectionView(collectionView: collectionView, viewForSupplementaryElementOfKind: kind, indexPath: indexPath,spaceName:model.header?.spaceName ?? "", cellClassName:model.header?.cellClassName ?? "")
            let contentView:ZHBaseCell = reusableView.viewWithTag(Tag.headerFooter) as! ZHBaseCell
            contentView.data = model.header
            contentView.reloadSectionsClosure = { [weak collectionView] (animation) in
                UIView.setAnimationsEnabled(false)
                collectionView?.reloadSections(IndexSet.init(integer: indexPath.section))
                UIView.setAnimationsEnabled(true)
            }
            
        }
        
        if kind == UICollectionView.elementKindSectionFooter && model.footer != nil {
            
            reusableView = UICollectionView.collectionView(collectionView: collectionView, viewForSupplementaryElementOfKind: kind, indexPath: indexPath,spaceName:model.footer?.spaceName ?? "", cellClassName:model.footer?.cellClassName ?? "")
            let contentView:ZHBaseCell = reusableView.viewWithTag(Tag.headerFooter) as! ZHBaseCell
            contentView.data = model.footer
            contentView.reloadSectionsClosure = { [weak collectionView] (animation) in
                UIView.setAnimationsEnabled(false)
                collectionView?.reloadSections(IndexSet.init(integer: indexPath.section))
                UIView.setAnimationsEnabled(true)
            }
            
        }
        
        return reusableView
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let model = self.sections[indexPath.section].rows[indexPath.row]
        let cell =  UICollectionView.collectionView(collectionView: collectionView, indexPath: indexPath, spaceName:model.spaceName ?? "",cellClassName: model.cellClassName)
        let contentView:ZHBaseCell = cell.contentView.viewWithTag(Tag.cell) as! ZHBaseCell
        contentView.data = model
        contentView.reloadRowsClosure = {[weak collectionView] (animation) in
            UIView.setAnimationsEnabled(false)
            collectionView?.reloadItems(at: [indexPath])
            UIView.setAnimationsEnabled(true)
        }
        contentView.reloadSectionsClosure = { [weak collectionView] (animation) in
            UIView.setAnimationsEnabled(false)
            collectionView?.reloadSections(IndexSet.init(integer: indexPath.section))
            UIView.setAnimationsEnabled(true)
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        
        guard let _collectionView = collectionView as? ZHCollectionView else { return false }
        
        if _collectionView.allowMoveItems == false {
            return false
        }
        
        let sections = _collectionView.onlyMoveSections
        if sections.isEmpty {
            return true
        }
        return sections.contains(indexPath.section)
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        if sourceIndexPath.section == destinationIndexPath.section {
            
            let section = self.sections[sourceIndexPath.section]
            let model = section.rows[sourceIndexPath.row]
            section.rows.remove(at: sourceIndexPath.row)
            section.rows.insert(model, at: destinationIndexPath.row)
            
        }else {
            
            let section    = self.sections[sourceIndexPath.section]
            let to_section = self.sections[destinationIndexPath.section]
            let model      = section.rows[sourceIndexPath.row]
            let to_model   = section.rows[destinationIndexPath.row]
            section.rows.remove(at: sourceIndexPath.row)
            section.rows.insert(to_model, at: sourceIndexPath.row)
            to_section.rows.remove(at: destinationIndexPath.row)
            to_section.rows.insert(model, at: destinationIndexPath.row)
        }
        
        let at = ZHIndexPath(section: sourceIndexPath.section, row: sourceIndexPath.row)
        let to = ZHIndexPath(section: destinationIndexPath.section, row: destinationIndexPath.row)
        collectionViewDidEndMovingClosure?(at,to)
        
    }
    
}


public extension UICollectionView
{
    class func collectionView(collectionView: UICollectionView, indexPath:IndexPath, spaceName:String,cellClassName:String) -> UICollectionViewCell
    {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellClassName)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellClassName, for: indexPath)
        let clazz : AnyClass = NSClassFromString(spaceName + "." + cellClassName)!
        let clazzType = clazz as? ZHBaseCell.Type
        var contentView = cell.contentView.viewWithTag(ZHCollectionViewIMP.Tag.cell)
        
        if contentView == nil
        {
            contentView = clazzType?.init()
            contentView?.tag = ZHCollectionViewIMP.Tag.cell
            cell.contentView.addSubview(contentView!)
            contentView?.snp.makeConstraints({ (make) in
                make.edges.equalTo(cell.contentView)
            })
        }
        
        return cell
    }
    
    
    class func collectionView(collectionView:UICollectionView,viewForSupplementaryElementOfKind kind:String,indexPath: IndexPath,spaceName:String,cellClassName:String) -> UICollectionReusableView
    {
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: cellClassName)
        
        let resuablView = collectionView.dequeueReusableSupplementaryView(ofKind: kind
            , withReuseIdentifier: cellClassName, for: indexPath)
        
        let clazz : AnyClass = NSClassFromString(spaceName + "." + cellClassName)!
        let clazzType = clazz as? ZHBaseCell.Type
        var contentView = resuablView.viewWithTag(ZHCollectionViewIMP.Tag.headerFooter)
        
        if contentView == nil
        {
           contentView = clazzType?.init()
           contentView?.tag = ZHCollectionViewIMP.Tag.headerFooter
           resuablView.addSubview(contentView!)
           contentView?.snp.makeConstraints({ (make) in
              make.edges.equalTo(resuablView)
           })
        }
        
        return resuablView
    }
    
}

