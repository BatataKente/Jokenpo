//
//  UIViewExtension.swift
//  JokenpoApp
//
//  Created by Josicleison on 09/09/22.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: [UIView]) {
        
        for view in views {
            
            self.addSubview(view)
        }
    }
    
    func fillSuperview() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.topAnchor.constraint(equalTo: superview?.topAnchor ?? NSLayoutYAxisAnchor()).isActive = true
        self.leadingAnchor.constraint(equalTo: superview?.leadingAnchor ?? NSLayoutXAxisAnchor()).isActive = true
        self.trailingAnchor.constraint(equalTo: superview?.trailingAnchor ?? NSLayoutXAxisAnchor()).isActive = true
        self.bottomAnchor.constraint(equalTo: superview?.bottomAnchor ?? NSLayoutYAxisAnchor()).isActive = true
    }
    
    func constraint(to view: Any?,
                    by attributes: [NSLayoutConstraint.Attribute : NSLayoutConstraint.Attribute],
                    relatedBy: NSLayoutConstraint.Relation = .equal,
                    multiplier: CGFloat = 1,
                    constant: CGFloat = 0) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        for attribute in attributes {
            
            superview?.addConstraint(NSLayoutConstraint(item: self,
                                                        attribute: attribute.key,
                                                        relatedBy: .equal,
                                                        toItem: view,
                                                        attribute: attribute.value,
                                                        multiplier: 1,
                                                        constant: constant))
        }
    }
    
    func align(to view: Any?,_ constant: CGFloat = 0) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        superview?.addConstraints([
        
            NSLayoutConstraint(item: self,
                               attribute: .leading,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .leading,
                               multiplier: 1,
                               constant: constant),
            NSLayoutConstraint(item: self,
                               attribute: .trailing,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .trailing,
                               multiplier: 1,
                               constant: -constant)
        ])
    }
    
    func height(by constant: CGFloat) {
        
        self.heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
}
