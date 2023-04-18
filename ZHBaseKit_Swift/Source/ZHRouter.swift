//
//  ADRouter.swift
//  AidongFitnessDemo
//
//  Created by pzh on 2023/3/23.
//

import UIKit

public extension ZH {
    static let router = ZHRouter.self
}

public typealias ZHRouterCompleteClosure = ()->();

open class ZHRouter
{
    
    public class func router(spaceName:String? = Bundle.main.infoDictionary?["CFBundleExecutable"] as? String, url:String, params:[String:Any]? = nil, present:Bool = false, animated:Bool = true ,presentationStyle:UIModalPresentationStyle = .overFullScreen) {
       
        router(spaceName:spaceName ?? "",url: url, params: params, present: present, animated: animated, presentationStyle: presentationStyle, completeClosure: nil);
    }
    
    class func router(spaceName:String,url:String, params:[String:Any]?, present:Bool, animated:Bool , presentationStyle:UIModalPresentationStyle?,completeClosure: ZHRouterCompleteClosure?)
    {
        if url.isEmpty == true {
            return
        }
        
        routerViewController(spaceName:spaceName,vc: url, params: params, present: present, animated: animated, presentationStyle: presentationStyle,completeClosure: completeClosure);
        
        
    }
    
    class func routerViewController(spaceName:String,vc:String, params:[String:Any]?, present:Bool, animated:Bool, presentationStyle:UIModalPresentationStyle?,completeClosure: ZHRouterCompleteClosure?){
    
        let clazz:AnyClass = NSClassFromString(spaceName + "." + vc)!
        let clazzType = clazz as? UIViewController.Type;
        if  clazzType == nil {
           return;
        }
        
        let vc = clazzType?.init();
        if  vc == nil {
            return;
        }
        
        if params != nil && params?.isEmpty == false {
           (vc as? ZHBaseBoard)?.routerParams = params;
        }
        
        guard let topVc = topViewController() else {
            print("ZHRouter: Error topViewController nil")
            return  }
        
        if present {
            let nav = ZHNavigationBoard(rootViewController: vc!)
            nav.modalPresentationStyle = presentationStyle ?? .overFullScreen;
            topVc.present(nav, animated: animated, completion: completeClosure);
            return;
        }
        
        if topVc.navigationController != nil
        {
            topVc.navigationController?.pushViewController(vc!, animated: animated)
            
        }else
        {
            let nav = newNav(top: topVc);
            nav.pushViewController(vc!, animated: animated);
        }
        
    }
    
}

extension ZHRouter
{
   public class func application() -> UIApplication
    {
        return UIApplication.shared;
    }
    
   public class func keyWindow() -> UIWindow? {
        return UIApplication.shared.keyWindow;
    }
    
    
   public class func topViewController() -> UIViewController? {
        return topViewController(root: rootViewController());
    }
    
   public class func topViewController(root:UIViewController?) -> UIViewController? {
        
        if let tabbar = root as? UITabBarController {
            return topViewController(root: tabbar.selectedViewController)
        }
        
        if let navi = root as? UINavigationController {
            return topViewController(root: navi.visibleViewController)
        }
        
       return root
        
    }
    
   public class func rootViewController() -> UIViewController? {
        
        var root:UIViewController?
        var window = UIApplication.shared.keyWindow;
        if  window?.windowLevel != .normal {
            let windows = UIApplication.shared.windows;
            for tWindow in windows {
                if tWindow.windowLevel == .normal {
                    window = tWindow;
                    break;
                }
            }
        }
        
        let frontView = window?.subviews.first;
        let nextResponder = frontView?.next
        if  nextResponder != nil && (nextResponder!.isKind(of: UIViewController.self))
        {
            root = nextResponder as? UIViewController;
        }else{
            root = window?.rootViewController;
        }
        
        return root;
    }
    
    class func newNav(top:UIViewController) -> ZHNavigationBoard {
        
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

private var kRouterParamsKey = "kZHRouterParamsKey";
public extension ZHBaseBoard {
    
    var routerParams:[String:Any]? {
        
        set {
            
            objc_setAssociatedObject(self, &kRouterParamsKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC);
            self.routerParamsDidChanged(newValue);
        }
    
        get{
            
            if let params = objc_getAssociatedObject(self, &kRouterParamsKey) as? Dictionary<String, Any> {
                return params;
            }
            return nil
        }
    }
    
    @objc func routerParamsDidChanged(_ params:[String:Any]?) {
        
    }
    
}

private var kSideslipEnableForPresentationStyleKey = "kSideslipEnableForPresentationStyleKey";
private var kSideslipGestureRecognizerKey          = "kSideslipGestureRecognizerKey";

public extension ZHBaseBoard {
    
    var sideslipEnableForPresentationStyle:Bool? {

        set {
            objc_setAssociatedObject(self, &kSideslipEnableForPresentationStyleKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN);
            self.sideslipEnableChagend(newValue ?? false);
        }

        get {
            return objc_getAssociatedObject(self, &kSideslipEnableForPresentationStyleKey) as? Bool;
        }
    }
    
    
    var sideslipGesture:UIScreenEdgePanGestureRecognizer? {

        set {
           objc_setAssociatedObject(self, &kSideslipGestureRecognizerKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }

        get {
            return objc_getAssociatedObject(self, &kSideslipGestureRecognizerKey) as? UIScreenEdgePanGestureRecognizer;
        }
    }
    
    func sideslipEnableChagend(_ enable:Bool) {
        if enable == true {
            self.addSideslipGesture();
        }else {
            self.removeSideslipGesture();
        }
    }

   private func addSideslipGesture()  {
        
        let  sideslipGesture = UIScreenEdgePanGestureRecognizer.init(target: self, action: #selector(sideslipGestureAction(gesture:)));
        sideslipGesture.edges = .left;
        self.navigationController?.view.addGestureRecognizer(sideslipGesture);
        self.sideslipGesture = sideslipGesture;
    }
    
   private func removeSideslipGesture() {
        
        if self.sideslipGesture == nil {
            return;
        }
        self.navigationController?.view.removeGestureRecognizer(self.sideslipGesture!);
    }
    
    @objc func sideslipGestureAction(gesture:UIScreenEdgePanGestureRecognizer)  {
        
        let point:CGPoint = gesture.translation(in: self.view);
        
        if gesture.state == .began {
            self.navigationController?.view.transform = CGAffineTransform.init(translationX: point.x, y: 0);
        }else if gesture.state == .changed {
            self.navigationController?.view.transform = CGAffineTransform.init(translationX: point.x >= 0 ? point.x:0, y: 0);
        }else {
            
            if point.x >= UIScreen.main.bounds.size.width/2 {
                UIView.animate(withDuration: 0.25) {
                    self.navigationController?.view.transform = CGAffineTransform.init(translationX: UIScreen.main.bounds.size.width, y: 0);
                } completion: { finished in
                    self.dismiss(animated: true, completion: nil);
                }
            }else {
             
                UIView.animate(withDuration: 0.25) {
                    self.navigationController?.view.transform = CGAffineTransform.init(translationX: 0, y: 0);
                } completion: { finished in
                    
                }
            }
        }
        
    }
    
}
