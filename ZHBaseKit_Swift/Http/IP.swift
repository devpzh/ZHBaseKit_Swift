//
//  IPAgent.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/12/8.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit


enum IPServerType {
    case IPServerTypeTest           //< 测试服
    case IPServerTypeDistribution   //< 正式服
}

class IP: NSObject {

    static let shared = { ()->IP in
        let manager = IP();
        manager.type = .IPServerTypeTest;
        return manager;
    }()
    
    var domains = "";
      
    var type:IPServerType = .IPServerTypeTest
    {
        didSet
        {
            switch type{
            case .IPServerTypeTest:
                self.domains = "http://dev.kscore.com";
                break;

            case .IPServerTypeDistribution:
                self.domains = "https://api.kscore.com";
                break;
            }
        
        }
       
    }
    
    
    
}
