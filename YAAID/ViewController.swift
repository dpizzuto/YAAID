//
//  ViewController.swift
//  YAAID
//
//  Created by Dario Pizzuto on 01/05/17.
//  Copyright © 2017 Dario Pizzuto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.setImage(withUrl: "https://lh3.googleusercontent.com/3hPOYuONFX2KW9XE_RsV8J-F0xgZqmaBKb4tOsGZ_cQBxwM5Zcx10A1nOg0tHRwnJ8T2DtXw=w2880-h1516", filename: "testImage.jpg")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

