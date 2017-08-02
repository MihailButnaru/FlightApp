//
//  frontButton.swift
//  FlightMe
//
//  Created by MIHAIL BUTNARU on 02/08/2017.
//  Copyright © 2017 MIHAIL BUTNARU. All rights reserved.
//

import UIKit

class frontButton: UIButton {
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.transform = CGAffineTransform(scaleX: 1.1, scaleY: 1.1)
            
            
            UIView.animateWithDuration(duration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: userInteractionEnabled, animations: {
            self.transform = CGAffineTransform.init()
            }, completion: nil)
        
        
    }
    
}

