//
//  SplashViewController.swift
//  RappiTest
//
//  Created by Jhon Villalobos on 9/24/16.
//  Copyright © 2016 Jhon Villalobos. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    var puslsing: Bool = false
    
    var backgroundGridView : BackgroundGridView!
    
    public init(fileName: String) {
        super.init(nibName: nil, bundle: nil)
        backgroundGridView = BackgroundGridView(FileName: fileName)
        view.addSubview(backgroundGridView)
        backgroundGridView.frame = view.bounds
        
        backgroundGridView.startAnimating()
        
        /*
        let imageContainer = UIImageView()
        imageContainer.image = UIImage(named: "logo1")
        imageContainer.frame = CGRect(x: 0, y:0, width: 200, height: 50)
        imageContainer.layer.position = view.center
        imageContainer.alpha = 0.0
        //imageContainer.center.x -= view.bounds.width //Si quieres colocar el logo outside the view
        view.addSubview(imageContainer)
        
        UIView.animate(withDuration: 1.5, delay: 0.4, options: .curveEaseOut, animations: {
            //imageContainer.center.x += self.view.bounds.width //si quieres mostrarlo con entrada
            imageContainer.alpha = 1.0
        })
        */
    }

    required public init(coder aDecoder: NSCoder) {
        fatalError(NSLocalizedString("error_initcoder", comment: ""))
    }


}
