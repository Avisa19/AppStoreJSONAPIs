//
//  AppsRowCell.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 16/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

class AppsRowCell: UICollectionViewCell {
    
    var feedResult: FeedResult? {
        didSet {
            guard let feedResult = feedResult else { return }
            companyLabel.text = feedResult.artistName
            nameLabel.text = feedResult.name
            imageView.sd_setImage(with: URL(string: feedResult.artworkUrl100), completed: nil)
        }
    }
    
   private let imageView = UIImageView(cornerRadius: 12)
   private let nameLabel = UILabel(text: "App name", font: .systemFont(ofSize: 20))
   private let companyLabel = UILabel(text: "Company name", font: .systemFont(ofSize: 13))
   private let getButton = UIButton(title: "GET")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.constrainWidth(constant: 64)
        imageView.constrainHeight(constant: 64)
        
        getButton.constrainWidth(constant: 80)
        getButton.constrainHeight(constant: 32)
        
        let stackview = UIStackView(arrangedSubviews: [
            imageView,
            VerticalStackView(arrangedSubviews: [
                nameLabel,
                companyLabel
            ]),
            getButton
        ])
        
        addSubview(stackview)
        stackview.fillSuperview()
        stackview.alignment = .center
        stackview.spacing = 16
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
