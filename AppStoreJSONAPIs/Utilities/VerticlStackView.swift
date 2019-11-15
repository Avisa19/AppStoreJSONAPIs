//
//  VerticlStackView.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 15/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

class VerticlStackView: UIStackView {

  
    init(arrangedViews: [UIView], spacing: CGFloat = 0) {
        super.init(frame: .zero)
        self.spacing = spacing
        arrangedViews.forEach({addArrangedSubview($0)})
        self.axis = .vertical
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
