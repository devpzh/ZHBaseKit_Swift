//
//  IPAgent.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/12/8.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

let IP = IPAgent.shared;

enum IPServerType {
    case IPServerTypeTest           //< 测试服
    case IPServerTypeDistribution   //< 正式服
}

class IPAgent: NSObject {

    static let shared = { ()->IPAgent in
        let manager = IPAgent();
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
                self.domains = "http://test.92uni.com/uni/";
            
            case .IPServerTypeDistribution:
                self.domains = "https://www.92uni.com/uni/";
            }
        
        }
       
    }
    
    
    
}
