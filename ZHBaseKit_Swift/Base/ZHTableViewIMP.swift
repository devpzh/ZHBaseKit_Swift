//
//  ZHTableViewIMP.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/7/1.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

let kTableViewCellContentViewTag = 10000;
let kTableViewHeaderFooterContentViewTag = 10001;

typealias ZHTableViewDidScrollClosure = (UIScrollView)->();
typealias ZHTableViewDidEndDeceleratingClosure = (UIScrollView)->();
typealias ZHTableViewDidEndDraggingClosure = (UIScrollView,Bool)->();

class ZHTableViewIMP: NSObject,UITableViewDelegate,UITableViewDataSource{
    
    //MARK: Closure
    var tableViewDidScrollClosure: ZHTableViewDidScrollClosure?
    var tableViewDidEndDeceleratingClosure: ZHTableViewDidEndDeceleratingClosure?
    var tableViewDidEndDraggingClosure: ZHTableViewDidEndDraggingClosure?
    
    //MARK: SectionsArray
    lazy var sectionsArray: [ZHTableViewSection] =
        {
         return [ZHTableViewSection]();
    }()
    
    //MARK: UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        self.tableViewDidScrollClosure?(scrollView);
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.tableViewDidEndDeceleratingClosure?(scrollView);
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.tableViewDidEndDraggingClosure?(scrollView,decelerate);
    }
    
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let model = self.sectionsArray[indexPath.section].rowsArray[indexPath.row];
        return model.cellHeight;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        let headerModel = self.sectionsArray[section].headerModel;
        return (headerModel != nil) ? headerModel!.cellHeight:0.0;
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        let footerModel = self.sectionsArray[section].footerModel;
        return (footerModel != nil) ? footerModel!.cellHeight:0.0;
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerModel = self.sectionsArray[section].headerModel;
        if  headerModel == nil
        {
            return nil;
        }
        
        let header = UITableView.tableView(tableView: tableView, headerFooterClassName: headerModel!.cellClassName);
        
        guard let headerContentView = header.contentView.viewWithTag(kTableViewHeaderFooterContentViewTag) as? ZHBaseCell else
        { return nil }
        headerContentView.data = headerModel;
        headerContentView.reloadSectionsClosure = {[weak tableView] (animation) in
            let enable = (animation == nil || animation == UITableView.RowAnimation.none) ?false:true;
            UIView.setAnimationsEnabled(enable)
            tableView?.reloadSections(IndexSet.init(integer: section), with: (animation != nil) ? animation! : UITableView.RowAnimation.none);
            UIView.setAnimationsEnabled(true)
        }
        
        return header;
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerModel = self.sectionsArray[section].footerModel;
        if  footerModel == nil
        {
            return nil;
        }
        let footer = UITableView.tableView(tableView: tableView, headerFooterClassName: footerModel!.cellClassName);
        guard let footerContentView = footer.contentView.viewWithTag(kTableViewHeaderFooterContentViewTag) as? ZHBaseCell else
        { return nil }
        footerContentView.data = footerModel;
        footerContentView.reloadSectionsClosure = {[weak tableView] (animation)in
            
            let enable = (animation == nil || animation == UITableView.RowAnimation.none) ?false:true;
            UIView.setAnimationsEnabled(enable)
            tableView?.reloadSections(IndexSet.init(integer: section), with:(animation != nil) ? animation! : UITableView.RowAnimation.none);
            UIView.setAnimationsEnabled(true)
        }
        
        return footer;
    }
    
    //MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return self.sectionsArray.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.sectionsArray[section].rowsArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let model = self.sectionsArray[indexPath.section].rowsArray[indexPath.row];
        let cell  = UITableView.tableView(tableView: tableView, indexPath: indexPath, cellClassName: model.cellClassName);
        let contentView:ZHBaseCell = cell.contentView.viewWithTag(kTableViewCellContentViewTag) as! ZHBaseCell;
        contentView.data = model;
        contentView.reloadRowsClosure = { [weak tableView] (animation) in

            let enable = (animation == nil || animation == UITableView.RowAnimation.none) ?false:true;
            UIView.setAnimationsEnabled(enable)
            tableView?.reloadRows(at: [indexPath], with:(animation != nil) ? animation! : UITableView.RowAnimation.none);
            UIView.setAnimationsEnabled(true)
        };
        contentView.reloadSectionsClosure = {[weak tableView] (animation) in
            
            let enable = (animation == nil || animation == UITableView.RowAnimation.none) ?false:true;
            UIView.setAnimationsEnabled(enable)
            tableView?.reloadSections(IndexSet.init(integer: indexPath.section), with: (animation != nil) ? animation! : UITableView.RowAnimation.none);
            UIView.setAnimationsEnabled(true)
        }
        return cell;
    }

}

extension UITableView
{
    
   class func tableView(tableView:UITableView, indexPath:IndexPath, cellClassName:String) -> UITableViewCell
    {
        let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"];
        let clazz : AnyClass = NSClassFromString((nameSpace as! String) + "." + cellClassName)!
        let clazzType = clazz as? ZHBaseCell.Type;
        var cell = tableView.dequeueReusableCell(withIdentifier: cellClassName);
        if cell == nil
        {
            cell = UITableViewCell.init(style: .value1, reuseIdentifier: cellClassName);
            cell?.selectionStyle = .none;
            cell?.contentView.backgroundColor = UIColor.clear;
            let contentView = clazzType?.init();
            contentView?.tag = kTableViewCellContentViewTag;
            cell?.contentView.addSubview(contentView!);
            contentView?.snp.makeConstraints({ (make) in
                make.edges.equalTo(cell!.contentView);
            });
    
         }
    
        return cell!;
    }
    
    
  class func tableView(tableView:UITableView, headerFooterClassName:String) -> UITableViewHeaderFooterView
    {
        let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"];
        let clazz : AnyClass = NSClassFromString((nameSpace as! String) + "." + headerFooterClassName)!
        let clazzType = clazz as? ZHBaseCell.Type;
        var headerFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerFooterClassName);
        if headerFooterView == nil
        {
            headerFooterView = UITableViewHeaderFooterView.init(reuseIdentifier:headerFooterClassName);
            headerFooterView?.backgroundView = {
            let view = UIView.init(frame: headerFooterView!.bounds);
            view.backgroundColor = UIColor.clear;
            return view;
            }();
            
            let contentView = clazzType?.init();
            contentView?.tag = kTableViewHeaderFooterContentViewTag;
            headerFooterView?.contentView.addSubview(contentView!);
            contentView?.snp.makeConstraints({ (make) in
                make.edges.equalTo(headerFooterView!.contentView);
            });
            
        }
        return headerFooterView!;
    }
   
}
