//
//  SearchAppCell.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 15/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

class SearchAppCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
       let iv = UIImageView()
        iv.backgroundColor = .systemPink
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
        iv.layer.cornerRadius = 12
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
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        let labelViews = [
            nameLabel,
            categoryLabel,
            ratingLabel
        ]
        
        let labelsStackView = UIStackView(arrangedSubviews: labelViews)
        labelsStackView.axis = .vertical
        
        let arrangedViews = [
            imageView,
            labelsStackView,
            getButton
        ]
        
        let stackView = UIStackView(arrangedSubviews: arrangedViews)
        // everythings is going to be centered inside stackView.
        stackView.alignment = .center
        addSubview(stackView)
        stackView.spacing = 12
        stackView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
