//
//  ZHNavigationBoard.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/6/29.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

class ZHNavigationBoard: UINavigationController,UIGestureRecognizerDelegate {

    var isStatusBarHidden = false;
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer?.delegate = self;
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.viewControllers.count <= 1 {
            return false;
        }
        return true;
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true;
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return gestureRecognizer.isKind(of: UIScreenEdgePanGestureRecognizer.self);
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
     
        if (self.children.count > 0)
        {
            // 隐藏tabbar
            viewController.hidesBottomBarWhenPushed = true;
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    
    class func addChildControllers(_ viewController:UIViewController)->ZHNavigationBoard {
        
        let navi = ZHNavigationBoard.init(rootViewController: viewController)
        return navi;
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return self.isStatusBarHidden;
    }
}


