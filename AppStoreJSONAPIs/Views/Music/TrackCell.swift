//
//  TrackCell.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 25/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

class TrackCell: UICollectionViewCell {
    
    let imageView = UIImageView(cornerRadius: 16)
    let trackLabel = UILabel(text: "Track name", font: .boldSystemFont(ofSize: 18))
    let trackSubTitleLabel = UILabel(text: "Track subtitle, it's a little description about the music, that makes you more attractive.", font: .systemFont(ofSize: 16), numberOfLines: 2)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        imageView.backgroundColor = .systemGreen
        imageView.constrainWidth(constant: 80)
        imageView.constrainHeight(constant: 80)
        
        let stackview = UIStackView(arrangedSubViews: [
            imageView,
            VerticalStackView(arrangedSubviews: [
                trackLabel,
                trackSubTitleLabel
            ], spacing: 4)
        ], customSpacing: 16)
        
        addSubview(stackview)
        stackview.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        stackview.alignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
