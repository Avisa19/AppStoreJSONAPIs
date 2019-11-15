//
//  SearchAppCell.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 15/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

class SearchAppCell: UICollectionViewCell {
    
    let appIconImageView: UIImageView = {
       let iv = UIImageView()
        iv.backgroundColor = .systemPink
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.constrainWidth(constant: 64)
        iv.constrainHeight(constant: 64)
        iv.layer.cornerRadius = 12
        return iv
    }()
    
    let nameLabel: UILabel = {
       let label = UILabel()
        label.text = "Appa Name"
        return label
    }()
    
    let categoryLabel: UILabel = {
       let label = UILabel()
        label.text = "photos & videos"
        return label
    }()
    
    let ratingLabel: UILabel = {
       let label = UILabel()
        label.text = "9.62M"
        return label
    }()
    
    let getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
        button.constrainWidth(constant: 80)
        button.constrainHeight(constant: 32)
        button.layer.cornerRadius = 16
        return button
    }()
    
    lazy var screenShot1ImageView = self.createScreenShotImageView()
    
    lazy var screenShot2ImageView = self.createScreenShotImageView()
    
    lazy var screenShot3ImageView = self.createScreenShotImageView()
    
    
    func createScreenShotImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemBlue
        return imageView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        
        // screenshot Stackview
      
        let screenShotStackViews = UIStackView(arrangedSubviews: [
            screenShot1ImageView,
            screenShot2ImageView,
            screenShot3ImageView
        ])
        
        addSubview(screenShotStackViews)
        
        screenShotStackViews.distribution = .fillEqually
        screenShotStackViews.spacing = 12
       
        // info Top Stackview
       
        let infoTopStackView = UIStackView(arrangedSubviews: [
            appIconImageView,
            VerticlStackView(arrangedViews: [
                nameLabel,
                categoryLabel,
                ratingLabel
            ]),
            getButton
        ])
        // everythings is going to be centered inside stackView.
        infoTopStackView.alignment = .center
        addSubview(infoTopStackView)
        infoTopStackView.spacing = 12
        
        // overAll Stackview
   
        let overAllStackView = VerticlStackView(arrangedViews: [
            infoTopStackView,
            screenShotStackViews
        ], spacing: 16)
        
        addSubview(overAllStackView)
        
        overAllStackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
