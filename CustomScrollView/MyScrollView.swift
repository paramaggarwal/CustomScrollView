//
//  MyScrollView.swift
//  CustomScrollView
//
//  Created by Param Aggarwal on 25/07/18.
//  Copyright © 2018 Param Aggarwal. All rights reserved.
//

import UIKit
import pop

class MyScrollView: UIView {

    var contentSize: CGSize
    var scrollHorizontal: Bool
    var scrollVertical: Bool
    
    private var startBounds: CGRect

    override init(frame: CGRect) {
        self.startBounds = CGRect.zero

        self.contentSize = CGSize.zero
        self.scrollVertical = true
        self.scrollHorizontal = true
        
        super.init(frame: frame)

        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        self.addGestureRecognizer(gestureRecognizer)
        
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.startBounds = CGRect.zero
        
        self.contentSize = CGSize.zero
        self.scrollVertical = true
        self.scrollHorizontal = true
        
        super.init(coder: aDecoder)
    }

    // Translate the view's bounds, but do not permit values that would violate contentSize
    @objc func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) -> Void {
        switch gestureRecognizer.state {
        case .began:
            self.pop_removeAnimation(forKey: "decelerate")
            self.startBounds = self.bounds
            break
        case .changed:
            let translation = gestureRecognizer.translation(in: self)
            var bounds = self.startBounds
            
            if self.scrollHorizontal {
                let newBoundsOriginX = bounds.origin.x - translation.x
                let minBoundsOriginX = CGFloat(0.0)
                let maxBoundsOriginX = self.contentSize.width - bounds.size.width
                bounds.origin.x = fmax(minBoundsOriginX, fmin(newBoundsOriginX, maxBoundsOriginX))
            }
            
            if self.scrollVertical {
                let newBoundsOriginY = bounds.origin.y - translation.y
                let minBoundsOriginY = CGFloat(0.0)
                let maxBoundsOriginY = self.contentSize.height - bounds.size.height
                bounds.origin.y = fmax(minBoundsOriginY, fmin(newBoundsOriginY, maxBoundsOriginY))
            }
            
            self.bounds = bounds
            break
        case .ended:
            var velocity = gestureRecognizer.velocity(in: self)
            
            if self.bounds.size.width >= self.contentSize.width {
                velocity.x = 0
            }

            if self.bounds.size.height >= self.contentSize.height {
                velocity.y = 0
            }
            
            velocity.x = -velocity.x;
            velocity.y = -velocity.y;

            let decayAnimation = POPDecayAnimation.init(propertyNamed: kPOPViewBounds);
            decayAnimation?.clampMode = POPAnimationClampFlags.both.rawValue
            
            let prop = POPAnimatableProperty.property(withName: "com.rounak.bounds") { prop in
                guard let prop = prop else {
                    return
                }
                
                // read value
                prop.readBlock = { obj, values in
                    guard let obj = obj as? UIView, let values = values else {
                        return
                    }
                    
                    values[0] = obj.bounds.origin.x
                    values[1] = obj.bounds.origin.y
                }
                
                // write value
                prop.writeBlock = { obj, values in
                    guard let obj = obj as? UIView, let values = values else {
                        return
                    }
                    
                    var tempBounds = obj.bounds
                    tempBounds.origin.x = values[0]
                    tempBounds.origin.y = values[1]
                    obj.bounds = tempBounds
                }
                
                // dynamics threshold
                prop.threshold = 0.01;
            }
            
            decayAnimation?.property = prop as! POPAnimatableProperty;
            decayAnimation?.velocity = NSValue.init(cgPoint: velocity)
            self.pop_add(decayAnimation, forKey: "decelerate")
        default:
            break
        }
    }
}
