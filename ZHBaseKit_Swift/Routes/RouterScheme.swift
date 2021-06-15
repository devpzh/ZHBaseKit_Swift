//
//  RouterScheme.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/12/7.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

class RouterScheme: NSObject {
   
    var path:String?;
    var present = false;
    var animated = false;
    var completeClosure:RouterCompleteClosure?
    var params:Dictionary<String, Any>?;

    init(url:String, params:Dictionary<String, Any>?, present:Bool, animated:Bool, completeClosure:RouterCompleteClosure?)
    {
        self.present = present;
        self.animated = animated;
        
        if completeClosure != nil {
            self.completeClosure = completeClosure!;
        }
        
        var obj = Dictionary<String, Any>();
        if params != nil && !params!.isEmpty
        {
            obj = params!;
        }
        
        let prefix = "\(localScheme)://";
        
        if url.hasPrefix(prefix){
            
            var tPath = "";
            let target  = String(url.suffix(url.count-prefix.count));
            if !target.contains("?")
            {
                tPath = String(target);
                print("path: \(tPath)")
                
            }else
            {
                let pair:Array = target.components(separatedBy: "?");
                if pair.count != 0 {
                    tPath = pair[0];
                }
                
                if pair.count > 1 {
                    let paramsString = pair[1];
                    if paramsString.count > 0 {
                        let querys = paramsString.components(separatedBy:"&");
                        
                        for index in 0..<querys.count {
                            let query:String = querys[index];
                            if (query.count > 0) && (query.contains("="))
                            {
                                let keyValues = query.components(separatedBy:"=");
                                if keyValues.count == 2 {
                                    let key     =  keyValues[0];
                                    let values  =  keyValues[1];
                                    
                                    print("\(key):\(values)")
                                    if key.count > 0 && values.count > 0
                                    {
                                        obj[key] = values;
                                    }
                                    
                                }
                            }
                            
                        }
                        
                    }
                }
                
            }
                
            self.path = tPath;
            self.params = obj;
            
        }
    
    }
    
}
