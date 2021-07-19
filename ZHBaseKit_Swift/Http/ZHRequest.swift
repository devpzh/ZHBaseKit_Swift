//
//  ZHRequest.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/12/8.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit
import Alamofire

let API = ZHRequest.shared;
let kEmptyResponseCodes:Set<Int> = [200,204,205];

class ZHRequest: NSObject {
    
    static let shared:ZHRequest = ZHRequest();
    
    override init() {
        super.init();
        self.configuration();
    }
    
    func configuration()  {
        
        AF.session.configuration.timeoutIntervalForRequest  = 30;
        AF.session.configuration.timeoutIntervalForResource = 30;
    }
    
    func headers(_  msg:ZHMessage) -> HTTPHeaders
    {
        var headers = AF.session.configuration.headers;
        if !(msg.headers.isEmpty) {
            for e in msg.headers {
                headers.update(name: e.key, value:e.value as? String ?? "");
            }
        }
        return headers;
    }
    
    func HTTP_GET(msg:ZHMessage, url:String) {
        
        AF.request(url, method:.get, parameters:nil, headers:self.headers(msg)).responseJSON(emptyResponseCodes:kEmptyResponseCodes){(response) in
            self.response(msg:msg, response:response);
        }
    }
    
    func HTTP_POST(msg:ZHMessage, url:String) {
        
        AF.request(url, method:.post, parameters:nil, headers:self.headers(msg)).responseJSON(emptyResponseCodes:kEmptyResponseCodes){(response) in
            self.response(msg:msg, response:response);
        }
    }
    
    
    func HTTP_DELETE(msg:ZHMessage, url:String) {
        
        AF.request(url, method:.delete, parameters:nil, headers:self.headers(msg)).responseJSON(emptyResponseCodes:kEmptyResponseCodes){(response) in
            self.response(msg:msg, response:response);
        }
    }
    
    
    func HTTP_PUT(msg:ZHMessage, url:String) {
        
        AF.request(url, method:.put, parameters:nil, headers:self.headers(msg)).responseJSON(emptyResponseCodes:kEmptyResponseCodes){(response) in
           self.response(msg:msg, response:response);
        }
    }
    
    
    func response(msg:ZHMessage, response:AFDataResponse<Any>)
    {
       switch response.result
        {
         case .success:
            guard let value = response.value else { return }
            let dictionary  = value as! [String: Any]
            msg.responseData = dictionary;
            msg.onStatusChanged(.Succeed);
            
         case .failure:
            
            msg.onStatusChanged(.Failed);
            print("\(String(describing: response.error))")
        }
    }
}
