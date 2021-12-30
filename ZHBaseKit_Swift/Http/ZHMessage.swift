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
    //MARK: Instance Func
    func MSG(_ perform:ZHMessageClosure?, _ response:ZHMessageClosure?) -> ZHMessage {
        
        let message = ZHMessage.init(perform, response);
        return message;
    }
    
    func MSG(_ perform:ZHMessageClosure?, _ response:ZHMessageClosure?,_ headers:Dictionary<String,Any>? ) -> ZHMessage {
        
        let message = ZHMessage.init(perform, response);
        if  headers != nil {
            message.headers  = headers!;
        }
        return message;
    }
    
    func MSG(_ perform:ZHMessageClosure?) -> ZHMessage {
        
        let message = ZHMessage.init(perform);
        return message;
    }
    
    func MSG(_ perform:ZHMessageClosure?,_ headers:Dictionary<String,Any>?) -> ZHMessage {
        
        let message = ZHMessage.init(perform);
        if headers != nil {
            message.headers  = headers!;
        }
        return message;
    }
    
    
    //MARK: Static Func
    static func MSG(_ perform:ZHMessageClosure?, _ response:ZHMessageClosure?) -> ZHMessage {
        
        let message = ZHMessage.init(perform, response);
        return message;
    }
    
    
    static func MSG(_ perform:ZHMessageClosure?, _ response:ZHMessageClosure?,_ headers:Dictionary<String,Any>? ) -> ZHMessage {
        
        let message = ZHMessage.init(perform, response);
        if  headers != nil {
            message.headers  = headers!;
        }
        return message;
    }
    
    
    static func MSG(_ perform:ZHMessageClosure?) -> ZHMessage {
        
        let message = ZHMessage.init(perform);
        return message;
    }
    
    
    static func MSG(_ perform:ZHMessageClosure?,_ headers:Dictionary<String,Any>?) -> ZHMessage {
        
        let message = ZHMessage.init(perform);
        if headers != nil {
            message.headers  = headers!;
        }
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

class ZHMessage {

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
    
    var headers:Dictionary<String,Any> =
    {
        let output = Dictionary<String,Any>();
        return output;
    }()
    
    //MARK: 请求状态
    var status:HttpRequestStatus?
    
    //MARK: response
    var responseData:Dictionary<String,Any>?
    {
        didSet {
            
        }
        
    }
    
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
    
    @discardableResult
    func send() ->Self
    {
        self.input.removeAll();
        self.onStatusChanged(.Sending);
        return self;
    }
    
    @discardableResult
    func send(_ params:Dictionary<String,Any>)-> Self
    {
        self.input.removeAll();
        if !params.isEmpty {
            self.input = params;
        }
        self.onStatusChanged(.Sending);
        return self
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
    
    deinit {
        print(" message deint")
    }
}
