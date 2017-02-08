//
//  Entry.swift
//  RappiTest
//
//  Created by Diego Leon on 2/7/17.
//  Copyright © 2017 Diego Leon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData

class Entry: NSObject {
    var name:String?
    var category:String?
    var summary:String?
    var urlImage:String?
    
    init(json:JSON) {
        self.name = json["im:name"]["label"].string
        self.category = json["category"]["attributes"]["label"].string
        self.summary = json["summary"]["label"].string
        self.urlImage = json["im:image"].array?[2]["label"].string
    }
    
    init(db:NSManagedObject) {
        self.name = db.value(forKeyPath: "name") as? String
        self.category = db.value(forKeyPath: "category") as? String
        self.summary = db.value(forKeyPath: "summary") as? String
        self.urlImage = db.value(forKeyPath: "image") as? String
    }

}
