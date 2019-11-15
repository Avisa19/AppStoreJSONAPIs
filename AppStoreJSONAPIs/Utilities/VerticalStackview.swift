//
//  VerticalStackview.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 15/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

class VerticalStackview: UIStackView {

    init(arrangedViews: [UIView], spacing: CGFloat = 0) {
        super.init(frame: .zero)
        self.axis = .vertical
        self.spacing = spacing
        arrangedViews.forEach({addArrangedSubview($0)})
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
