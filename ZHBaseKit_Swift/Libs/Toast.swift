//
//  Toast.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/12/10.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit
import Toast_Swift

class Toast: NSObject {
    
   class func presentTips(_ message:String) {
    
    guard let view = ZHRouter.topViewController()?.view else { return }
    self.presentTips(message, 1.5,view, .center)
   
   }
    
   class func presentTips(_ message:String, _ delay:TimeInterval) {
    
    guard let view = ZHRouter.topViewController()?.view else { return }
    self.presentTips(message, delay, view, .center)
    
   }
    
   class func presentTips(_ message:String, _ position: ToastPosition) {
      
     guard let view = ZHRouter.topViewController()?.view else { return }
     self.presentTips(message, 1.5, view, .center)
   
   }
    
   class func presentTips(_ message:String,  _ view:UIView) {
    
     self.presentTips(message, 1.5, view, .center)
 
   }
    
   class func presentTips(_ message:String, _ delay:TimeInterval, _ view:UIView, _ position: ToastPosition) {
        
        if message.count ==  0 {
            return;
        }
        ToastManager.shared.style.cornerRadius = 5;
        view.makeToast(message, duration: delay, position:position);
    }
    
    
    class func presentLoadingTips(_ message:String) {
        
        guard let view = ZHRouter.topViewController()?.view else { return }
        self.presentLoadingTips(message,view)
        
    }
    
    class func presentLoadingTips(_ message:String, _ view:UIView) {
        
        if message.count ==  0 {
            return;
        }
        view.makeToastActivity(.center)
        
    }
    
    class func dismiss() {
        
        guard let view = ZHRouter.topViewController()?.view else { return }
        self.dismiss(view);
        
    }
    
    class func dismiss(_ view:UIView) {
        
         view.hideToastActivity();
        
    }
    

}
