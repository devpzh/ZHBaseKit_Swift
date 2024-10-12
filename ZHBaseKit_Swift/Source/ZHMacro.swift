//
//  ZHMacro.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/5/15.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

//MARK:
public let kScreenWidth                 = UIScreen.main.bounds.width
public let kScreenHeight                = UIScreen.main.bounds.height
public let kNavigationBarHeight:CGFloat = statusBarHeight() + 44.0
public let kStatusBarHeight:CGFloat     = isPhoneX() ? statusBarHeight() : 20.0
public let kTabbarHeight :CGFloat       = isPhoneX() ? 83.0 : 49.0
public let kBottomSafeHeight :CGFloat   = isPhoneX() ? 34.0 : 0.0
public let kTopSafeHeight:CGFloat       = isPhoneX() ? 24.0 : 0.0

public let kMargin:CGFloat       = 10.0
public let kSpace:CGFloat        = 16.0
public let kPadding:CGFloat      = 8.0
public let kScale:CGFloat        = 1.0/UIScreen.main.scale


public func statusBarHeight() -> CGFloat {
    
    if #available(iOS 13.0, *) {
      return UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.size.height ?? 44.0
    }
    if #available(iOS 11.0, *) {
       return UIApplication.shared.statusBarFrame.size.height
    }
    return 44
}

public func isPhoneX() -> Bool {
    
    var isPhoneX = false
    if #available(iOS 11.0, *){
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom
        isPhoneX = (bottom ?? 0) > 0.0
        
    }
    return isPhoneX

}

//MARK: Image
public func kImageName(_ name:String) -> UIImage
{
    return  UIImage.init(named: name) ?? UIImage.init()
}

//MARK: Font
public func kFont(_ size:CGFloat) -> UIFont
{
    return  UIFont.systemFont(ofSize: size)
}

public func kBoldFont(_ size:CGFloat) -> UIFont
{
    return  UIFont.boldSystemFont(ofSize: size)
}

public func kMediumFont(_ size:CGFloat) -> UIFont
{
    return  UIFont.systemFont(ofSize: size, weight:.medium)
}


//MARK: Color
public extension UIColor
{
    static func rgb(r:CGFloat, g:CGFloat, b:CGFloat) -> UIColor
    {
        return UIColor.rgb(r: r, g: g, b: b, alpha: 1.0)
    }
    
    static func rgb(r:CGFloat, g:CGFloat, b:CGFloat, alpha:CGFloat) -> UIColor
    {
        return UIColor.init(red: r/255.0 , green: g/255.0, blue: b/255.0, alpha: alpha)
    }
    
    convenience init(_ hex: String) {
       
       var red:   CGFloat = 0.0
       var green: CGFloat = 0.0
       var blue:  CGFloat = 0.0
       var alpha: CGFloat = 1.0
       var hex:   String = hex
       
       if hex.hasPrefix("#") {
           let index = hex.index(hex.startIndex, offsetBy: 1)
           hex = String(hex[index...])
       }
       
       let scanner = Scanner(string: hex)
       var hexValue: CUnsignedLongLong = 0
       if scanner.scanHexInt64(&hexValue) {
           switch (hex.count) {
           case 3:
               red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
               green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
               blue  = CGFloat(hexValue  & 0x00F)              / 15.0
           case 4:
               red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
               green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
               blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
               alpha = CGFloat(hexValue  & 0x000F)            / 15.0
           case 6:
               red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
               green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
               blue  = CGFloat(hexValue  & 0x0000FF)          / 255.0

           case 8:
               red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
               green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
               blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
               alpha = CGFloat(hexValue  & 0x000000FF)        / 255.0
           default:
               print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8", terminator: "")
           }
       } else {
           print("Scan hex error")
       }
       self.init(red:red, green:green, blue:blue, alpha:alpha)
   }
}


//MARK: iphone size
public let kIphoneX_height   = 812
public let kIphoneX_width    = 375
public let kIphone6p_height  = 736
public let kIphone6p_width   = 414
public let kIphone11_width   = 414
public let kIphone11_height  = 896

public func kScaleWidth(_ width : CGFloat) -> CGFloat {
    return width * kScreenWidth / CGFloat(kIphone11_width)
}

public func kScaleHeight(_ height : CGFloat) -> CGFloat {
    return height * kScreenHeight / CGFloat(kIphone11_height)
}

public func kScaleWidth(_ width : CGFloat, _ scaleWidth:CGFloat) -> CGFloat {
    return width * kScreenWidth / scaleWidth
}
public func kScaleHeight(_ height : CGFloat,_ scaleHeight:CGFloat ) -> CGFloat {
    return height * kScreenHeight / scaleHeight
}


//MARK: salce
public extension CGFloat {
   
    var scalex: CGFloat{
        get{
            return CGFloat(kScaleWidth(self))
        }
    }
    
    var scaley:CGFloat{
        get{
            return CGFloat(kScaleHeight(self))
        }
    }
    
}

