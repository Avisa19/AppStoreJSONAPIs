//
//  ReviewCell.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 19/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell {
    
    let reviewLabel = UILabel(text: "Reviews & Ratings", font: .boldSystemFont(ofSize: 24))
    
    let reviewController = ReviewRowController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(reviewLabel)
        reviewLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 0))
        addSubview(reviewController.view)
        reviewController.view.anchor(top: reviewLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
