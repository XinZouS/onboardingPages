//
//  ViewExtention.swift
//  onboardingPage
//
//  Created by Xin Zou on 1/23/17.
//  Copyright © 2017 Xin Zou. All rights reserved.
//

import UIKit


extension UIView {
    
    func anchorToTop(top: NSLayoutYAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil){
        anchorWithConstantsToTop(top: top, bottom: bottom, left: left, right: right, topConstant: 0, bottomConstant: 0, leftConstant: 0, rightConstant: 0)
    }
    
    func anchorWithConstantsToTop(top: NSLayoutYAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, bottomConstant: CGFloat = 0, leftConstant: CGFloat = 0, rightConstant: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false

        _ = anchor(top, left, bottom, right, topConstraint: topConstant, leftConstraint: leftConstant, bottomConstraint: bottomConstant, rightConstraint: rightConstant)
        
    }
    
    func anchor(_ top : NSLayoutYAxisAnchor? = nil,     _ left : NSLayoutXAxisAnchor? = nil,
                _ bottom: NSLayoutYAxisAnchor? = nil,   _ right: NSLayoutXAxisAnchor? = nil,
                topConstraint:  CGFloat = 0,    leftConstraint:CGFloat = 0,
                bottomConstraint:CGFloat = 0,   rightConstraint:CGFloat = 0,
                widthConstraint:CGFloat = 0,    heightConstraint:CGFloat = 0) -> [NSLayoutConstraint] {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstraint))
        }
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstraint))
        }
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstraint))
        }
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstraint))
        }
        if widthConstraint > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstraint))
        }
        if heightConstraint > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstraint))
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
    }
}

