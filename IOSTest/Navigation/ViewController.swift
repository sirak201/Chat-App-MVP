//
//  ViewController.swift
//  IOSTest
//
//  Created by Sirak Zeray on 10/29/19.
//  Copyright © 2019 Sirak Zeray. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet var holderView: [UIView]!

    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
   
        roundViews()
    }

    //MARK: Functions
    
    /// Function that rounds the corner of the container views
    fileprivate func roundViews() {
        for view in holderView {
            view.layer.cornerRadius = 8
            view.layer.masksToBounds = true
        }
    }

}

