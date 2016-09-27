//
//  BackgroundGridView.swift
//  RappiTest
//
//  Created by Jhon Villalobos on 9/24/16.
//  Copyright © 2016 Jhon Villalobos. All rights reserved.
//

import UIKit

class BackgroundGridView: UIView {

    var containerView: UIView!
    var objectBackgroundView: BackgroundView!
    var centerBackgroundView: BackgroundView? = nil
    var numberOfRows    = 0
    var numberOfColumns = 0
    
    var logoLabel: UILabel!
    var backgroundViewRows: [[BackgroundView]] = []
    var startTime: CFTimeInterval = 0
    let splashDelayMultiplier: TimeInterval = 0.0006666
    
    required init(coder aDecoder: NSCoder) {
        fatalError(NSLocalizedString("error_initcoder", comment: ""))
    }
    
    //Aqui va el log en todo el centro
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.center = center
        objectBackgroundView.center = containerView.center
        if let centerBackgroundView = centerBackgroundView {

            let center = CGPoint(x: centerBackgroundView.bounds.midX + 31, y: centerBackgroundView.bounds.midY)
            logoLabel.center = center
        }
    }
    
    init(FileName: String) {
        objectBackgroundView = BackgroundView(BackgroundFileName: FileName)
        super.init(frame: CGRect.zero)
        clipsToBounds = true
        layer.masksToBounds = true
        
        containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 630.0, height: 990.0))
        containerView.backgroundColor = UIColor(colorLiteralRed: 255/255.0, green: 79/255.0, blue: 66/255.0, alpha: 1.0)
        containerView.clipsToBounds = false
        containerView.layer.masksToBounds = false
        addSubview(containerView)
        
        renderBackgroundViews()
        
        logoLabel = generateLogoLabel()
        centerBackgroundView?.addSubview(logoLabel)
        layoutIfNeeded()
    }
    
    func startAnimating() {
        startTime = CACurrentMediaTime()
        startAnimation(startTime)
    }

}

extension BackgroundGridView {
    
    func generateLogoLabel()->UILabel {
        let label = UILabel()
        label.text = "RAPPI TEST"
        label.font = UIFont.systemFont(ofSize: 50)
        label.textColor = UIColor.white
        label.sizeToFit()
        label.center = CGPoint(x: bounds.midX, y: bounds.midY)
        return label
    }
    
    func renderBackgroundViews() {
        let width  = self.containerView.bounds.width
        let height = containerView.bounds.height
        
        let modelImageWidth = objectBackgroundView.bounds.width
        let modelImageHeight = objectBackgroundView.bounds.height
        
        numberOfColumns = Int(ceil((width - objectBackgroundView.bounds.size.width / 2.0) / objectBackgroundView.bounds.size.width))
        numberOfRows = Int(ceil((height - objectBackgroundView.bounds.size.height / 2.0) / objectBackgroundView.bounds.size.height))
        
        
        for y in 0 ..< numberOfRows {
            
            var backgroundRows: [BackgroundView] = []
            for x in 0 ..< numberOfColumns {
                
                let view = BackgroundView()
                view.frame = CGRect(x: CGFloat(x) * modelImageWidth, y:CGFloat(y) * modelImageHeight, width: modelImageWidth, height: modelImageHeight)
                
                if view.center == containerView.center {
                    centerBackgroundView = view
                }
                
                containerView.addSubview(view)
                backgroundRows.append(view)
                
                if y != 0 && y != numberOfRows - 1 && x != 0 && x != numberOfColumns - 1 {
                    view.shouldEnableRipple = true
                }
            }
            
            backgroundViewRows.append(backgroundRows)
        }
        
        if let centerBackgroundView = centerBackgroundView {
            containerView.bringSubview(toFront: centerBackgroundView)
        }
    }
    
    func startAnimation(_ beginTime: TimeInterval) {
        let linearTimingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        let keyframe = CAKeyframeAnimation(keyPath: "transform.scale")
        keyframe.timingFunctions = [linearTimingFunction, CAMediaTimingFunction(controlPoints: 0.6, 0.0, 0.15, 1.0), linearTimingFunction]
        keyframe.repeatCount = Float.infinity;
        keyframe.duration = splashAnimationDuration
        keyframe.isRemovedOnCompletion = false
        keyframe.keyTimes = [0.0, 0.45, 0.887, 1.0]
        keyframe.values = [0.75, 0.75, 1.0, 1.0]
        keyframe.beginTime = beginTime
        keyframe.timeOffset = splashAnimationTimeOffset
        
        containerView.layer.add(keyframe, forKey: "scale")
        
        for backRows in backgroundViewRows {
            for view in backRows {
                
                let distance = self.distanceFromCenter(view)
                var vector = self.normalizedVectorFromCenter(view)
                let magnitudeCGFloat = CGFloat(splashRippleMagnitudeMultiplier)
                vector = CGPoint(x: vector.x * magnitudeCGFloat * distance, y: vector.y * magnitudeCGFloat * distance)
                
                view.startAnimatingWithTime(splashAnimationDuration, beginTime: beginTime, delay: splashDelayMultiplier * TimeInterval(distance), offset: vector)
            }
        }
    }
    
    fileprivate func distanceFromCenter(_ view: UIView)->CGFloat {
        guard let centerBackgroundView = centerBackgroundView else { return 0.0 }
        
        let normalizedX = (view.center.x - centerBackgroundView.center.x)
        let normalizedY = (view.center.y - centerBackgroundView.center.y)
        return sqrt(normalizedX * normalizedX + normalizedY * normalizedY)
    }
    
    fileprivate func normalizedVectorFromCenter(_ view: UIView)->CGPoint {
        let length = self.distanceFromCenter(view)
        
       guard let centerBackgroundView = centerBackgroundView , length != 0 else { return CGPoint.zero }
    
        let deltaX = view.center.x - (centerBackgroundView.center.x)
        let deltaY = view.center.y - (centerBackgroundView.center.y)
        return CGPoint(x: deltaX / length, y: deltaY / length)
    }
    
}
