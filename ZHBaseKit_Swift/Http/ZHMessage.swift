//
//  ZHMessage.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/12/8.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

extension NSObject
{
    func MSG(_ perform:ZHMessageClosure?, _ response:ZHMessageClosure?) -> ZHMessage {
        
        let message = ZHMessage.init(perform, response);
        message.delegate = self;
        return message;
    }
    
    func MSG(_ perform:ZHMessageClosure?) -> ZHMessage {
        
        let message = ZHMessage.init(perform);
        message.delegate = self;
        return message;
    }
    
}

let kMsgOutPutKey = "kMsgOutPutKey"

enum HttpRequestStatus
{
    case Sending
    case Succeed
    case Cancel
    case Failed
}

typealias ZHMessageClosure = (ZHMessage)->();

class ZHMessage: NSObject {

    
    var input:Dictionary<String,Any> =
    {
        let input = Dictionary<String,Any>();
        return input;
    }()

    var output:Dictionary<String,Any> =
    {
        let output = Dictionary<String,Any>();
        return output;
    }()
    
    
    //MARK: 请求状态
    var status:HttpRequestStatus?
    
    var responseData:Dictionary<String,Any>?
    {
        didSet {
            
        }
        
    }
    
    weak var delegate:AnyObject?
    
    var perform:ZHMessageClosure?
    
    var response:ZHMessageClosure?
    
    init(_ perform:ZHMessageClosure?, _ response:ZHMessageClosure?)
    {
        self.perform   = perform;
        self.response  = response;
    }
    
    init(_ perform:ZHMessageClosure?)
    {
        self.perform = perform;
    }
    
    func send() ->Self
    {
        self.input.removeAll();
        self.onStatusChanged(.Sending);
        
        return self;
    }
    
    func send(_ params:Dictionary<String,Any>) ->Self
    {
        self.input.removeAll();
        if !params.isEmpty {
            self.input = params;
        }
        
        self.onStatusChanged(.Sending);
        return self;
    }
    
    func onStatusChanged(_ status:HttpRequestStatus)
    {
        
        if self.status == status {
            return;
        }
        
        self.status = status;
        self.perform?(self);
        self.response?(self);
        
    }
    
}
