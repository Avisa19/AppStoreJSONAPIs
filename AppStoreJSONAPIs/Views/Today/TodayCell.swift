//
//  TodayCell.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 21/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

class TodayCell: UICollectionViewCell {
    
    var todayItem: TodayItem? {
        didSet {
            guard let todayItem = todayItem else { return }
            categoryLabel.text = todayItem.category
            titleLabel.text = todayItem.title
            imageview.image = todayItem.image
            descriptionLabel.text = todayItem.description
            backgroundColor = todayItem.backgroundColor
        }
    }
    
    let categoryLabel = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 20))
    let titleLabel = UILabel(text: "Utilizing your Time", font: .boldSystemFont(ofSize: 28))
    
    let imageview = UIImageView(image: #imageLiteral(resourceName: "garden"))

    let descriptionLabel = UILabel(text: "All the tools and apps you need to intelligently organize your life the right way.", font: .systemFont(ofSize: 16), numberOfLines: 3)
    
    var topConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 16
        clipsToBounds = true
        
        imageview.contentMode = .scaleAspectFill
        
        // imageview it takes a lot of space.
        let containerImageView = UIView()
        containerImageView.addSubview(imageview)
        imageview.centerInSuperview(size: .init(width: 240, height: 240))
        
        let stackview = VerticalStackView(arrangedSubviews: [
            categoryLabel,
            titleLabel,
            containerImageView,
            descriptionLabel
        ], spacing: 8)
        
        addSubview(stackview)
        stackview.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 24, bottom: 24, right: 24))
        self.topConstraint = stackview.topAnchor.constraint(equalTo: topAnchor, constant: 24)
        self.topConstraint?.isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
