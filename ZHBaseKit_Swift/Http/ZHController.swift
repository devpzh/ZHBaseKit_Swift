//
//  ZHController.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/12/10.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

class ZHController: NSObject
{

    class func HTTP_GET(_ msg:ZHMessage, _ url:String)
     {
        let path = IP.shared.domains + url;
        API.HTTP_GET(msg: msg, url: path);
     }
     
     
    class func HTTP_POST(_ msg:ZHMessage, _ url:String)
     {
        let path = IP.shared.domains + url;
        API.HTTP_POST(msg: msg, url: path);
         
     }
     
    class func HTTP_DELETE(_ msg:ZHMessage, _ url:String)
     {
         
        let path = IP.shared.domains + url;
        API.HTTP_DELETE(msg: msg, url: path);
         
     }
     
    class func HTTP_PUT(_ msg:ZHMessage, _ url:String)
     {
        let path = IP.shared.domains + url;
        API.HTTP_PUT(msg: msg, url: path);
         
     }
    

}
