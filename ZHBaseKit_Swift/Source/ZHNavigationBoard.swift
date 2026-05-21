//
//  ZHNavigationBoard.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/6/29.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

open class ZHNavigationBoard: UINavigationController,UIGestureRecognizerDelegate {

    public var hiddenStatusBar = false
   
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
        if ZHBaseKit.shared.useSystemNaviBar {
            applySystemNaviBarAppearance()
        }
    }

    open func applySystemNaviBarAppearance() {
      
        let standard = UINavigationBarAppearance()
        standard.configureWithOpaqueBackground()
        standard.backgroundColor = ZHBaseKit.shared.naviBarBackgroundColor
        standard.titleTextAttributes = [
            .foregroundColor: ZHBaseKit.shared.naviBarTitleColor,
            .font: ZHBaseKit.shared.titleFont
        ]
        navigationBar.standardAppearance = standard
        navigationBar.compactAppearance  = standard

        let scrollEdge = UINavigationBarAppearance()
        scrollEdge.configureWithTransparentBackground()
        scrollEdge.titleTextAttributes = [.foregroundColor: UIColor.clear]
        navigationBar.scrollEdgeAppearance = scrollEdge
        
        if #available(iOS 15.0, *) {
            navigationBar.compactScrollEdgeAppearance = scrollEdge
        }
    }
    
    open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.viewControllers.count <= 1 {
            return false
        }
        return true
    }

    open func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    open func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return gestureRecognizer.isKind(of: UIScreenEdgePanGestureRecognizer.self)
    }
    
    open override func pushViewController(_ viewController: UIViewController, animated: Bool) {
     
        if (self.children.count > 0)
        {
            // 隐藏tabbar
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    
    open class func addChildControllers(_ viewController:UIViewController)->ZHNavigationBoard {
        
        let navi = ZHNavigationBoard.init(rootViewController: viewController)
        return navi
        
    }
    
    open override var prefersStatusBarHidden: Bool {
        return self.hiddenStatusBar
    }
}


