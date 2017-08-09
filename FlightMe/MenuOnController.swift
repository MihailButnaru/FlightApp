//
//  MenuOnController.swift
//  FlightMe
//
//  Created by MIHAIL BUTNARU on 25/07/2017.
//  Copyright © 2017 MIHAIL BUTNARU. All rights reserved.
//
import UIKit

class MenuOnController: UIViewController {
    
    @IBOutlet weak var aboutButton: UIButton!
    
    @IBOutlet var backGroundMenu: UIImageView!
    
    let transition = CircularTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aboutButton.layer.cornerRadius = aboutButton.frame.size.width / 2
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let secondVC = segue.destination as! buttonViewController
//        secondVC.transitioningDelegate = self.aboutButton
        secondVC.modalPresentationStyle = .custom
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = aboutButton.center
        transition.circleColor = aboutButton.backgroundColor!
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = aboutButton.center
        transition.circleColor = aboutButton.backgroundColor!
        
        return transition
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}
