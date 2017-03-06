//
//  ApplicationsViewController.swift
//  RappiTest
//
//  Created by Jhon Villalobos on 9/25/16.
//  Copyright © 2016 Jhon Villalobos. All rights reserved.
//

import UIKit
import SwiftSpinner
import KeychainAccess

class ApplicationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var refreshControl: UIRefreshControl!

    var appList = [Application]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var padDismissButton: UIButton!
    
    let searchController = UISearchController(searchResultsController: nil)
    var filteredItems = [Application]()
    
    var interactionController: UIPercentDrivenInteractiveTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SwiftSpinner.show("")
        loadTable()
        loadRefreshControl()
        setupView()
    }
    
    func setupView() {
        tableView.backgroundColor = UIColor.rappiGreenColor()
        self.view.backgroundColor = UIColor.rappiGreenColor()
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        //Search functions
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.barStyle = UIBarStyle.default
        tableView.tableHeaderView = searchController.searchBar
        
        //mostrar logo como título en el navigation controller
        let image = UIImage(named: "logo1-small.png")
        self.navigationItem.titleView = UIImageView(image: image)
        
        collectionView.backgroundColor = UIColor.rappidGrayColor()
        
        backButton.layer.cornerRadius = backButton.frame.size.width / 2
        backButton.setTitleColor(UIColor.white, for: .normal)
        backButton.setTitle("<", for: .normal)
        backButton.backgroundColor = UIColor.pieOrangeColor()
        
        padDismissButton.layer.cornerRadius = padDismissButton.frame.size.width / 2
        
    }
    
    
    //MAR: Table Delegates
    func refreshtable() {
        if UIDevice.current.userInterfaceIdiom == .phone {
            tableView.delegate   = self
            tableView.dataSource = self
            tableView.reloadData()
        } else {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.reloadData()
        }
        SwiftSpinner.hide()
        refreshControl.endRefreshing()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numSections = 0
        if (self.appList.count > 0) {
            numSections = 1
        } else {
            let noDataLabel: UILabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: self.tableView.bounds.size.height))
            noDataLabel.text = NSLocalizedString("noResultsFound", comment: "")
            noDataLabel.numberOfLines = 1
            noDataLabel.textColor = UIColor.white
            noDataLabel.textAlignment = .center
            tableView.backgroundView = noDataLabel
            tableView.separatorStyle = .none
        }
        return numSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredItems.count
        }
        return appList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_application") as! ApplicationsViewCell
        
        cell.tag = indexPath.row
        //let item = appList[indexPath.row]
        let item: Application
        if searchController.isActive && searchController.searchBar.text != "" {
            item = filteredItems[indexPath.row]
        } else {
            item = appList[indexPath.row]
        }
        
        cell.nameLabel.text = item.name
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            cell.developerLabel.isHidden = true
            cell.categorylabel.isHidden = true
            cell.releaseLabel.isHidden = true
        } else {
            cell.developerLabel.text = item.owner!
            cell.categorylabel.text  = item.category!
            cell.releaseLabel.text   = item.realeaseDate
        }
        
        cell.priceLabel.text     = (Double(item.price!) == 0 ? "Free" : "\(item.price!) \(item.currency!)")
        
        let url = NSURL(string: item.icon!)
        let networkService = NetworkServices(url: url!)
        networkService.downloadImage { (imageData) in
            let image = UIImage(data: imageData as Data)
            DispatchQueue.main.async(execute: {
                cell.pictureView?.image = image
                cell.backgroundImage.image = image
                cell.backgroundImage.contentMode = .scaleAspectFill
            })
        }
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*
         let detail = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
         if filteredItems.count > 0 {
         detail.appDetail = filteredItems[indexPath.row]
         } else {
         let tal = appList[indexPath.row]
         detail.appDetail = tal
         }
         self.navigationController?.present(detail, animated: true)*/
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if filteredItems.count == 0 {
            //1. Estado inicial de la celda
            cell.alpha = 0
            
            let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 20, 0)
            cell.layer.transform = transform
            
            //2. animación para mostrar la celda
            UIView.animate(withDuration: 0.5, animations: {
                cell.alpha = 1.0
                cell.layer.transform = CATransform3DIdentity
            }) 
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredItems = appList.filter { app in
            return app.name!.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    func saveApp(record: Application) {
 
    }
    
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath as IndexPath) as! AppsCollectionCell
        
        let item = appList[indexPath.row]
        
        roundedPictureWithout(sender: cell.iconAppCollection, color: UIColor.white)
        
        cell.titleAppCollection.text = item.name
        let url = NSURL(string: item.icon!)
        let networkService = NetworkServices(url: url!)
        networkService.downloadImage { (imageData) in
            let image = UIImage(data: imageData as Data)
            DispatchQueue.main.async(execute: {
                cell.iconAppCollection.image = image
            })
        }
        
        return cell
    }
    
    func warnUserAboutNetwork() {
        let alert: UIAlertController = UIAlertController()
        alert.title = NSLocalizedString("app_name", comment: "")
        alert.message = NSLocalizedString("noNetwork", comment: "")
        let close   = UIAlertAction(title: NSLocalizedString("no", comment: ""), style: .cancel, handler: { (action) -> Void in })
        let action  = UIAlertAction(title: NSLocalizedString("yes", comment: ""), style: .default, handler: {
            (action) -> Void in
            
            DispatchQueue.main.async(execute: {
                self.appList = getAppsStored()
                self.refreshtable()
            })
        })
        alert.addAction(close)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func loadRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = UIColor.rappiGreenColor()
        refreshControl.attributedTitle = NSAttributedString(string: NSLocalizedString("pullMessage", comment: ""))
        refreshControl.addTarget(self, action: #selector(self.loadTable), for: .valueChanged)
        self.tableView.addSubview(refreshControl)
    }
    
    func loadTable() {
        
        DispatchQueue.main.async(execute: {
            if connectedToNetwork() {
                self.appList = Application.downloadApplications()
                self.refreshtable()
            } else {
                self.warnUserAboutNetwork()
            }
        })
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func padBackAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension ApplicationsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
