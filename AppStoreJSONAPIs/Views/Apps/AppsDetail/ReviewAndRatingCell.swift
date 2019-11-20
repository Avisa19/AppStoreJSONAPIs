//
//  ReviewAndRatingCell.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 19/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

class ReviewAndRatingCell: UICollectionViewCell {
    
    var entry: Entry? {
        didSet {
            titleLabel.text = entry?.title.label
            bodyLabel.text = entry?.content.label
            authorLabel.text = entry?.author.name.label
            for (index, view) in starStackview.arrangedSubviews.enumerated() {
                guard let rating = Int(entry?.rating.label ?? "1") else { return }
                view.alpha = index >= rating ? 0 : 1
            }
        }
    }
    
   private let titleLabel = UILabel(text: "Review title", font: .boldSystemFont(ofSize: 18))
    
   private let authorLabel = UILabel(text: "Author", font: .systemFont(ofSize: 16))

   private let bodyLabel = UILabel(text: "Body label\nBody label\nBody label\nBody label\n", font: .systemFont(ofSize: 18), numberOfLines: 5)
    
   private let starStackview: UIStackView = {
        var arrangedSubviews = [UIView]()
        (0..<5).forEach({_ in
            let imageView = UIImageView(image: #imageLiteral(resourceName: "icons8-filled_star"))
            imageView.constrainWidth(constant: 24)
            imageView.constrainHeight(constant: 24)
            arrangedSubviews.append(imageView)
        })
        let stackview = UIStackView(arrangedSubviews: arrangedSubviews)
        return stackview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = #colorLiteral(red: 0.9430938363, green: 0.9399930239, blue: 0.9734050632, alpha: 1)
        authorLabel.textColor = .gray
        layer.cornerRadius = 16
        clipsToBounds = true
        
        let stackview = VerticalStackView(arrangedSubviews: [
            UIStackView(arrangedSubViews: [
                titleLabel,
                authorLabel
            ], customSpacing: 8),
            UIStackView(arrangedSubviews: [
                starStackview,
                UIView()
            ]),
            bodyLabel
        ], spacing: 12)
        
        titleLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
        
        authorLabel.textAlignment = .right
        addSubview(stackview)
        stackview.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
