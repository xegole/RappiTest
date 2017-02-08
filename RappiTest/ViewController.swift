//
//  ViewController.swift
//  RappiTest
//
//  Created by Diego Leon on 2/7/17.
//  Copyright © 2017 Diego Leon. All rights reserved.
//

import UIKit
import Alamofire
import KVNProgress
import CoreData

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var categoriesList: UITableView!
    
    var entries = [Entry]()
    var categories = [Entry]()
    let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "title_categories".localized
        navigationController?.navigationBar.barTintColor = UIColor.gray
        
        if Reachability.isConnectedToNetwork() == true
        {
                    KVNProgress.show(withStatus: "categories".localized)
                    Categories.getCategories { (entries) in
                        self.entries = entries!
                        self.loadCategories(entries: entries!)
                        KVNProgress.showSuccess()
                        KVNProgress.dismiss()
                    }
        }
        else
        {
            let alert = UIAlertController(title: "dialog_title".localized, message: "dialog_message".localized, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "dialog_ok".localized, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            loadDb()
        }
        
        self.categoriesList.delegate = self
        self.categoriesList.dataSource = self
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func loadDb() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "EntryDB")
        do {
            let entriesDb = try managedContext.fetch(fetchRequest)
            
            for entryDb in entriesDb {
                let entry = Entry(db: entryDb)
                entries.append(entry)
            }
            
            loadCategories(entries: entries)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func loadCategories(entries:[Entry]){
        var count = 0
        for entry in entries {
            var exist = false
            while count < self.categories.count {
                let tempEntry = self.categories[count]
                
                if(tempEntry.category == entry.category){
                    exist = true
                }
                count = count + 1
            }
            
            if !exist{
                self.categories.append(entry)
            }
            
            count = 0
        }
        
        self.categoriesList.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:CategoryTableViewCell = self.categoriesList.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! CategoryTableViewCell
        
        cell.labCategory.text = self.categories[indexPath.row].category
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController:AppsViewController = storyboard.instantiateViewController(withIdentifier: "AppsViewController") as! AppsViewController
        
        viewController.entries = self.entries
        viewController.entry = self.categories[indexPath.row]
        viewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        let transformAnim = CATransform3DTranslate(CATransform3DIdentity, -250, 20, 0)
        cell.layer.transform = transformAnim
        
        UIView.animate(withDuration: 1.0) { 
            cell.alpha = 1.0
            cell.layer.transform = CATransform3DIdentity
        }
        
    }

}

