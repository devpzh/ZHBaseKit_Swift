//
//  ZHBaseCell.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/4/10.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

public typealias ZHTableViewCellReloadRowsClosure     = (_ animation:UITableView.RowAnimation?)->();
public typealias ZHTableViewCellReloadSectionsClosure = (_ animation:UITableView.RowAnimation?)->();

open class ZHBaseCell: UIView {
  
    //MARK: Properties
    public var reloadRowsClosure : ZHTableViewCellReloadRowsClosure?
    public var reloadSectionsClosure : ZHTableViewCellReloadSectionsClosure?

    public var enabled:Bool = true
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

    public weak var delegate: AnyObject?;
    public var data:ZHBaseCellModel?
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
    open func onLoad()
    {
        self.enabled = true;
     
    }
    
    open func dataDidChange()
    {
       
    }
    
    open func addGesture()
    {
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(onTouch))
        self.addGestureRecognizer(gesture);
    }
    
    open func removeGesture()
    {
        self.gestureRecognizers?.removeAll();
    }
        
    @objc open func onTouch()
    {
        
    }
    
    open override func layoutSubviews(){
        
        if self.frame.size.width > 0 || self.frame.size.height > 0
        {
            self.layoutDidFinish()
        }
    }
    
    open func layoutDidFinish() {
        
    }
    
    //MARK: Init
    public override init(frame: CGRect) {
        super.init(frame: frame);
        self.onLoad();
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    
}
