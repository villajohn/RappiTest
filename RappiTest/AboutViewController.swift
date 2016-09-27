//
//  AboutViewController.swift
//  RappiTest
//
//  Created by Jhon Villalobos on 9/25/16.
//  Copyright © 2016 Jhon Villalobos. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var aboutMainTitle: UILabel!
    @IBOutlet weak var aboutTitle: UILabel!
    @IBOutlet weak var aboutContent: UITextView!
    @IBOutlet weak var aboutMeTitle: UILabel!
    @IBOutlet weak var aboutMeContent: UITextView!

    @IBOutlet weak var makingOfTitle: UILabel!
    
    @IBOutlet weak var aboutContainer: UIView!
    @IBOutlet weak var projectContainer: UIView!
    @IBOutlet weak var makingContainer: UIView!
    
    @IBOutlet weak var pictureOne: UIImageView!
    @IBOutlet weak var pictureTwo: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.backgroundColor = UIColor.rappidGrayColor()
        setupView()
        loadDetails()
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
    }
    
    func loadDetails() {
        aboutMainTitle.text = NSLocalizedString("aboutTitle", comment: "")
        aboutTitle.text = NSLocalizedString("aboutProject", comment: "")
        aboutContent.text = NSLocalizedString("aboutProjectContent", comment: "")
        aboutMeTitle.text = NSLocalizedString("aboutMe", comment: "")
        aboutMeContent.text = NSLocalizedString("aboutMeContent", comment: "")
        makingOfTitle.text = NSLocalizedString("makingOf", comment: "")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
