//
//  ZHTableViewIMP.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/7/1.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

public typealias ZHTableViewDidScrollClosure = (UIScrollView)->()
public typealias ZHTableViewDidEndDeceleratingClosure = (UIScrollView)->()
public typealias ZHTableViewDidEndDraggingClosure = (UIScrollView,Bool)->()

open class ZHTableViewIMP: NSObject,UITableViewDelegate,UITableViewDataSource{
    
    public struct Tag {
      public static let cell         = 10000
      public static let headerFooter = 10001
    }
    
    //MARK: Closure
    public var tableViewDidScrollClosure: ZHTableViewDidScrollClosure?
    public var tableViewDidEndDeceleratingClosure: ZHTableViewDidEndDeceleratingClosure?
    public var tableViewDidEndDraggingClosure: ZHTableViewDidEndDraggingClosure?
    
    //MARK: sections
    public lazy var sections: [ZHTableViewSection] =
        {
         return [ZHTableViewSection]()
    }()
    
    //MARK: UIScrollViewDelegate
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        self.tableViewDidScrollClosure?(scrollView)
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.tableViewDidEndDeceleratingClosure?(scrollView)
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.tableViewDidEndDraggingClosure?(scrollView,decelerate)
    }
    
    //MARK: UITableViewDelegate
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let model = self.sections[indexPath.section].rows[indexPath.row]
        return model.cellHeight ?? UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        guard let header = self.sections[section].header else { return 0.0 }
        return header.cellHeight ?? UITableView.automaticDimension
        
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        guard let footer = self.sections[section].footer else { return 0.0 }
        return footer.cellHeight ?? UITableView.automaticDimension
    }
    
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let headerModel = self.sections[section].header else { return nil}
        let header = UITableView.tableView(tableView: tableView,spaceName:headerModel.spaceName ?? "",headerFooterClassName:headerModel.cellClassName)
        guard let headerContentView = header.contentView.viewWithTag(Tag.headerFooter) as? ZHBaseCell else
        { return nil }
        
        headerContentView.data = headerModel
        headerContentView.reloadSectionsClosure = {[weak tableView] (animation) in
            let enable = (animation == nil || animation == UITableView.RowAnimation.none) ?false:true
            UIView.setAnimationsEnabled(enable)
            tableView?.reloadSections(IndexSet.init(integer: section), with: (animation != nil) ? animation! : UITableView.RowAnimation.none)
            UIView.setAnimationsEnabled(true)
        }
        
        return header
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        guard let footerModel = self.sections[section].footer else { return nil }
        
        let footer = UITableView.tableView(tableView: tableView,spaceName:footerModel.spaceName ?? "", headerFooterClassName:footerModel.cellClassName)
        guard let footerContentView = footer.contentView.viewWithTag(Tag.headerFooter) as? ZHBaseCell else
        { return nil }
        
        footerContentView.data = footerModel
        footerContentView.reloadSectionsClosure = {[weak tableView] (animation)in
            
            let enable = (animation == nil || animation == UITableView.RowAnimation.none) ?false:true
            UIView.setAnimationsEnabled(enable)
            tableView?.reloadSections(IndexSet.init(integer: section), with:(animation != nil) ? animation! : UITableView.RowAnimation.none)
            UIView.setAnimationsEnabled(true)
        }
        
        return footer
    }
    
    //MARK: UITableViewDataSource
    public func numberOfSections(in tableView: UITableView) -> Int
    {
        return self.sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.sections[section].rows.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let model = self.sections[indexPath.section].rows[indexPath.row]
        let cell  = UITableView.tableView(tableView: tableView, indexPath:indexPath,spaceName:model.spaceName ?? "" ,cellClassName:model.cellClassName)
        let contentView:ZHBaseCell = cell.contentView.viewWithTag(Tag.cell) as! ZHBaseCell
        contentView.data = model
        contentView.reloadRowsClosure = { [weak tableView] (animation) in

            let enable = (animation == nil || animation == UITableView.RowAnimation.none) ?false:true
            UIView.setAnimationsEnabled(enable)
            tableView?.reloadRows(at: [indexPath], with:(animation != nil) ? animation! : UITableView.RowAnimation.none)
            UIView.setAnimationsEnabled(true)
        }
        contentView.reloadSectionsClosure = {[weak tableView] (animation) in
            
            let enable = (animation == nil || animation == UITableView.RowAnimation.none) ?false:true
            UIView.setAnimationsEnabled(enable)
            tableView?.reloadSections(IndexSet.init(integer: indexPath.section), with: (animation != nil) ? animation! : UITableView.RowAnimation.none)
            UIView.setAnimationsEnabled(true)
        }
        return cell
    }

}

public extension UITableView
{
    
    class func tableView(tableView:UITableView, indexPath:IndexPath, spaceName:String, cellClassName:String) -> UITableViewCell
    {
        let clazz : AnyClass = NSClassFromString(spaceName + "." + cellClassName)!
        let clazzType = clazz as? ZHBaseCell.Type
        var cell = tableView.dequeueReusableCell(withIdentifier: cellClassName)
        if cell == nil
        {
            cell = UITableViewCell.init(style: .value1, reuseIdentifier: cellClassName)
            cell?.selectionStyle = .none
            cell?.backgroundColor = UIColor.clear
            let contentView = clazzType?.init()
            contentView?.tag = ZHTableViewIMP.Tag.cell
            cell?.contentView.addSubview(contentView!)
            contentView?.snp.makeConstraints({ (make) in
                make.edges.equalTo(cell!.contentView)
            })
         }
         return cell!
    }
    
    
    class func tableView(tableView:UITableView,spaceName:String,headerFooterClassName:String) -> UITableViewHeaderFooterView
    {
        
        let clazz : AnyClass = NSClassFromString(spaceName + "." + headerFooterClassName)!
        let clazzType = clazz as? ZHBaseCell.Type
        var headerFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerFooterClassName)
        if headerFooterView == nil
        {
            headerFooterView = UITableViewHeaderFooterView.init(reuseIdentifier:headerFooterClassName)
            headerFooterView?.backgroundView = {
            let view = UIView.init(frame: headerFooterView!.bounds)
            view.backgroundColor = UIColor.clear
            return view
            }()
            
            let contentView = clazzType?.init()
            contentView?.tag = ZHTableViewIMP.Tag.headerFooter
            headerFooterView?.contentView.addSubview(contentView!)
            contentView?.snp.makeConstraints({ (make) in
                make.edges.equalTo(headerFooterView!.contentView)
            })
            
        }
        return headerFooterView!
    }
   
}
