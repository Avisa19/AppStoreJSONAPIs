//
//  AppsDetailCell.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 18/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

class AppsDetailCell: UICollectionViewCell {
    
    var app: Result? {
        didSet {
            if let app = app {
                appIconImageView.sd_setImage(with: URL(string: app.artworkUrl100), completed: nil)
                appLabel.text = app.trackName
                priceButton.setTitle(app.formattedPrice, for: .normal)
                releasedNoteLabel.text = app.releaseNotes
            }
        }
    }
    
   private let appIconImageView = UIImageView(cornerRadius: 16)
   private let appLabel = UILabel(text: "Facebook, Inc", font: .boldSystemFont(ofSize: 24), numberOfLines: 2)
   private let priceButton = UIButton(title: "$4.99")
   private let whatsNewLabel = UILabel(text: "What's New", font: .boldSystemFont(ofSize: 20))
   private let releasedNoteLabel = UILabel(text: "Released Note", font: .systemFont(ofSize: 16), numberOfLines: 0)
    let separatorLine = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        appIconImageView.constrainWidth(constant: 140)
        appIconImageView.constrainHeight(constant: 140)
    
        priceButton.backgroundColor = #colorLiteral(red: 0.1764705882, green: 0.4235294118, blue: 0.968627451, alpha: 1)
        priceButton.setTitleColor(.white, for: .normal)
        priceButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        priceButton.layer.cornerRadius = 32 / 2
        priceButton.constrainWidth(constant: 80)
    
        
        let stackView = VerticalStackView(arrangedSubviews: [
            UIStackView(arrangedSubViews: [
                appIconImageView,
                VerticalStackView(arrangedSubviews: [
                    appLabel,
                    UIStackView(arrangedSubviews: [
                        priceButton,
                        UIView()
                    ]),
                    UIView()
                ], spacing: 12)
                
            ], customSpacing: 20),
            whatsNewLabel,
            releasedNoteLabel
        ], spacing: 16)
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
        
        addSubview(separatorLine)
        separatorLine.anchor(top: stackView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0.5))
        separatorLine.backgroundColor = UIColor(white: 0.7, alpha: 0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UIStackView {
    convenience init(arrangedSubViews: [UIView], customSpacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubViews)
        self.spacing = customSpacing
    }
}
