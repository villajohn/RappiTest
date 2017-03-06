//
//  AboutViewController.swift
//  RappiTest
//
//  Created by Jhon Villalobos on 9/25/16.
//  Copyright © 2016 Jhon Villalobos. All rights reserved.
//

import UIKit
import QuickLook

class AboutViewController: UIViewController, UIScrollViewDelegate, QLPreviewControllerDataSource {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var aboutMainTitle: UILabel!
    @IBOutlet weak var aboutTitle: UILabel!
    @IBOutlet weak var aboutContent: UITextView!
    @IBOutlet weak var aboutMeTitle: UILabel!
    @IBOutlet weak var aboutMeContent: UITextView!
    @IBOutlet weak var padAboutMeContent: UITextView!

    @IBOutlet weak var makingOfTitle: UILabel!
    
    @IBOutlet weak var aboutContainer: UIView!
    @IBOutlet weak var projectContainer: UIView!
    @IBOutlet weak var makingContainer: UIView!
    
    @IBOutlet weak var pictureOne: UIImageView!
    @IBOutlet weak var pictureTwo: UIImageView!
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var aboutProjectLabel: UILabel!
    @IBOutlet weak var aboutProjectDetail: UITextView!
    @IBOutlet weak var aboutProjectContainer: UIView!
    
    @IBOutlet weak var aboutMeLabel: UILabel!
    @IBOutlet weak var aboutMeContentPhone: UITextView!
    
    @IBOutlet weak var aboutMeContainer: UIView!
    @IBOutlet weak var makingOfPhoneLabel: UILabel!
    @IBOutlet weak var makingOfPhoneContainer: UIView!
    
    @IBOutlet weak var imageOnePhone: UIImageView!
    @IBOutlet weak var imageTwoPhone: UIImageView!
    @IBOutlet weak var btnClose: UIButton!
    
    
    let quickLookController = QLPreviewController()
    let fileNames = ["about1.jpg", "about2-1.jpg"]
    var fileURLs = [NSURL]()
    
    var gradientLayer: CAGradientLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.backgroundColor = UIColor.clear
        setupView()
        loadDetails()
        createGradientLayer()
        prepareFileURLs()
        quickLookController.dataSource = self
    }
    
    func setupView() {
        //mostrar logo como título en el navigation controller
        let image = UIImage(named: "logo1-small.png")
        self.navigationItem.titleView = UIImageView(image: image)
        
        pictureTwo.layer.cornerRadius       = 5.0
        pictureOne.layer.cornerRadius       = 5.0
        aboutContainer.layer.cornerRadius   = 10.0
        projectContainer.layer.cornerRadius = 10.0
        makingContainer.layer.cornerRadius  = 10.0
        
        aboutProjectContainer.layer.cornerRadius = 5.0
        
        closeButton.layer.cornerRadius = closeButton.frame.size.width / 2
        
        let gestureOne = UITapGestureRecognizer()
        gestureOne.addTarget(self, action: #selector(self.loadImage(sender:)))
        imageOnePhone.addGestureRecognizer(gestureOne)
        imageOnePhone.isUserInteractionEnabled = true
        
        let gestureTwo = UITapGestureRecognizer()
        gestureTwo.addTarget(self, action: #selector(self.loadImage(sender:)))
        imageTwoPhone.addGestureRecognizer(gestureTwo)
        imageTwoPhone.isUserInteractionEnabled = true
        
        btnClose.layer.cornerRadius = btnClose.frame.size.width / 2
        
    }
    
    func loadImage(sender: UITapGestureRecognizer) {
        switch sender.view?.restorationIdentifier {
            case "image1"?:
            if QLPreviewController.canPreview(self.fileURLs[0]) {
                quickLookController.currentPreviewItemIndex = 0
                present(quickLookController, animated: true)
            }
            case "image2"?:
                if QLPreviewController.canPreview(self.fileURLs[1]) {
                    quickLookController.currentPreviewItemIndex = 1
                    present(quickLookController, animated: true)
            }
            default:
                globalMessage(msgtitle: "", msgBody: "", delegate: nil, self: self)
        }
    }
    
    func loadDetails() {
        aboutMainTitle.text = NSLocalizedString("aboutTitle", comment: "").uppercased()
        aboutTitle.text = NSLocalizedString("aboutProject", comment: "").uppercased()
        aboutProjectLabel.text = NSLocalizedString("aboutProject", comment: "").uppercased()
        aboutProjectDetail.text = NSLocalizedString("aboutProjectContent", comment: "")
        aboutContent.text = NSLocalizedString("aboutProjectContent", comment: "")
        aboutMeTitle.text = NSLocalizedString("aboutMe", comment: "").uppercased()
        aboutMeContent.text = NSLocalizedString("aboutMeContent", comment: "")
        padAboutMeContent.text = NSLocalizedString("aboutMeContent", comment: "")
        makingOfTitle.text = NSLocalizedString("makingOf", comment: "").uppercased()
        
        aboutMeLabel.text = NSLocalizedString("aboutMe", comment: "").uppercased()
        aboutMeContentPhone.text = NSLocalizedString("aboutMeContent", comment: "")
        aboutMeContainer.layer.cornerRadius = 5.0
        
        makingOfPhoneLabel.text = NSLocalizedString("makingOf", comment: "").uppercased()
        makingOfPhoneContainer.layer.cornerRadius = 5.0
    }
    
    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.view.bounds
        
        gradientLayer.colors = [UIColor.pieOrangeColor().cgColor, UIColor.yellow.cgColor]
        
        self.view.layer.addSublayer(gradientLayer)
    }
    
    func prepareFileURLs() {
        for file in fileNames {
            let fileParts = file.components(separatedBy: ".")
            if let fileURL = Bundle.main.url(forResource: fileParts[0], withExtension: fileParts[1]) {
                if FileManager.default.fileExists(atPath: fileURL.path) {
                    fileURLs.append(fileURL as NSURL)
                }
            }
        }
    }
    
    //MARK : Quick Preview Delegate Methods
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return fileURLs.count
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return fileURLs[index]
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
