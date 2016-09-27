//
//  Utils.swift
//  RappiTest
//
//  Created by Jhon Villalobos on 9/24/16.
//  Copyright © 2016 Jhon Villalobos. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration


//*****************************************************************
// MARK: - Extensions
//*****************************************************************

public extension UIColor {
    public class func pieOrangeColor()->UIColor {
        struct O {
            static var c : UIColor = UIColor(red: 255/255.0, green: 79/255.0, blue: 66/255.0, alpha: 1.0)
        }
        return O.c
    }
    
    public class func rappidGrayColor()->UIColor {
        struct G {
            static var c : UIColor = UIColor(red: 227/255.0, green: 227/255.0, blue: 229/255.0, alpha: 1.0)
        }
        return G.c
    }
    
    public class func rappiGreenColor()->UIColor {
        struct G {
            static var c : UIColor = UIColor(red: 89/255.0, green: 178/255.0, blue: 172/255.0, alpha: 1.0)
        }
        return G.c
    }
    
}



//*****************************************************************
// MARK: - Ayudas
//*****************************************************************

public func delay(_ delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

func roundedPictureWithBackground(sender: UIImageView, color: UIColor) {
    sender.layer.borderWidth   = 1
    sender.layer.masksToBounds = false
    sender.layer.borderColor   = color.cgColor
    sender.layer.cornerRadius  = (sender.frame.height)/2
    sender.clipsToBounds       = true
    sender.backgroundColor     = color
}

func roundedPictureWithout(sender: UIImageView, color: UIColor) {
    sender.layer.borderWidth   = 1
    sender.layer.masksToBounds = false
    sender.layer.borderColor   = color.cgColor
    sender.layer.cornerRadius  = (sender.frame.height)/2
    sender.clipsToBounds       = true
}

func globalMessage(msgtitle: NSString, msgBody: NSString, delegate: AnyObject?, self: UIViewController) {
    let alert: UIAlertController = UIAlertController()
    alert.title = msgtitle as String
    alert.message = msgBody as String
    let close   = UIAlertAction(title: "Ok", style: .cancel, handler: { (action) -> Void in })
    alert.addAction(close)
    self.present(alert, animated: true, completion: nil)
}

func connectedToNetwork() -> Bool {
    
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
            SCNetworkReachabilityCreateWithAddress(nil, $0)
        }
    }) else {
        return false
    }
    
    var flags: SCNetworkReachabilityFlags = []
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
        return false
    }
    
    let isReachable = flags.contains(.reachable)
    let needsConnection = flags.contains(.connectionRequired)
    
    return (isReachable && !needsConnection)
}
