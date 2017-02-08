//
//  Categories.swift
//  RappiTest
//
//  Created by Diego Leon on 2/7/17.
//  Copyright © 2017 Diego Leon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData

class Categories: NSObject {
    var entries:[Entry]?
    
    init(json:JSON) {
        if let response = json["entry"].array {
            for jsonEntries in response {
                let entry = Entry(json: jsonEntries)
                entries?.append(entry)
            }
        }
    }
    
    static func getCategories(completionClousure: @escaping (_ entries:[Entry]?) -> Void){
        Alamofire.request(Constants.BASE_URL).responseJSON { response in
           let categoryJson = JSON(response.result.value!)
           let category = categoryJson["feed"]
            
            var tempArray = [Entry]()
            
            if let responseReports = category["entry"].array{
                for attrs in responseReports{
                    let entry = Entry(json: attrs)
                    saveDb(entryObj: entry)
                    tempArray.append(entry)
                }
            }
            
           completionClousure(tempArray)
        }
    }
    
    static func saveDb(entryObj: Entry) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "EntryDB",in: managedContext)!
        
        
        let entry = NSManagedObject(entity: entity,insertInto: managedContext)
        entry.setValue(entryObj.name, forKeyPath: "name")
        entry.setValue(entryObj.category, forKey: "category")
        entry.setValue(entryObj.summary, forKey: "summary")
        entry.setValue(entryObj.urlImage, forKey: "image")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

}
