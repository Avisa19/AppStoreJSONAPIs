//
//  ReviewAndRatingCell.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 19/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

class ReviewAndRatingCell: UICollectionViewCell {
    
    let reviewLabel = UILabel(text: "Review title", font: .boldSystemFont(ofSize: 18))
    let authorLabel = UILabel(text: "Author", font: .systemFont(ofSize: 16))
    let starsLabel = UILabel(text: "★", font: .systemFont(ofSize: 20))

    let bodyLabel = UILabel(text: "Body label\nBody label\nBody label\nBody label\n", font: .systemFont(ofSize: 16), numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = #colorLiteral(red: 0.9430938363, green: 0.9399930239, blue: 0.9734050632, alpha: 1)
        authorLabel.textColor = .gray
        starsLabel.textColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        layer.cornerRadius = 16
        clipsToBounds = true
        
        let stackview = VerticalStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [
                reviewLabel,
                UIView(),
                authorLabel
            ]),
            starsLabel,
            bodyLabel,
            UIView()
        ], spacing: 12)
        
        addSubview(stackview)
        stackview.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
