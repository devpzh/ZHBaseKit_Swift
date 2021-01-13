//
//  Routes.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/12/7.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

typealias RoutesCompleteClosure  = ()->();

let localScheme = "scheme"; ///< scheme

func RoutesPath(_ path:String) -> String {
    return "\(localScheme)://\(path)";
}


//MARK: 若页面之间传值，params的key需要与vc的属性一一对应，且属性要用@objc修饰，或者在vc头部统一用@objcMembers修饰。

class Routes: NSObject
{

    class func routesURL(url:String)
    {
        self.routesURL(url: url, params: nil, present: false, animated: true ,completeClosure:nil)
    }
    
    class func routesURL(url:String, animated:Bool)
    {
        self.routesURL(url: url, params: nil, present: false, animated: animated ,completeClosure:nil)
    }
    
    class func routesURL(url:String, present:Bool)
    {
        self.routesURL(url: url, params: nil, present: present, animated: false ,completeClosure:nil)
    }
    
    class func routesURL(url:String, present:Bool, animated:Bool)
    {
        self.routesURL(url: url, params: nil, present: present, animated: animated ,completeClosure:nil)
    }
    
    class func routesURL(url:String, params:Dictionary<String, Any>)
    {
        self.routesURL(url: url, params: params, present: false, animated: true ,completeClosure:nil)
    }
    
    class func routesURL(url:String, params:Dictionary<String, Any>, animated:Bool)
    {
        self.routesURL(url: url, params: params, present: false, animated: animated ,completeClosure:nil)
    }
    
    class func routesURL(url:String, params:Dictionary<String, Any>, present:Bool)
    {
        self.routesURL(url: url, params: params, present: present, animated: true ,completeClosure:nil)
    }
    
    class func routesURL(url:String, params:Dictionary<String, Any>?, present:Bool, animated:Bool,completeClosure: RoutesCompleteClosure?)
    {
        if url.count < RoutesPath("").count
        {
            return;
        }
        
        let scheme = RoutesScheme.init(url: url, params: params, present: present, animated: animated, completeClosure:completeClosure)
        
        if scheme.path?.count != 0
        {
            self.routesViewController(vcName: scheme.path!, params: params, present: present, animated: animated, completeClosure: completeClosure);
        }
        
    }
    
    class func routesViewController(vcName:String, params:Dictionary<String, Any>?, present:Bool, animated:Bool,completeClosure: RoutesCompleteClosure?){
        
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
        
        if params != nil && !params!.isEmpty {
            
            for (key,values) in params!
            {
                let method = "set"+key.first!.uppercased()+String(key.suffix(key.count-1))+":";
                let SEL =  Selector.init(method);
                if vc!.responds(to: SEL)
                {
                    vc?.perform(SEL,with: values);
                }
            }
            
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

extension Routes
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
