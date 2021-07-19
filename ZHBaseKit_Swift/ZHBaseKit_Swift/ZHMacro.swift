//
//  ZHMacro.swift
//  ZHBaseKit_Swift
//
//  Created by pzh on 2020/5/15.
//  Copyright © 2020 pzh. All rights reserved.
//

import UIKit

//MARK:
let kScreenWidth                 = UIScreen.main.bounds.width;
let kScreenHeight                = UIScreen.main.bounds.height;
let kNavigationBarHeight:CGFloat = isPhoneX() ? 88.0 : 64.0;
let kStatusBarHeight:CGFloat     = isPhoneX() ? 44.0 : 20.0;
let kTabbarHeight :CGFloat       = isPhoneX() ? 83.0 : 49.0;
let kBottomSafeHeight :CGFloat   = isPhoneX() ? 34.0 : 0.0;

let kMargin:CGFloat       = 10.0;
let kSpace:CGFloat        = 16.0;
let kPadding:CGFloat      = 8.0;
let kScale:CGFloat        = 1.0/UIScreen.main.scale;

func isPhoneX() -> Bool {
    
    var isPhoneX = false;
    if #available(iOS 11.0, *){
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom;
        isPhoneX = (bottom ?? 0) > 0.0;
        
    }
    return isPhoneX;

}

//MARK: Image
func kImageName(_ name:String) -> UIImage
{
    return  UIImage.init(named: name) ?? UIImage.init();
}


//MARK: Font
func kFont(_ size:CGFloat) -> UIFont
{
    return  UIFont.systemFont(ofSize: size);
}

func kBoldFont(_ size:CGFloat) -> UIFont
{
    return  UIFont.boldSystemFont(ofSize: size);
}

func kMediumFont(_ size:CGFloat) -> UIFont
{
    return  UIFont.systemFont(ofSize: size, weight:.medium)
}


//MARK: Color
extension UIColor
{
    static func rgb(r:CGFloat, g:CGFloat, b:CGFloat) -> UIColor
    {
        return UIColor.rgb(r: r, g: g, b: b, alpha: 1.0);
    }
    
    static func rgb(r:CGFloat, g:CGFloat, b:CGFloat, alpha:CGFloat) -> UIColor
    {
        return UIColor.init(red: r/255.0 , green: g/255.0, blue: b/255.0, alpha: alpha);
    }
    
    public convenience init(_ hex: String) {
       
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
let kIphoneX_height   = 812
let kIphoneX_width    = 375
let kIphone6p_height  = 736
let kIphone6p_width   = 414
let kIphone11_width   = 414
let kIphone11_height  = 896

public func kScaleWidth(_ width : CGFloat) -> CGFloat {
    return width * kScreenWidth / CGFloat(kIphone11_width)
}
public func kScaleHeight(_ height : CGFloat) -> CGFloat {
    return height * kScreenHeight / CGFloat(kIphone11_height)
}


public func kScaleWidth(_ width : CGFloat, _ scaleWidth:CGFloat) -> CGFloat {
    return width * kScreenWidth / scaleWidth;
}
public func kScaleHeight(_ height : CGFloat,_ scaleHeight:CGFloat ) -> CGFloat {
    return height * kScreenHeight / scaleHeight;
}


//MARK: salce
extension CGFloat {
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

