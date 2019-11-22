//
//  MultipleAppCell.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 22/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit


class MultipleAppCell: UICollectionViewCell {
    
    var result: FeedResult? {
        didSet {
            guard let result = result else { return }
            
            imageView.sd_setImage(with: URL(string: result.artworkUrl100), completed: nil)
            nameLabel.text = result.name
            companyLabel.text = result.artistName
        }
    }
    
    private let imageView = UIImageView(cornerRadius: 12)
    private let nameLabel = UILabel(text: "App name", font: .systemFont(ofSize: 20))
    private let companyLabel = UILabel(text: "Company name", font: .systemFont(ofSize: 13))
    private let getButton = UIButton(title: "GET")
    
    private let seperatorview: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(white: 0.3, alpha: 0.3)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        
        addSubview(seperatorview)
        seperatorview.anchor(top: stackview.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 0.5))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    }
