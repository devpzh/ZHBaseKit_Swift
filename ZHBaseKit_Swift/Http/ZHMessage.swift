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
    func MSG(_ executer:ZHMessageClosure?, _ handler:ZHMessageClosure?) -> ZHMessage {
        
        let message = ZHMessage.init(executer, handler);
        message.responder = self;
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
    
    weak var responder:AnyObject?
    
    var executer:ZHMessageClosure?
    
    var handler:ZHMessageClosure?
    
    init(_ executer:ZHMessageClosure?, _ handler:ZHMessageClosure?)
    {
        self.executer = executer;
        self.handler  = handler;
    }
    
    func send()
    {
        self.input.removeAll();
        self.onStatusChanged(.Sending);
    }
    
    func send(_ params:Dictionary<String,Any>)
    {
        self.input.removeAll();
        if !params.isEmpty {
            self.input = params;
        }
        
        self.onStatusChanged(.Sending);
    }
    
    func onStatusChanged(_ status:HttpRequestStatus)
    {
        
        if self.status == status {
            return;
        }
        
        self.status = status;
        
        if self.executer != nil
        {
            self.executer?(self);
        }
        
        if self.handler != nil
        {
            self.handler?(self);
        }
        
        
    }
    
}
