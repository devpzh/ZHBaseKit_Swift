//
//  ZHBaseBoard.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/6/24.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit
import SnapKit

public enum ZHStatusBarStyle {
    case system
    case lightContent
    case darkContent
}

open class ZHBaseBoard: UIViewController {

    //MARK: Properties
    public lazy var naviBar: UIView = {
        let naviBar = UIView.init();
        naviBar.backgroundColor = ZHBaseKit.shared.naviBarBackgroundColor;
        return naviBar;
    }()
    
    public lazy var naviBarContainer: UIView = {
        let naviBarContainer = UIView.init();
        return naviBarContainer;
    }()
    
    public lazy var naviBarSeparator: UIView = {
        let barSeparator = UIView.init();
        barSeparator.backgroundColor = ZHBaseKit.shared.naviBarSeparatorColor;
        return barSeparator;
    }()
    
    public lazy var leftItemBtn: UIButton = {
        let leftItemBtn = UIButton.init();
        leftItemBtn.addTarget(self, action:#selector(onLeftTouch), for: UIControl.Event.touchUpInside)
        return leftItemBtn
    }()
    
    public lazy var rightItemBtn: UIButton = {
        let rightItemBtn = UIButton.init();
        rightItemBtn.addTarget(self, action:#selector(onRightTouch), for: UIControl.Event.touchUpInside);
        return rightItemBtn
    }()
    
    public var titleItem  = UIView.init();
    public var leftItem   = UIView.init();
    public var rightItem  = UIView.init();
    
    public var isStatusBarHidden = false {
        
        didSet {
            
            guard let navi = self.navigationController as? ZHNavigationBoard else { return }
            navi.isStatusBarHidden = isStatusBarHidden;
            self.setNeedsStatusBarAppearanceUpdate();
            
        }
    };
    
    public var isHomeIndicatorAutoHidden = false {
        
        didSet {
            if #available(iOS 11.0, *) {
                self.setNeedsUpdateOfHomeIndicatorAutoHidden()
            } else {
            };
        }
    }
    
    //MARK: 是否是模态跳转
    public var isModalPresentation:Bool {
        
        if self.presentingViewController != nil {
            return true
        }
        
        return false
    }
    
    //MARK: 是否铺满屏幕
    public var isFullScreen:Bool {
        
        if isModalPresentation == false {
            return true
        }
        
        if let navi = self.navigationController {
            
            if navi.modalPresentationStyle == .pageSheet
                || navi.modalPresentationStyle == .formSheet
                || navi.modalPresentationStyle == .popover {
                return false
            }
            return true
        }
        
        if modalPresentationStyle == .pageSheet
            || modalPresentationStyle == .formSheet
            || modalPresentationStyle == .popover {
            return false
        }
        return true
    }
    
    public var statusBarStyle:ZHStatusBarStyle = ZHBaseKit.shared.statusBarStyle;

    //MARK: Func
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.onViewWillAppear();
        
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        self.onViewDidAppear();
        
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        self.onViewWillDisappear();
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated);
        self.onViewDidDisappear();
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.onLoad();
        self.resetStatusBarStyle();
        self.onViewCreate();
        self.onViewLayout();
    }
    
    open func onViewWillAppear()
    {}
    
    open func onViewDidAppear()
    {
        self.resetStatusBarStyle();
    }
    
    open func onViewWillDisappear()
    {}
    
    open func onViewDidDisappear()
    {}
    
    open func onLoad()
    {}
    
    open func onViewCreate()
    {
        self.navigationController?.navigationBar.isHidden = true;  //< 隐藏系统导航栏
        self.view.backgroundColor = ZHBaseKit.shared.backgroundColor;
        self.onNavigatonBarCreate();
        self.onBarContainerCreate();
        self.onBarSeparatorCreate();
        self.onBarTitleViewCreate();
        self.onBarLeftItemCreate();
        self.onBarRightItemCreate();
    }
    
    open func onViewLayout()
    {}
    
    @objc open func onLeftTouch()
    {
        if self.navigationController == nil
        {
            return;
        }
       self.navigationController?.popViewController(animated: true);

    }

    @objc open func onRightTouch()
    {}
    
    
    open func resetStatusBarStyle() {
        
        switch statusBarStyle {
        case .system:
            UIApplication.shared.setStatusBarStyle(.default, animated: false);
        case .lightContent:
            UIApplication.shared.setStatusBarStyle(.lightContent, animated: false);
        case .darkContent:
            if #available(iOS 13.0, *) {
                UIApplication.shared.setStatusBarStyle(.darkContent, animated: false)
            } else {
                UIApplication.shared.setStatusBarStyle(.default, animated: false);
            };
        }
     }
    
    open override var prefersHomeIndicatorAutoHidden: Bool {
        return self.isHomeIndicatorAutoHidden;
    }
    
    //MARK: 自定义导航栏
    open func onNavigatonBarCreate()
    {
        
        let height = isFullScreen ? kNavigationBarHeight:kNavigationBarHeight - kTopSafeHeight
        self.view.addSubview(self.naviBar);
        self.naviBar.snp.makeConstraints {(make) in
            make.top.leading.trailing.equalTo(self.view);
            make.height.equalTo(height);
        };
    }
    
    //MARK: 导航栏容器
    open func onBarContainerCreate()
    {
        let offsety = isFullScreen ? kStatusBarHeight:0
        self.naviBar.addSubview(self.naviBarContainer);
        self.naviBarContainer.snp.makeConstraints { (make) in
            make.top.equalTo(self.naviBar).offset(offsety);
            make.leading.bottom.trailing.equalTo(self.naviBar);
        };
    }
    
    //MARK: 分割线
    open func onBarSeparatorCreate()
    {
        self.naviBarContainer.addSubview(self.naviBarSeparator);
        self.naviBarSeparator.snp.makeConstraints { (make) in
            make.height.equalTo(0.5);
            make.leading.bottom.trailing.equalTo(self.naviBarContainer);
        };
    }
    
    //MARK: TitleView
    open func onBarTitleViewCreate()
    {
    }
    
    //MARK: LeftItem
    open func onBarLeftItemCreate()
    {
        if !ZHBaseKit.shared.backIcon.isEmpty
        {
            self.onShowLeftItemWithImage(kImageName(ZHBaseKit.shared.backIcon));
        }
    }
    
    //MARK: RightItem
    open func onBarRightItemCreate()
    {}
    
    //MARK: hidden naviBar
    open func onHiddenNavigationBar()
    {
        self.naviBar.isHidden = true;
    }
    
    //MARK: show naviBar
    open func onShowNavigationBar()
    {
        self.naviBar.isHidden = false;
    }
    
    //MARK: hidden naviBarSeparator
    open func onHiddenBarSeparator()
    {
        self.naviBarSeparator.isHidden = true;
    }
    
    //MARK: show naviBarSeparator
    open func onShowBarSeparator()
    {
        self.naviBarSeparator.isHidden = false;
    }
    
    //MARK: 标题栏-->文字
    open func onShowNavigationTitle(_ title:String)
    {
        self.titleItem.removeFromSuperview();
        let label = UILabel.init();
        label.text = title;
        label.textColor = ZHBaseKit.shared.naviBarTitleColor;
        label.font = ZHBaseKit.shared.titleFont;
        label.textAlignment = NSTextAlignment.center;
        self.naviBarContainer.addSubview(label);
        label.snp.makeConstraints { (make) in
            make.center.equalTo(self.naviBarContainer);
            make.width.lessThanOrEqualToSuperview().multipliedBy(0.75);
        };
        self.titleItem = label;

    }
    
    //MARK: 标题栏-->图片
    open func onShowNavigationTitleWithImage(_ image:UIImage)
    {
        self.titleItem.removeFromSuperview();
        let imageView = UIImageView.init(image: image);
        imageView.contentMode = UIView.ContentMode.center;
        self.naviBarContainer.addSubview(imageView);
        imageView.snp.makeConstraints { (make) in
            make.center.equalTo(self.naviBarContainer);
            make.size.equalTo(image.size);
        };
        self.titleItem = imageView;
        
    }
    
    //MARK: 标题栏-->自定义视图
    open func onShowNavigationTitleWithCustomView(_ customView:UIView)
    {
        self.titleItem.removeFromSuperview();
        self.naviBarContainer.addSubview(customView);
        customView.snp.makeConstraints { (make) in
            make.center.equalTo(self.naviBarContainer);
            make.top.equalToSuperview()
            make.bottom.equalTo(-1)
            make.width.equalTo(kScreenWidth - 120)
        };
        self.titleItem = customView;
        
    }
    
    //MARK: leftItem-->文字
    open func onShowLeftItemWithTitle(_ title:String)
    {
        self.leftItem.removeFromSuperview();
        let label = UILabel.init();
        label.text = title;
        label.textColor = ZHBaseKit.shared.leftItemTitleColor;
        label.font = ZHBaseKit.shared.leftItemTitleFont;
        label.textAlignment = NSTextAlignment.left;
        self.naviBarContainer.addSubview(label);
        label.snp.makeConstraints { (make) in
            make.leading.equalTo(self.naviBarContainer).offset(ZHBaseKit.shared.leftItemMarginLeft);
            make.centerY.equalTo(self.naviBarContainer);
        };
        self.leftItem = label;
        self.addLeftItemButton();
    }
    
    //MARK: leftItem-->图片
    open func onShowLeftItemWithImage(_ image:UIImage)
    {
        self.leftItem.removeFromSuperview();
        let imageView = UIImageView.init();
        imageView.image = image;
        imageView.contentMode = UIView.ContentMode.center;
        self.naviBarContainer.addSubview(imageView);
        imageView.snp.makeConstraints { (make) in
            make.leading.equalTo(self.naviBarContainer).offset(ZHBaseKit.shared.leftItemMarginLeft);
            make.centerY.equalTo(self.naviBarContainer);
            make.size.equalTo(image.size);
        }
        
        self.leftItem = imageView;
        self.addLeftItemButton();
        
    }
    
    
    //MARK: leftItem-->自定义视图
    open func onShowLeftItemWithCustomView(_ customView:UIView)
    {
        self.leftItem.removeFromSuperview();
        self.naviBarContainer.addSubview(customView);
        customView.snp.makeConstraints { (make) in
            make.leading.equalTo(self.naviBarContainer).offset(ZHBaseKit.shared.leftItemMarginLeft);
            make.centerY.equalTo(self.naviBarContainer);
        };
        
        self.leftItem = customView;
        self.addLeftItemButton();
        
    }
    
    
    //MARK: rightItem-->文字
    open func onShowRightItemWithTitle(_ title:String)
    {
        self.rightItem.removeFromSuperview();
        let label = UILabel.init();
        label.text = title;
        label.textColor = ZHBaseKit.shared.rightItemTitleColor;
        label.font = ZHBaseKit.shared.rightItemTitleFont;
        label.textAlignment = NSTextAlignment.right;
        self.naviBarContainer.addSubview(label);
        label.snp.makeConstraints { (make) in
            make.trailing.equalTo(self.naviBarContainer).offset(-ZHBaseKit.shared.rightItemMarginRight);
            make.centerY.equalTo(self.naviBarContainer);
        };
        self.rightItem = label;
        self.addRightItemButton();
    }
    
    
    //MARK: rightItem-->图片
    open func onShowRightItemWithImage(_ image:UIImage)
    {
        self.rightItem.removeFromSuperview();
        let imageView = UIImageView.init();
        imageView.image = image;
        imageView.contentMode = UIView.ContentMode.center;
        self.naviBarContainer.addSubview(imageView);
        imageView.snp.makeConstraints { (make) in
            make.trailing.equalTo(self.naviBarContainer).offset(-ZHBaseKit.shared.rightItemMarginRight);
            make.centerY.equalTo(self.naviBarContainer);
            make.size.equalTo(image.size);
        }
        
        self.rightItem = imageView;
        self.addRightItemButton();
        
    }
    
    //MARK: rightItem-->自定义视图
    open func onShowRightItemWithCustomView(_ customView:UIView)
    {
        self.rightItem.removeFromSuperview();
        self.naviBarContainer.addSubview(customView);
        customView.snp.makeConstraints { (make) in
            make.trailing.equalTo(self.naviBarContainer).offset(-ZHBaseKit.shared.rightItemMarginRight);
            make.centerY.equalTo(self.naviBarContainer);
            make.size.equalTo(customView.bounds.size)
        };
        
        self.rightItem = customView;
        self.addRightItemButton();
        
    }
    
    //MARK: leftItemButton
    open func addLeftItemButton()
    {
        self.naviBarContainer.addSubview(self.leftItemBtn);
        self.leftItemBtn.snp.makeConstraints { (make) in
            make.top.leading.bottom.equalTo(self.naviBarContainer);
            make.trailing.equalTo(self.leftItem.snp.trailing).offset(kMargin);
        }
    }
    
    //MARK: rightItemButton
    open func addRightItemButton()
    {
        self.naviBarContainer.addSubview(self.rightItemBtn);
        self.rightItemBtn.snp.makeConstraints { (make) in
            make.top.trailing.bottom.equalTo(self.naviBarContainer);
            make.leading.equalTo(self.rightItem.snp.leading).offset(-kMargin);
        }
    }
    
}

