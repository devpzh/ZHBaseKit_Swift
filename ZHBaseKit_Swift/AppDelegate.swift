//
//  AppDelegate.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/4/10.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
        window = UIWindow.init(frame: UIScreen.main.bounds);
        window?.backgroundColor    = UIColor.white;
        window?.rootViewController = TabbarBoard();
        window?.makeKeyAndVisible();
        
        return true
    }

    

}

