//
//  TodayMultipleAppCell.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 21/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

class TodayMultipleAppCell: BaseTodayCell {
    
   override var todayItem: TodayItem? {
        didSet {
            guard let todayItem = todayItem else { return }
            categoryLabel.text = todayItem.category
            titleLabel.text = todayItem.title
        }
    }
    
    let categoryLabel = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 20))
    let titleLabel = UILabel(text: "Utilizing your Time", font: .boldSystemFont(ofSize: 32))
    let multipleAppListController = UIViewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 16
        
        multipleAppListController.view.backgroundColor = .systemPink
        titleLabel.numberOfLines = 2
        
        let stackview = VerticalStackView(arrangedSubviews: [
            categoryLabel,
            titleLabel,
            multipleAppListController.view
        ], spacing: 12)
        
        addSubview(stackview)
        stackview.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
