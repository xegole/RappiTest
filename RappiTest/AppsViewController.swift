//
//  AppsViewController.swift
//  RappiTest
//
//  Created by Diego Leon on 2/7/17.
//  Copyright © 2017 Diego Leon. All rights reserved.
//

import UIKit

class AppsViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    var entries = [Entry]()
    var apps = [Entry]()
    var entry:Entry?

    @IBOutlet weak var collectionApps: UICollectionView!
    let reuseIdentifier = "AppCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = entry?.category
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        self.collectionApps.dataSource = self
        self.collectionApps.delegate = self
        
        loadApps(entries: entries)
    }
    
    func loadApps(entries:[Entry]){
        for entryTemp in entries {
            if(entryTemp.category == entry?.category){
                apps.append(entryTemp)
            }
        }
        
        self.collectionApps.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.apps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell:AppCollectionViewCell = self.collectionApps.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier, for: indexPath) as! AppCollectionViewCell
        
        cell.labName.text = self.apps[indexPath.row].name
        let urlImage = self.apps[indexPath.row].urlImage
        
        if (urlImage != nil) {
            cell.imgApp.downloadedFrom(link: urlImage!)
        }
        
        cell.imgApp.layer.cornerRadius = cell.imgApp.frame.width/4.0
        cell.imgApp.layer.masksToBounds = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController:DetailAppViewController = storyboard.instantiateViewController(withIdentifier: "DetailAppViewController") as! DetailAppViewController
        
        viewController.entry = self.apps[indexPath.row]
        viewController.hidesBottomBarWhenPushed = true
        present(viewController, animated: true)
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.portrait
    }

}
