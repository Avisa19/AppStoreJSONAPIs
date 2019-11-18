//
//  AppsDetailCell.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 18/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

class AppsDetailCell: UICollectionViewCell {
    
    let appIconImageView = UIImageView(cornerRadius: 16)
    let appLabel = UILabel(text: "Facebook, Inc", font: .boldSystemFont(ofSize: 24), numberOfLines: 2)
    let priceButton = UIButton(title: "$4.99")
    let whatsNewLabel = UILabel(text: "What's New", font: .boldSystemFont(ofSize: 20))
    let releasedNoteLabel = UILabel(text: "Released Note", font: .systemFont(ofSize: 16), numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        appIconImageView.backgroundColor = .systemPink
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
