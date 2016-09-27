//
//  DetailViewController.swift
//  RappiTest
//
//  Created by Jhon Villalobos on 9/25/16.
//  Copyright © 2016 Jhon Villalobos. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var appDetail : Application!
    
    @IBOutlet weak var appPicture: UIImageView!
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var appOwner: UILabel!
    @IBOutlet weak var appCategory: UILabel!
    @IBOutlet weak var appRights: UILabel!
    @IBOutlet weak var appReleaseDate: UILabel!
    @IBOutlet weak var appPrice: UILabel!
    @IBOutlet weak var summaryText: UITextView!
    @IBOutlet weak var detailContainer: UIView!

    @IBOutlet weak var topLandscapeContainer: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var sharBtn: UIButton!
    
    @IBOutlet weak var sAppPicture: UIImageView!
    @IBOutlet weak var sAppName: UILabel!
    @IBOutlet weak var sAppOwner: UILabel!
    @IBOutlet weak var sAppCategory: UILabel!
    @IBOutlet weak var sAppRights: UILabel!
    @IBOutlet weak var sAppRelease: UILabel!
    @IBOutlet weak var sAppPrice: UILabel!
    @IBOutlet weak var sSummaryText: UITextView!
    @IBOutlet weak var sDetailContainer: UIView!
    
    
    var rootViewController: ApplicationsViewController!
    
    override func viewWillAppear(_ animated: Bool) {
        appPrice.textColor = UIColor.white
        
        if UI_USER_INTERFACE_IDIOM() == .pad {
            loadViewpad()
            loadDetailsPad()
        } else {
            loadViewPhone()
            loadDetailsPhone()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    func loadViewpad() {
        detailContainer.layer.cornerRadius = 10.0
        
        appPrice.layer.borderWidth   = 1
        appPrice.layer.masksToBounds = false
        appPrice.layer.borderColor   = UIColor.rappiGreenColor().cgColor
        appPrice.layer.cornerRadius  = (appPrice.frame.height)/2
        appPrice.clipsToBounds       = true
        appPrice.backgroundColor     = UIColor.rappiGreenColor()
        
        roundedPictureWithout(sender: appPicture, color: UIColor.white)
    }
    
    func loadViewPhone() {
        sDetailContainer.layer.cornerRadius = 10.0
        
        roundedPictureWithout(sender: sAppPicture, color: UIColor.white)
        
        sAppPrice.layer.borderWidth   = 1
        sAppPrice.layer.masksToBounds = false
        sAppPrice.layer.borderColor   = UIColor.rappiGreenColor().cgColor
        sAppPrice.layer.cornerRadius  = (sAppPrice.frame.height)/2
        sAppPrice.clipsToBounds       = true
        sAppPrice.backgroundColor     = UIColor.rappiGreenColor()
    }
    
    func setupView() {
        view.backgroundColor = UIColor.rappidGrayColor()
        /** Navigation bar **/
        //mostrar logo como título en el navigation controller
        let image = UIImage(named: "logo1-small.png")
        self.navigationItem.titleView = UIImageView(image: image)

        closeBtn.setImage(UIImage(named: "close-button-pressed"), for: .highlighted)
        sharBtn.setImage(UIImage(named: "share-button-pressed"), for: .highlighted)
        
        topLandscapeContainer.layer.borderWidth = 1.0
        topLandscapeContainer.layer.cornerRadius = 5.0
    }

    func loadDetailsPhone() {
        let url = NSURL(string: appDetail.icon?[2]["label"] as! String)
        let networkService = NetworkServices(url: url!)
        networkService.downloadImage { (imageData) in
            let image = UIImage(data: imageData as Data)
            DispatchQueue.main.async(execute: {
                self.sAppPicture.image = image
            })
        }
        
        sAppName.text        = appDetail.name
        sAppOwner.text       = appDetail.owner?["label"] as? String
        sAppCategory.text    = appDetail.category?["label"] as? String
        sAppRights.text      = appDetail.rights
        sAppRelease.text     = appDetail.realeaseDate
        sSummaryText.text    = appDetail.summary
        sAppPrice.text       = (Double(appDetail.price?["amount"] as! String) == 0 ? "Free" : "\(appDetail.price?["amount"]) \(appDetail.price?["currency"])")
    }
    
    func loadDetailsPad() {
        let url = NSURL(string: appDetail.icon?[2]["label"] as! String)
        let networkService = NetworkServices(url: url!)
        networkService.downloadImage { (imageData) in
            let image = UIImage(data: imageData as Data)
            DispatchQueue.main.async(execute: {
                self.appPicture.image = image
            })
        }
        
        appName.text        = appDetail.name
        appOwner.text       = appDetail.owner?["label"] as? String
        appCategory.text    = appDetail.category?["label"] as? String
        appRights.text      = appDetail.rights
        appReleaseDate.text = appDetail.realeaseDate
        summaryText.text    = appDetail.summary
        appPrice.text       = (Double(appDetail.price?["amount"] as! String) == 0 ? "Free" : "\(appDetail.price?["amount"]) \(appDetail.price?["currency"])")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func dismiss(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didPanDown(_ sender: UIPanGestureRecognizer) {
        let progress = sender.translation(in: self.view).y/self.view.frame.size.height
        
        switch sender.state {
        case .began:
            self.rootViewController.interactionController = UIPercentDrivenInteractiveTransition()
            self.dismiss(animated: true, completion: nil)
        case .changed:
            self.rootViewController.interactionController?.update(progress)
        case .ended:
            if progress >= 0.5 {
                self.rootViewController.interactionController?.finish()
            } else {
                self.rootViewController.interactionController?.cancel()
            }
            
            self.rootViewController.interactionController = nil
        default:
            self.rootViewController.interactionController?.cancel()
            self.rootViewController.interactionController = nil
        }
    }
    
    @IBAction func shareDetail(_ sender: AnyObject) {
        let shareContent = String(format: NSLocalizedString("shareAppMessage", comment: ""), appName.text!, (appDetail.link?["href"] as? String)!)
        let activityViewController = UIActivityViewController(activityItems: [shareContent as NSString, appPicture.image! as UIImage], applicationActivities: nil)
        present(activityViewController, animated: true, completion: {})
    }

}
