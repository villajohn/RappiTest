//
//  BackgroundGridView.swift
//  RappiTest
//
//  Created by Jhon Villalobos on 9/24/16.
//  Copyright © 2016 Jhon Villalobos. All rights reserved.
//

import UIKit
//import QuartzCore


class BackgroundView: UIView {
    
    static var backgroundSplashImage: UIImage!
    static let animationKeyTimes = [0, 0.61, 0.7, 0.887, 1]
    var shouldEnableRipple = false
    
    convenience init(BackgroundFileName: String) {
        BackgroundView.backgroundSplashImage = UIImage(named: BackgroundFileName, in: Bundle(identifier: "com.jlvillalobos.SplashScreenUI"), compatibleWith: nil)!
        self.init(frame: CGRect.zero)
        frame = CGRect(x: 0, y: 0, width: BackgroundView.backgroundSplashImage.size.width, height: BackgroundView.backgroundSplashImage.size.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.contents = BackgroundView.backgroundSplashImage.cgImage
        layer.shouldRasterize = true
        //layer.borderWidth = 1.0 //si quieres mostrar los bordes de cada grid
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(NSLocalizedString("error_initcoder", comment: ""))
    }
    
    func startAnimatingWithTime(_ time: TimeInterval, beginTime: TimeInterval, delay: TimeInterval, offset: CGPoint) {
        let timingFunction = CAMediaTimingFunction(controlPoints: 0.25, 0, 0.2, 1)
        let linearFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        let easeOutFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        let easeInOutTimingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        let zeroPointValue = NSValue(cgPoint: CGPoint.zero)
        
        var animations = [CAAnimation]()
        
        if shouldEnableRipple {
            // Transform.scale
            let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
            scaleAnimation.values = [1, 1, 1.05, 1, 1]
            scaleAnimation.keyTimes = BackgroundView.animationKeyTimes as [NSNumber]?
            scaleAnimation.timingFunctions = [linearFunction, timingFunction, timingFunction, linearFunction]
            scaleAnimation.beginTime = 0.0
            scaleAnimation.duration = time
            animations.append(scaleAnimation)
            
            // Position
            let positionAnimation = CAKeyframeAnimation(keyPath: "position")
            positionAnimation.duration = time
            positionAnimation.timingFunctions = [linearFunction, timingFunction, timingFunction, linearFunction]
            positionAnimation.keyTimes = BackgroundView.animationKeyTimes as [NSNumber]?
            positionAnimation.values = [zeroPointValue, zeroPointValue, NSValue(cgPoint:offset), zeroPointValue, zeroPointValue]
            positionAnimation.isAdditive = true
            
            animations.append(positionAnimation)
        }
        
        // Opacity
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.duration = time
        opacityAnimation.timingFunctions = [easeInOutTimingFunction, timingFunction, timingFunction, easeOutFunction, linearFunction]
        opacityAnimation.keyTimes = [0.0, 0.61, 0.7, 0.767, 0.95, 1.0]
        opacityAnimation.values = [0.0, 1.0, 0.45, 0.6, 0.0, 0.0]
        animations.append(opacityAnimation)
        
        // Group
        let groupAnimation = CAAnimationGroup()
        groupAnimation.repeatCount = Float.infinity
        groupAnimation.fillMode = kCAFillModeBackwards
        groupAnimation.duration = time
        groupAnimation.beginTime = beginTime + delay
        groupAnimation.isRemovedOnCompletion = false
        groupAnimation.animations = animations
        groupAnimation.timeOffset = splashAnimationTimeOffset
        
        layer.add(groupAnimation, forKey: "ripple")
    }
    
    func stopAnimating() {
        layer.removeAllAnimations()
    }
    
    
}
