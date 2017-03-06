//
//  HomeViewController.swift
//  RappiTest
//
//  Created by Jhon Villalobos on 9/25/16.
//  Copyright © 2016 Jhon Villalobos. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    @IBOutlet weak var aboutButton: UIButton!
    @IBOutlet weak var applicationButton: UIButton!
    @IBOutlet weak var contactButton: UIButton!
    @IBOutlet weak var applicationLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var navBarPad: UINavigationBar!
    
    @IBOutlet weak var padAppButton: UIButton!
    @IBOutlet weak var padContactButton: UIButton!
    @IBOutlet weak var padAboutButton: UIButton!
    

    @IBOutlet weak var appLblBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var abtLblBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var cntLblBottomConstraint: NSLayoutConstraint!
    
    let transition = CircularTransition()
    var dismissButton = UIButton()
    var presentButton = UIButton()
    
    override func viewWillAppear(_ animated: Bool) {
        aboutButton.alpha       = 0.0
        aboutLabel.alpha        = 0.0
        applicationButton.alpha = 0.0
        applicationLabel.alpha  = 0.0
        contactButton.alpha     = 0.0
        contactLabel.alpha      = 0.0
        padAppButton.alpha      = 0.0
        padContactButton.alpha  = 0.0
        padAboutButton.alpha    = 0.0
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            UIView.animate(withDuration: 0.2, delay: 0.2, options: .curveEaseOut, animations: {
                self.applicationButton.alpha = 1.0
                self.applicationLabel.alpha  = 1.0
            })
            
            UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseOut, animations: {
                self.aboutButton.alpha = 1.0
                self.aboutLabel.alpha  = 1.0
            })
            
            UIView.animate(withDuration: 0.5, delay: 0.8, options: .curveEaseOut, animations: {
                self.contactButton.alpha = 1.0
                self.contactLabel.alpha  = 1.0
            })
        } else {
            UIView.animate(withDuration: 0.2, delay: 0.2, options: .curveEaseOut, animations: {
                self.padAppButton.alpha = 1.0
                self.padAppButton.alpha  = 1.0
            })
            
            UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseOut, animations: {
                self.padAboutButton.alpha = 1.0
            })
            
            UIView.animate(withDuration: 0.5, delay: 0.8, options: .curveEaseOut, animations: {
                self.padContactButton.alpha = 1.0
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView() {
        
        view.backgroundColor = UIColor.pieOrangeColor()
        
        /** Navigation bar **/
//        let backItem = UIBarButtonItem()
//        backItem.title = ""
//        navigationItem.backBarButtonItem = backItem
//        self.navigationController?.navigationBar.barTintColor = UIColor.pieOrangeColor()
//        self.navigationController?.navigationBar.tintColor = UIColor.white
       
        //icono superior izquierdo del navigation controller
        /*let menuButton = UIButton()
        menuButton.setImage(UIImage(named: "icon-hamburguer"), for: .normal)
        menuButton.frame = CGRect(x: 0.0, y: 0.0, width: 40, height: 40)
        self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: menuButton), animated: true)*/
        
        //mostrar logo como título en el navigation controller
        let image = UIImage(named: "logo1-small.png")
//        self.navigationItem.titleView = UIImageView(image: image)
        
        if UIDevice.current.userInterfaceIdiom == .phone {
        navigationBar.topItem?.titleView = UIImageView(image: image)
        navigationBar.backgroundColor = UIColor.pieOrangeColor()
            
            /** Main buttons at the screen **/
            applicationButton.layer.cornerRadius = 5.0
            aboutButton.layer.cornerRadius       = 5.0
            contactButton.layer.cornerRadius     = 5.0
            applicationButton.setTitle(NSLocalizedString("applications", comment: "").uppercased(), for: .normal)
            aboutButton.setTitle(NSLocalizedString("about", comment: "").uppercased(), for: .normal)
            contactButton.setTitle(NSLocalizedString("contact", comment: "").uppercased(), for: .normal)
            
        } else {
            navBarPad.topItem?.titleView = UIImageView(image: image)
            navBarPad.backgroundColor = UIColor.pieOrangeColor()
            
            padAppButton.layer.cornerRadius = 5.0
            padAboutButton.layer.cornerRadius       = 5.0
            padContactButton.layer.cornerRadius     = 5.0
            padAppButton.setTitle(NSLocalizedString("applications", comment: "").uppercased(), for: .normal)
            padAboutButton.setTitle(NSLocalizedString("about", comment: "").uppercased(), for: .normal)
            padContactButton.setTitle(NSLocalizedString("contact", comment: "").uppercased(), for: .normal)
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "show_applications"?:
            
            if UIDevice.current.userInterfaceIdiom == .phone {
                presentButton = applicationButton
                dismissButton = applicationButton
            } else {
                presentButton = padAppButton
                dismissButton = padAppButton
            }
            let appController = segue.destination as! ApplicationsViewController
            appController.transitioningDelegate = self
            appController.modalPresentationStyle = .custom
            
        case "show_about"?:
            
            if UIDevice.current.userInterfaceIdiom == .phone {
                presentButton = aboutButton
                dismissButton = aboutButton
            } else {
                presentButton = padAboutButton
                dismissButton = padAboutButton
            }
            
            let appController = segue.destination as! AboutViewController
            appController.transitioningDelegate = self
            appController.modalPresentationStyle = .custom
            
        case "show_contact"?:
            if UIDevice.current.userInterfaceIdiom == .phone {
                presentButton = contactButton
                dismissButton = contactButton
            } else {
                presentButton = padContactButton
                dismissButton = padContactButton
            }
            let appController = segue.destination as! ContactViewController
            appController.transitioningDelegate = self
            appController.modalPresentationStyle = .custom
        default:
            return
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode   = .present
        transition.startingPoint    = presentButton.center
        transition.circleColor      = presentButton.backgroundColor!
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            transition.transitionMode   = .dismiss
            transition.startingPoint    = dismissButton.center
            transition.circleColor      = dismissButton.backgroundColor!
            
            return transition
    }
    
    
}
