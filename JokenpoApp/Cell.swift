//
//  Cell.swift
//  JokenpoApp
//
//  Created by Josicleison on 09/09/22.
//

import UIKit

class Cell: UICollectionViewCell {
    
    let cellImageView = UIImageView()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        contentView.addSubview(cellImageView)
        
        cellImageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
