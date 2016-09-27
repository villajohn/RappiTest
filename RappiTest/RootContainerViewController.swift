//
//  RootContainerViewController.swift
//  RappiTest
//
//  Created by Jhon Villalobos on 9/24/16.
//  Copyright © 2016 Jhon Villalobos. All rights reserved.
//

import UIKit

class RootContainerViewController: UIViewController {
    
    var rootViewController: UIViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.pieOrangeColor()
        //showJustSplashViewController() //Esta función deja la app sólo en el Splash
        showSplashViewController()
    }
    
    /// Does not transition to any other UIViewControllers, SplashViewController only
    func showJustSplashViewController() {
        
        if rootViewController is SplashViewController {
            return
        }
        
        rootViewController?.willMove(toParentViewController: nil)
        rootViewController?.removeFromParentViewController()
        rootViewController?.view.removeFromSuperview()
        rootViewController?.didMove(toParentViewController: nil)
        
        let splashViewController = SplashViewController(fileName: "bigote")
        rootViewController = splashViewController
        splashViewController.puslsing = true
        
        splashViewController.willMove(toParentViewController: self)
        addChildViewController(splashViewController)
        view.addSubview(splashViewController.view)
        splashViewController.didMove(toParentViewController: self)
    }
    
    /// Simulates an API handshake success and transitions to MapViewController
    func showSplashViewController() {
        showJustSplashViewController()
        
        delay(3.00) {
            self.showMenuNavigationViewController()
        }
    }
    
    /// Displays the MapViewController
    func showMenuNavigationViewController() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nav = storyboard.instantiateViewController(withIdentifier: "MainNavigator") as! UINavigationController
        nav.willMove(toParentViewController: self)
        addChildViewController(nav)
        
        if let rootViewController = self.rootViewController {
            self.rootViewController = nav
            rootViewController.willMove(toParentViewController: nil)
            
            transition(from: rootViewController, to: nav, duration: 0.55, options: [.transitionCrossDissolve, .curveEaseOut], animations: {
                    () -> Void in
                }, completion: { _ in
                    nav.didMove(toParentViewController: self)
                    rootViewController.removeFromParentViewController()
                    rootViewController.didMove(toParentViewController: nil)
            })
        } else {
            rootViewController = nav
            view.addSubview(nav.view)
            nav.didMove(toParentViewController: self)
        }
    }
    
    
    override var prefersStatusBarHidden : Bool {
        switch rootViewController  {
        case is SplashViewController:
            return true
        /*case is MenuNavigationViewController:
            return false*/
        default:
            return false
        }
    }
}
