//
//  SearchAppCell.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 15/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

class SearchAppCell: UICollectionViewCell {
    
    var appResult: Result? {
        didSet {
            
            guard let appResult = appResult else { return }
            
            nameLabel.text = appResult.trackName
            
            categoryLabel.text = appResult.primaryGenreName
            
            guard let rating = appResult.averageUserRating else { return }
            ratingLabel.text = "Rating: " +  "\(rating)"
            
            appIconImageView.sd_setImage(with: URL(string: appResult.artworkUrl100))
            
            screenShot1ImageView.sd_setImage(with: URL(string: appResult.screenshotUrls[0]))
            
            if appResult.screenshotUrls.count > 1 {
                screenShot2ImageView.sd_setImage(with: URL(string: appResult.screenshotUrls[1]))
            }
            
            if appResult.screenshotUrls.count > 2 {
                screenShot3ImageView.sd_setImage(with: URL(string: appResult.screenshotUrls[2]))
            }
        }
    }
    
    let appIconImageView = UIImageView(cornerRadius: 12)
    
    let nameLabel = UILabel(text: "App Name", font: .systemFont(ofSize: 20))
    
    let categoryLabel = UILabel(text: "photos & videos", font: .systemFont(ofSize: 14))
    
    let ratingLabel = UILabel(text: "9.62M", font: .systemFont(ofSize: 14))
    
    let getButton = UIButton(title: "GET")
    
    lazy var screenShot1ImageView = self.createScreenShotImageView()
    
    lazy var screenShot2ImageView = self.createScreenShotImageView()
    
    lazy var screenShot3ImageView = self.createScreenShotImageView()
    
    
    func createScreenShotImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        
        appIconImageView.constrainWidth(constant: 64)
        appIconImageView.constrainHeight(constant: 64)
        
        getButton.constrainWidth(constant: 80)
        getButton.constrainHeight(constant: 32)
        
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
            VerticalStackView(arrangedSubviews: [
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
   
        let overAllStackView =  VerticalStackView(arrangedSubviews: [
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
