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
            
            ratingLabel.text = "Rating: " +  "\(appResult.averageUserRating)"
            
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
    
    let appIconImageView: UIImageView = {
       let iv = UIImageView()
        iv.backgroundColor = .systemPink
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.constrainWidth(constant: 64)
        iv.constrainHeight(constant: 64)
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
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
            VerticalStackview(arrangedViews: [
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
   
        let overAllStackView = VerticalStackview(arrangedViews: [
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
