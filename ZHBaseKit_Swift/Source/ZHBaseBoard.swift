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
        let naviBar = UIView()
        naviBar.backgroundColor = ZHBaseKit.shared.naviBarBackgroundColor
        return naviBar
    }()

    public lazy var naviBarContainer: UIView = {
        return UIView()
    }()

    public lazy var naviBarSeparator: UIView = {
        let barSeparator = UIView()
        barSeparator.backgroundColor = ZHBaseKit.shared.naviBarSeparatorColor
        return barSeparator
    }()

    public lazy var leftItemBtn: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(onLeftTouch), for: .touchUpInside)
        return btn
    }()

    public lazy var rightItemBtn: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(onRightTouch), for: .touchUpInside)
        return btn
    }()

    public var titleItem  = UIView()
    public var leftItem   = UIView()
    public var rightItem  = UIView()

    public var hiddenStatusBar = false {
        didSet {
            guard let navi = navigationController as? ZHNavigationBoard else { return }
            navi.hiddenStatusBar = hiddenStatusBar
            setNeedsStatusBarAppearanceUpdate()
        }
    }

    public var isHomeIndicatorAutoHidden = false {
        didSet {
            if #available(iOS 11.0, *) {
                setNeedsUpdateOfHomeIndicatorAutoHidden()
            }
        }
    }

    //MARK: 是否是模态跳转
    public var isModalPresentation: Bool {
        return presentingViewController != nil
    }

    //MARK: 是否铺满屏幕
    public var isFullScreen: Bool {

        if isModalPresentation == false {
            return true
        }

        if let navi = navigationController {
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

    public var statusBarStyle: ZHStatusBarStyle = ZHBaseKit.shared.statusBarStyle

    //MARK: Func
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        onViewWillAppear()
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        onViewDidAppear()
    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        onViewWillDisappear()
    }

    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        onViewDidDisappear()
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        onLoad()
        resetStatusBarStyle()
        onViewCreate()
        onViewLayout()
    }

    open func onViewWillAppear(){}

    open func onViewDidAppear(){
        resetStatusBarStyle()
    }

    open func onViewWillDisappear(){}

    open func onViewDidDisappear(){}

    open func onLoad(){}

    open func onViewCreate()
    {
        view.backgroundColor = ZHBaseKit.shared.backgroundColor
        
        if ZHBaseKit.shared.useSystemNaviBar {
            navigationController?.navigationBar.isHidden = false
            extendedLayoutIncludesOpaqueBars = true
        } else {
            navigationController?.navigationBar.isHidden = true
            onNavigatonBarCreate()
            onBarContainerCreate()
            onBarSeparatorCreate()
        }
        onBarTitleViewCreate()
        onBarLeftItemCreate()
        onBarRightItemCreate()
    }

    open func onViewLayout(){}

    @objc open func onLeftTouch()
    {
        navigationController?.popViewController(animated: true)
    }

    @objc open func onRightTouch(){}

    open func resetStatusBarStyle()
    {
        switch statusBarStyle {
        case .system:
            UIApplication.shared.setStatusBarStyle(.default, animated: false)
        case .lightContent:
            UIApplication.shared.setStatusBarStyle(.lightContent, animated: false)
        case .darkContent:
            if #available(iOS 13.0, *) {
                UIApplication.shared.setStatusBarStyle(.darkContent, animated: false)
            } else {
                UIApplication.shared.setStatusBarStyle(.default, animated: false)
            }
        }
    }

    open override var prefersHomeIndicatorAutoHidden: Bool
    {
        return isHomeIndicatorAutoHidden
    }

    //MARK: 导航栏底部约束锚点
    //系统模式:tableView或collectionView从view.top开始延伸到导航栏下方，UIKit才能感知scrollEdgeAppearance触发时机
    //自定义模式: 从naviBar底部开始
    public var naviBarBottom: ConstraintItem
    {
        return ZHBaseKit.shared.useSystemNaviBar ? view.snp.top : naviBar.snp.bottom
    }

    //MARK: 自定义导航栏
    open func onNavigatonBarCreate()
    {
        let height = isFullScreen ? kNavigationBarHeight : kNavigationBarHeight - kTopSafeHeight
        view.addSubview(naviBar)
        naviBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(height)
        }
    }

    //MARK: 导航栏容器
    open func onBarContainerCreate()
    {
        let offsety = isFullScreen ? kStatusBarHeight : 0
        naviBar.addSubview(naviBarContainer)
        naviBarContainer.snp.makeConstraints { make in
            make.top.equalTo(naviBar).offset(offsety)
            make.leading.bottom.trailing.equalTo(naviBar)
        }
    }

    //MARK: 分割线
    open func onBarSeparatorCreate()
    {
        naviBarContainer.addSubview(naviBarSeparator)
        naviBarSeparator.snp.makeConstraints { make in
            make.height.equalTo(0.5)
            make.leading.bottom.trailing.equalTo(naviBarContainer)
        }
    }

    //MARK: TitleView
    open func onBarTitleViewCreate(){}

    //MARK: LeftItem
    open func onBarLeftItemCreate()
    {
        if ZHBaseKit.shared.useSystemNaviBar { return }
        if !ZHBaseKit.shared.backIcon.isEmpty {
            onShowLeftItemWithImage(kImageName(ZHBaseKit.shared.backIcon))
        }
    }

    //MARK: RightItem
    open func onBarRightItemCreate(){}

    //MARK: hidden naviBar
    open func onHiddenNavigationBar()
    {
        if ZHBaseKit.shared.useSystemNaviBar {
            navigationController?.navigationBar.isHidden = true
        } else {
            naviBar.isHidden = true
        }
    }

    //MARK: show naviBar
    open func onShowNavigationBar()
    {
        if ZHBaseKit.shared.useSystemNaviBar {
            navigationController?.navigationBar.isHidden = false
        } else {
            naviBar.isHidden = false
        }
    }

    //MARK: hidden naviBarSeparator
    open func onHiddenBarSeparator()
    {
        naviBarSeparator.isHidden = true
    }

    //MARK: show naviBarSeparator
    open func onShowBarSeparator()
    {
        naviBarSeparator.isHidden = false
    }

    //MARK: 标题栏-->文字
    open func onShowNavigationTitle(_ title: String)
    {
        if ZHBaseKit.shared.useSystemNaviBar {
            navigationItem.title = title
            return
        }
        titleItem.removeFromSuperview()
        let label = UILabel()
        label.text = title
        label.textColor = ZHBaseKit.shared.naviBarTitleColor
        label.font = ZHBaseKit.shared.titleFont
        label.textAlignment = .center
        naviBarContainer.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalTo(naviBarContainer)
            make.width.lessThanOrEqualToSuperview().multipliedBy(0.75)
        }
        titleItem = label
    }

    //MARK: 标题栏-->图片
    open func onShowNavigationTitleWithImage(_ image: UIImage)
    {
        if ZHBaseKit.shared.useSystemNaviBar {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .center
            navigationItem.titleView = imageView
            return
        }
        titleItem.removeFromSuperview()
        let imageView = UIImageView(image: image)
        imageView.contentMode = .center
        naviBarContainer.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.center.equalTo(naviBarContainer)
            make.size.equalTo(image.size)
        }
        titleItem = imageView
    }

    //MARK: 标题栏-->自定义视图
    open func onShowNavigationTitleWithCustomView(_ customView: UIView)
    {
        if ZHBaseKit.shared.useSystemNaviBar {
            navigationItem.titleView = customView
            return
        }
        titleItem.removeFromSuperview()
        naviBarContainer.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.center.equalTo(naviBarContainer)
            make.top.equalToSuperview()
            make.bottom.equalTo(-1)
            make.width.equalTo(kScreenWidth - 120)
        }
        titleItem = customView
    }

    //MARK: leftItem-->文字
    open func onShowLeftItemWithTitle(_ title: String)
    {
        if ZHBaseKit.shared.useSystemNaviBar {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(onLeftTouch))
            return
        }
        leftItem.removeFromSuperview()
        let label = UILabel()
        label.text = title
        label.textColor = ZHBaseKit.shared.leftItemTitleColor
        label.font = ZHBaseKit.shared.leftItemTitleFont
        label.textAlignment = .left
        naviBarContainer.addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.equalTo(naviBarContainer).offset(ZHBaseKit.shared.leftItemMarginLeft)
            make.centerY.equalTo(naviBarContainer)
        }
        leftItem = label
        addLeftItemButton()
    }

    //MARK: leftItem-->图片
    open func onShowLeftItemWithImage(_ image: UIImage)
    {
        if ZHBaseKit.shared.useSystemNaviBar {
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(onLeftTouch))
            return
        }
        leftItem.removeFromSuperview()
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .center
        naviBarContainer.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.leading.equalTo(naviBarContainer).offset(ZHBaseKit.shared.leftItemMarginLeft)
            make.centerY.equalTo(naviBarContainer)
            make.size.equalTo(image.size)
        }
        leftItem = imageView
        addLeftItemButton()
    }

    //MARK: leftItem-->自定义视图
    open func onShowLeftItemWithCustomView(_ customView: UIView)
    {
        if ZHBaseKit.shared.useSystemNaviBar {
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: customView)
            return
        }
        leftItem.removeFromSuperview()
        naviBarContainer.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.leading.equalTo(naviBarContainer).offset(ZHBaseKit.shared.leftItemMarginLeft)
            make.centerY.equalTo(naviBarContainer)
        }
        leftItem = customView
        addLeftItemButton()
    }

    //MARK: rightItem-->文字
    open func onShowRightItemWithTitle(_ title: String)
    {
        if ZHBaseKit.shared.useSystemNaviBar {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(onRightTouch))
            return
        }
        rightItem.removeFromSuperview()
        let label = UILabel()
        label.text = title
        label.textColor = ZHBaseKit.shared.rightItemTitleColor
        label.font = ZHBaseKit.shared.rightItemTitleFont
        label.textAlignment = .right
        naviBarContainer.addSubview(label)
        label.snp.makeConstraints { make in
            make.trailing.equalTo(naviBarContainer).offset(-ZHBaseKit.shared.rightItemMarginRight)
            make.centerY.equalTo(naviBarContainer)
        }
        rightItem = label
        addRightItemButton()
    }

    //MARK: rightItem-->图片
    open func onShowRightItemWithImage(_ image: UIImage)
    {
        if ZHBaseKit.shared.useSystemNaviBar {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(onRightTouch))
            return
        }
        rightItem.removeFromSuperview()
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .center
        naviBarContainer.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.trailing.equalTo(naviBarContainer).offset(-ZHBaseKit.shared.rightItemMarginRight)
            make.centerY.equalTo(naviBarContainer)
            make.size.equalTo(image.size)
        }
        rightItem = imageView
        addRightItemButton()
    }

    //MARK: rightItem-->自定义视图
    open func onShowRightItemWithCustomView(_ customView: UIView)
    {
        if ZHBaseKit.shared.useSystemNaviBar {
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: customView)
            return
        }
        rightItem.removeFromSuperview()
        naviBarContainer.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.trailing.equalTo(naviBarContainer).offset(-ZHBaseKit.shared.rightItemMarginRight)
            make.centerY.equalTo(naviBarContainer)
            make.size.equalTo(customView.bounds.size)
        }
        rightItem = customView
        addRightItemButton()
    }

    //MARK: leftItemButton
    open func addLeftItemButton()
    {
        naviBarContainer.addSubview(leftItemBtn)
        leftItemBtn.snp.makeConstraints { make in
            make.top.leading.bottom.equalTo(naviBarContainer)
            make.trailing.equalTo(leftItem.snp.trailing).offset(kMargin)
        }
    }

    //MARK: rightItemButton
    open func addRightItemButton()
    {
        naviBarContainer.addSubview(rightItemBtn)
        rightItemBtn.snp.makeConstraints { make in
            make.top.trailing.bottom.equalTo(naviBarContainer)
            make.leading.equalTo(rightItem.snp.leading).offset(-kMargin)
        }
    }

}
