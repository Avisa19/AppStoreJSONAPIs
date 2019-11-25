//
//  MusicLoadingFooter.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 25/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

class MusicLoadingFooter: UICollectionReusableView {
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let uiv = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        uiv.color = .darkGray
        uiv.startAnimating()
        return uiv
    }()
    
    let loadingLabel = UILabel(text: "Loading more...", font: .systemFont(ofSize: 16))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stackview = VerticalStackView(arrangedSubviews: [
            activityIndicatorView,
            loadingLabel
        ], spacing: 8)
        addSubview(stackview)
        stackview.alignment = .center
        stackview.centerInSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
