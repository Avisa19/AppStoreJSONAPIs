//
//  Extensions.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 16/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont, numberOfLines: Int = 1) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
    }
}

extension UIImageView {
    convenience init(cornerRadius: CGFloat) {
        self.init(image: nil)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
    }
}

extension UIButton {
    convenience init(title: String) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.setTitleColor(.systemBlue, for: .normal)
        self.layer.cornerRadius = 8
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        self.backgroundColor = UIColor(white: 0.95, alpha: 1)
    }
}
