//
//  frontButton.swift
//  FlightMe
//
//  Created by MIHAIL BUTNARU on 02/08/2017.
//  Copyright © 2017 MIHAIL BUTNARU. All rights reserved.
//

import UIKit

class frontButton: UIButton {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 6, options: .allowUserInteraction, animations:{
                        self.transform = CGAffineTransform.identity
        }, completion: nil)
        
        super.touchesBegan(touches, with: event)
    }
    
}

