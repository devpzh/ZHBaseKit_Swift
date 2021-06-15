//
//  Router.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/12/7.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

typealias RouterCompleteClosure  = ()->();

let localScheme = "scheme"; ///< scheme

func RouterPath(_ path:String) -> String {
    return "\(localScheme)://\(path)";
}
class Router: NSObject
{
    
    class func routerURL(url:String)
    {
        self.routerURL(url: url, params: nil, present: false, animated: true ,completeClosure:nil)
    }
    
    class func routerURL(url:String, animated:Bool)
    {
        self.routerURL(url: url, params: nil, present: false, animated: animated ,completeClosure:nil)
    }
    
    class func routerURL(url:String, present:Bool)
    {
        self.routerURL(url: url, params: nil, present: present, animated: false ,completeClosure:nil)
    }
    
    class func routerURL(url:String, present:Bool, animated:Bool)
    {
        self.routerURL(url: url, params: nil, present: present, animated: animated ,completeClosure:nil)
    }
    
    class func routerURL(url:String, params:Dictionary<String, Any>)
    {
        self.routerURL(url: url, params: params, present: false, animated: true ,completeClosure:nil)
    }
    
    class func routerURL(url:String, params:Dictionary<String, Any>, animated:Bool)
    {
        self.routerURL(url: url, params: params, present: false, animated: animated ,completeClosure:nil)
    }
    
    class func routerURL(url:String, params:Dictionary<String, Any>, present:Bool)
    {
        self.routerURL(url: url, params: params, present: present, animated: true ,completeClosure:nil)
    }
    
    class func routerURL(url:String, params:Dictionary<String, Any>?, present:Bool, animated:Bool,completeClosure: RouterCompleteClosure?)
    {
        if url.count < RouterPath("").count
        {
            return;
        }
        
        let scheme = RouterScheme.init(url: url, params: params, present: present, animated: animated, completeClosure:completeClosure)
        
        if scheme.path?.count != 0
        {
            self.routerViewController(vcName: scheme.path!, params: params, present: present, animated: animated, completeClosure: completeClosure);
        }
        
    }
    
    class func routerViewController(vcName:String, params:Dictionary<String, Any>?, present:Bool, animated:Bool,completeClosure: RouterCompleteClosure?){
        
        let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"];
        let clazz : AnyClass = NSClassFromString((nameSpace as! String) + "." + vcName)!
        let clazzType = clazz as? UIViewController.Type;
        if clazzType == nil {
         return;
        }
        
        let vc = clazzType?.init();
        if  vc == nil {
            return;
        }
        
        if params != nil {
            vc?.routerParams = params;
        }
        
    
        let topVc = self.topViewController();
        if present {
            
            let nav = ZHNavigationBoard.addChildControllers(vc!);
            nav.modalPresentationStyle = .overFullScreen;
            topVc.present(nav, animated: animated, completion: completeClosure);
            return;
        }
        if topVc.navigationController != nil
        {
            topVc.navigationController?.pushViewController(vc!, animated: animated)
        }else
        {
            self.newNav(top:topVc).pushViewController(vc!, animated: animated);
        }
        
    }
    
}

extension Router
{
    
    class func appDelegate() -> UIApplication
    {
        return UIApplication.shared.delegate as! UIApplication;
    }
    
    
    class func topViewController() -> UIViewController{
        
        return self.topViewController(root: self.rootViewController());
    }
    
    class func topViewController(root:UIViewController) -> UIViewController{
        
        if root.isKind(of: UITabBarController.self) {
            
            let tabbar = root as! UITabBarController;
            return self.topViewController(root: tabbar.selectedViewController!)
            
        }else if root.isKind(of: UINavigationController.self)
        {
            let navi = root as! UINavigationController;
            return self.topViewController(root: navi.visibleViewController!)
            
        }else
        {
            return root;
        }
        
    }
    
    class func rootViewController() -> UIViewController{
        
        var root:UIViewController?
        var window = UIApplication.shared.keyWindow;
        if  window?.windowLevel != .normal {
            let windows = UIApplication.shared.windows;
            for tWindow in windows {
                if tWindow.windowLevel == .normal
                {
                    window = tWindow;
                    break;
                }
            }
        }
        
        let frontView = window?.subviews.first;
        let nextResponder = frontView?.next
        if nextResponder != nil && (nextResponder!.isKind(of: UIViewController.self))
        {
            root = nextResponder as? UIViewController;
        }else{
            root = window?.rootViewController;
        }
        
        return root!;
        
    }
    
    class func newNav(top:UIViewController) -> UINavigationController {
        
        var window = UIApplication.shared.keyWindow;
        if  window?.windowLevel != .normal {
            let windows = UIApplication.shared.windows;
            for tWindow in windows {
                if tWindow.windowLevel == .normal
                {
                    window = tWindow;
                    break;
                }
            }
        }
        
        let nav = ZHNavigationBoard.init(rootViewController:top);
        window?.rootViewController = nav;
        window?.makeKeyAndVisible();
        nav.pushViewController(top, animated: false);
        return nav;
        
    }
    
}

var kRouterParamsKey = "kRouterParamsKey";

extension UIViewController {
    
    var routerParams:Dictionary<String,Any>? {
        
        set {
            
            objc_setAssociatedObject(self, &kRouterParamsKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC);
            self.routerParamsDidChanged(newValue);
            
        }
    
        get{
            
            if let params = objc_getAssociatedObject(self, &kRouterParamsKey) as? Dictionary<String, Any> {
                return params;
            }
            return Dictionary<String,Any>();
        }
    }
    
    @objc func routerParamsDidChanged(_ params:Dictionary<String,Any>?) {
        
    }
    
}
