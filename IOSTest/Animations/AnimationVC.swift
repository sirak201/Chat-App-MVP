//
//  AnimationVC.swift
//  IOSTest
//
//  Created by Sirak Zeray on 10/29/19.
//  Copyright © 2019 Sirak Zeray. All rights reserved.
//

import UIKit

class AnimationVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var logoIV: UIImageView!
    
    
    
    
    
    
   //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Actions
    @IBAction func fadeIn(_ sender: Any) {
        // Fades in Logo
        logoIV.alpha = 0
        UIView.animate(withDuration: 2.5, animations: {
            self.logoIV.alpha = 1.0

        })

    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
