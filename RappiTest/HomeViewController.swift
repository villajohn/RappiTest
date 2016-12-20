//
//  HomeViewController.swift
//  RappiTest
//
//  Created by Jhon Villalobos on 9/25/16.
//  Copyright © 2016 Jhon Villalobos. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var aboutButton: UIButton!
    @IBOutlet weak var applicationButton: UIButton!
    @IBOutlet weak var contactButton: UIButton!
    @IBOutlet weak var applicationLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!

    @IBOutlet weak var appLblBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var abtLblBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var cntLblBottomConstraint: NSLayoutConstraint!
    
    override func viewWillAppear(_ animated: Bool) {
        aboutButton.alpha       = 0.0
        aboutLabel.alpha        = 0.0
        applicationButton.alpha = 0.0
        applicationLabel.alpha  = 0.0
        contactButton.alpha     = 0.0
        contactLabel.alpha      = 0.0
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView() {
        
        view.backgroundColor = UIColor.rappidGrayColor()
        
        /** Navigation bar **/
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.navigationBar.barTintColor = UIColor.pieOrangeColor()
        self.navigationController?.navigationBar.tintColor = UIColor.white
       
        //icono superior izquierdo del navigation controller
        /*let menuButton = UIButton()
        menuButton.setImage(UIImage(named: "icon-hamburguer"), for: .normal)
        menuButton.frame = CGRect(x: 0.0, y: 0.0, width: 40, height: 40)
        self.navigationItem.setLeftBarButton(UIBarButtonItem(customView: menuButton), animated: true)*/
        
        //mostrar logo como título en el navigation controller
        let image = UIImage(named: "logo1-small.png")
        self.navigationItem.titleView = UIImageView(image: image)
        
        /** Main buttons at the screen **/
        //Image when a button is pressed
        aboutButton.setImage(UIImage(named: "icon-about-pressed"), for: .highlighted)
        applicationButton.setImage(UIImage(named: "icon-application-pressed"), for: .highlighted)
        contactButton.setImage(UIImage(named: "icon-contact-pressed"), for: .highlighted)
        
        
        //methods for each button
        aboutButton.addTarget(self, action: #selector(self.mainButtonPressed(_:)), for: .touchDown)
        aboutButton.addTarget(self, action: #selector(self.mainButtonReleased(_:)), for: .touchUpInside)
        
        applicationButton.addTarget(self, action: #selector(self.mainButtonPressed(_:)), for: .touchDown)
        applicationButton.addTarget(self, action: #selector(self.mainButtonReleased(_:)), for: .touchUpInside)
        
        contactButton.addTarget(self, action: #selector(self.mainButtonPressed(_:)), for: .touchDown)
        contactButton.addTarget(self, action: #selector(self.mainButtonReleased(_:)), for: .touchUpInside)
        
        //labels for buttons
        applicationLabel.text = NSLocalizedString("applications", comment: "") 
        aboutLabel.text       = NSLocalizedString("about", comment: "")
        contactLabel.text     = NSLocalizedString("contact", comment: "")
    }
    
    func mainButtonPressed(_ sender: UIButton) {
        switch sender {
        case applicationButton:
            UIView.animate(withDuration: 0.1, animations: {
                self.appLblBottomConstraint.constant = -36
                self.applicationLabel.textColor = UIColor.rappidGrayColor()
            })
            
        case aboutButton:
            UIView.animate(withDuration: 0.1, animations: {
                self.abtLblBottomConstraint.constant = -36
                self.aboutLabel.textColor = UIColor.rappidGrayColor()
            })
        case contactButton:
            UIView.animate(withDuration: 0.1, animations: {
                self.cntLblBottomConstraint.constant = -36
                self.contactLabel.textColor = UIColor.rappidGrayColor()
            })
        default:
            return
        }
    }
    
    func mainButtonReleased(_ sender: UIButton) {
        switch sender {
        case applicationButton:
            self.appLblBottomConstraint.constant = self.appLblBottomConstraint.constant - 10
            self.applicationLabel.textColor = UIColor.black
        case aboutButton:
            self.abtLblBottomConstraint.constant = self.abtLblBottomConstraint.constant - 10
            self.aboutLabel.textColor = UIColor.black
        case contactButton:
            self.cntLblBottomConstraint.constant = self.cntLblBottomConstraint.constant - 10
            self.contactLabel.textColor = UIColor.black
        default:
            return
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "show_applications"?:
            print()
        default:
            return
        }
    }
    
}
