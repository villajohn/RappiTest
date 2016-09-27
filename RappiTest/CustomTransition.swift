//
//  CustomTransition.swift
//  RappiTest
//
//  Created by Jhon Villalobos on 9/25/16.
//  Copyright © 2016 Jhon Villalobos. All rights reserved.
//

import Foundation
import UIKit

enum TransitionType {
    case Presenting, Dismissing
}

class AnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    var duration: TimeInterval
    var isPresenting: Bool
    var originFrame: CGRect
    
    init(withDuration duration: TimeInterval, forTransitionType type: TransitionType, originFrame: CGRect) {
        self.duration = duration
        self.isPresenting = type == .Presenting
        self.originFrame = originFrame
        
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        let fromView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!.view
        let toView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!.view
        
        let detailView = self.isPresenting ? toView : fromView
        
        if self.isPresenting {
            containerView.addSubview(toView!)
        } else {
            containerView.insertSubview(toView!, belowSubview: fromView!)
        }
        
        detailView?.frame.origin = self.isPresenting ? self.originFrame.origin : CGPoint(x: 0, y: 0)
        detailView?.frame.size.width = self.isPresenting ? self.originFrame.size.width : containerView.bounds.width
        detailView?.layoutIfNeeded() //transforma el layout según los parámetros configurados
        
        for view in (detailView?.subviews)! {
            if !(view is UIImageView) {
                view.alpha = isPresenting ? 0.0 : 1.0
            }
        }
        
        UIView.animate(withDuration: self.duration, animations: { () -> Void in
            detailView?.frame = self.isPresenting ? containerView.bounds : self.originFrame
            detailView?.layoutIfNeeded()
            
            for view in (detailView?.subviews)! {
                if !(view is UIImageView) {
                    view.alpha = self.isPresenting ? 1.0 : 0.0
                }
            }
        }) { (completed: Bool) -> Void in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        
    }
}

extension ApplicationsViewController: UIViewControllerTransitioningDelegate {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //segue.destinationViewController.transitioningDelegate = self
        if segue.identifier == "show_details", let destination = segue.destination as? DetailViewController {
            if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                let details : Application
                if filteredItems.count > 0 {
                    details = filteredItems[indexPath.row]
                } else {
                    details = appList[indexPath.row]
                }
                destination.appDetail = details
                destination.transitioningDelegate = self
                destination.rootViewController = self
            } else if let cell = sender as? UICollectionViewCell, let indexPath = collectionView.indexPath(for: cell) {
                let details : Application
                if filteredItems.count > 0 {
                    details = filteredItems[indexPath.row]
                } else {
                    details = appList[indexPath.row]
                }
                destination.appDetail = details
                destination.transitioningDelegate = self
                destination.rootViewController = self
            }
        }
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationController(withDuration: 1.0, forTransitionType: .Dismissing, originFrame: CGRect(x: 400, y: 400, width: self.tableView.layer.frame.width, height: self.tableView.layer.frame.height))
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimationController(withDuration: 1.0, forTransitionType: .Presenting, originFrame: CGRect(x: -400, y: -400, width: self.tableView.layer.frame.width, height: self.tableView.layer.frame.height))
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interactionController
    }
}

