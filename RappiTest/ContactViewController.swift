//
//  ContactViewController.swift
//  RappiTest
//
//  Created by Jhon Villalobos on 9/25/16.
//  Copyright © 2016 Jhon Villalobos. All rights reserved.
//

import UIKit
import MessageUI

class ContactViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var containerViewContact: UIView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var instagramLabel: UILabel!
    @IBOutlet weak var linkedInLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //mostrar logo como título en el navigation controller
        let image = UIImage(named: "logo1-small.png")
        self.navigationItem.titleView = UIImageView(image: image)
        
        contactImage.image = UIImage(named: "icon-contact-clean")
        instagramLabel.text = NSLocalizedString("instagramText", comment: "")
        linkedInLabel.text = NSLocalizedString("linkedInText", comment: "")
        emailLabel.text = NSLocalizedString("email", comment: "")
        
        view.backgroundColor = UIColor.rappidGrayColor()
        containerViewContact.backgroundColor = UIColor.white
        containerViewContact.layer.cornerRadius = 10.0
        
        
        let gestureEmail = UITapGestureRecognizer(target: self, action: #selector(self.sendEmail))
        emailLabel.isUserInteractionEnabled = true
        emailLabel.addGestureRecognizer(gestureEmail)
        
        let gestureInstagram = UITapGestureRecognizer(target: self, action: #selector(self.openInstagram))
        instagramLabel.isUserInteractionEnabled = true
        instagramLabel.addGestureRecognizer(gestureInstagram)
     
        let gestureLinkedIn = UITapGestureRecognizer(target: self, action: #selector(self.openLinkedIn))
        linkedInLabel.isUserInteractionEnabled = true
        linkedInLabel.addGestureRecognizer(gestureLinkedIn)
        
        emailLabel.layer.borderColor = UIColor.rappidGrayColor().cgColor
        emailLabel.layer.borderWidth = 2.0
        emailLabel.layer.cornerRadius = 10.0
        
        instagramLabel.layer.borderColor = UIColor.rappidGrayColor().cgColor
        instagramLabel.layer.borderWidth = 2.0
        instagramLabel.layer.cornerRadius = 10.0
        
        linkedInLabel.layer.borderColor = UIColor.rappidGrayColor().cgColor
        linkedInLabel.layer.borderWidth = 2.0
        linkedInLabel.layer.cornerRadius = 10.0
    }
    
    func sendEmail() {
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        mail.setSubject(NSLocalizedString("subjectEmail", comment: ""))
        mail.setToRecipients([NSLocalizedString("email", comment: "")])
        present(mail, animated: true, completion: nil)
    }
    
    func openInstagram() {
        let instagramHooks = "instagram://user?username=villajhon"
        let instagramUrl = NSURL(string: instagramHooks)
        if UIApplication.shared.openURL(instagramUrl! as URL) {
            UIApplication.shared.openURL(instagramUrl! as URL)
        } else {
            UIApplication.shared.openURL(NSURL(string: NSLocalizedString("instagramLabel", comment: ""))! as URL)
        }
    }
    
    func openLinkedIn() {
        UIApplication.shared.openURL(NSURL(string: NSLocalizedString("instagramLabel", comment: ""))! as URL)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }

}