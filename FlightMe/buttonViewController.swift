//
//  buttonViewController.swift
//  FlightMe
//
//  Created by MIHAIL BUTNARU on 09/08/2017.
//  Copyright © 2017 MIHAIL BUTNARU. All rights reserved.
//

import UIKit

class buttonViewController: UIViewController {

    @IBOutlet weak var backButtonB: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButtonB.layer.cornerRadius = backButtonB.frame.size.width / 2

        
    }

    @IBAction func backButtonVC(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
