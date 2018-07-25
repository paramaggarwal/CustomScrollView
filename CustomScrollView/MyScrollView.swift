//
//  MyScrollView.swift
//  CustomScrollView
//
//  Created by Param Aggarwal on 25/07/18.
//  Copyright © 2018 Param Aggarwal. All rights reserved.
//

import UIKit

class MyScrollView: UIView {

    var contentSize: CGSize?
    var scrollHorizontal: Bool?
    var scrollVertical: Bool?
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.scrollVertical = true;
        self.scrollHorizontal = true;
        
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        self.addGestureRecognizer(gestureRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // Translate the view's bounds, but do not permit values that would violate contentSize
    @objc func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) -> Void {
        let translation = gestureRecognizer.translation(in: self)
        var bounds = self.bounds
        
        if self.scrollHorizontal! {
            let newBoundsOriginX = bounds.origin.x - translation.x
            let minBoundsOriginX = CGFloat(0.0)
            let maxBoundsOriginX = self.contentSize!.width - bounds.size.width
            bounds.origin.x = fmax(minBoundsOriginX, fmin(newBoundsOriginX, maxBoundsOriginX))
        }
        
        if self.scrollVertical! {
            let newBoundsOriginY = bounds.origin.y - translation.y
            let minBoundsOriginY = CGFloat(0.0)
            let maxBoundsOriginY = self.contentSize!.height - bounds.size.height
            bounds.origin.y = fmax(minBoundsOriginY, fmin(newBoundsOriginY, maxBoundsOriginY))
        }
        
        self.bounds = bounds
        gestureRecognizer.setTranslation(.zero, in: self)
    }
}
