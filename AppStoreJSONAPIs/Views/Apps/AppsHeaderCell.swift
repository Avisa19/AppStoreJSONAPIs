//
//  AppsHeaderCell.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 16/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit
import SDWebImage

class AppsHeaderCell: UICollectionViewCell {
    
    var feedResult: FeedResult? {
        didSet {
            guard let feedResult = feedResult else { return }
            companyLabel.text = feedResult.artistName
            titleLabel.text = feedResult.name
            imageView.sd_setImage(with: URL(string: feedResult.artworkUrl100), completed: nil)
        }
    }
    
    let companyLabel = UILabel(text: "Facebook", font: .boldSystemFont(ofSize: 12))
    
    let titleLabel = UILabel(text: "Keeping up with friends faster than ever.", font: .systemFont(ofSize: 24))
    
    let imageView = UIImageView(cornerRadius: 8)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        companyLabel.textColor = .systemBlue
        titleLabel.numberOfLines = 2
        imageView.backgroundColor = .systemPink
        
        let verticalStackView = VerticalStackView(arrangedSubviews: [
            companyLabel,
            titleLabel,
            imageView
        ], spacing: 12)
        
        // it's very important point
        // here the size of stackview in the cell
        // we should reSize the cell so we go to VC and will change it.
        addSubview(verticalStackView)
        verticalStackView.fillSuperview(padding: .init(top: 16, left: 0, bottom: 0, right: 0))
  
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
