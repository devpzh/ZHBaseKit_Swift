//
//  ZHBaseCell.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/4/10.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

typealias ZHTableViewCellReloadRowsClosure     = (_ animation:UITableView.RowAnimation?)->();
typealias ZHTableViewCellReloadSectionsClosure = (_ animation:UITableView.RowAnimation?)->();

class ZHBaseCell: UIView {
  
    //MARK: Properties
    var reloadRowsClosure : ZHTableViewCellReloadRowsClosure?
    var reloadSectionsClosure : ZHTableViewCellReloadSectionsClosure?

    
    var enabled:Bool = true
    {
       didSet
        {
            if enabled == true
            {
                self.addGesture()
            }else
            {
                self.removeGesture();
            }
            
        }
        
    }

    weak var delegate: AnyObject?;
    var data:ZHBaseCellModel? 
    {
        didSet
        {
            if data?.delegate != nil
            {
                self.delegate = data?.delegate;
            }
            
            self.dataDidChange();
        }
        
        
    }

    //MARK: Func
    func onLoad()
    {
        self.enabled = true;
     
    }
    
    func dataDidChange()
    {
       
    }
    
   private func addGesture()
    {
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(onTouch))
        self.addGestureRecognizer(gesture);
    }
    
    func removeGesture()
    {
        self.gestureRecognizers?.removeAll();
    }
        
    @objc func onTouch()
    {
        
    }
    
    override func layoutSubviews(){
        
        if self.frame.size.width > 0 || self.frame.size.height > 0
        {
            self.layoutDidFinish()
        }
    }
    
    func layoutDidFinish() {
        
    }
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.onLoad();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    
}
