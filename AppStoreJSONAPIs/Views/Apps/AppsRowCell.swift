//
//  AppsRowCell.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 16/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

class AppsRowCell: UICollectionViewCell {
    
    let imageView = UIImageView(cornerRadius: 12)
    let nameLabel = UILabel(text: "App name", font: .systemFont(ofSize: 20))
    let companyLabel = UILabel(text: "Company name", font: .systemFont(ofSize: 13))
    let getButton = UIButton(title: "GET")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.backgroundColor = .systemPink
        imageView.constrainWidth(constant: 64)
        imageView.constrainHeight(constant: 64)
        
        getButton.constrainWidth(constant: 80)
        getButton.constrainHeight(constant: 32)
        
        let stackview = UIStackView(arrangedSubviews: [
            imageView,
            VerticalStackView(arrangedSubviews: [
                nameLabel,
                companyLabel
            ]),
            getButton
        ])
        
        addSubview(stackview)
        stackview.fillSuperview()
        stackview.alignment = .center
        stackview.spacing = 16
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
