//
//  DetailAppViewController.swift
//  RappiTest
//
//  Created by Diego Leon on 2/7/17.
//  Copyright © 2017 Diego Leon. All rights reserved.
//

import UIKit

class DetailAppViewController: UIViewController {
    var entry:Entry?
    @IBOutlet weak var imgApp: UIImageView!
    @IBOutlet weak var labSummary: UITextView!
    @IBOutlet weak var labTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.labTitle.text = entry?.name
        let urlImage = entry?.urlImage
        if (urlImage != nil) {
            self.imgApp.downloadedFrom(link: urlImage!)
        }
        self.labSummary.text = entry?.summary
        
        self.imgApp.layer.cornerRadius = self.imgApp.frame.width/4.0
        self.imgApp.layer.masksToBounds = true
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionClose(_:))))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func actionClose(_ tap: UITapGestureRecognizer) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
