//
//  AppsFullScreenController.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 21/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit


class AppsFullScreenController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var dismissHandler: (() -> ())?
    
    var todayItem: TodayItem?
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            
            scrollView.isScrollEnabled = false
            scrollView.isScrollEnabled = true
        }
    }
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "icons8-cancel"), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.clipsToBounds = true
        
        view.addSubview(tableView)
        tableView.fillSuperview()
        tableView.dataSource = self
        tableView.delegate = self
        
        setupCloseButton()
        
        view.backgroundColor = .white
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.contentInsetAdjustmentBehavior = .never
    
        let height = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        tableView.contentInset = .init(top: 0, left: 0, bottom: height, right: 0)
    }
    
    fileprivate func setupCloseButton() {
        view.addSubview(closeButton)
        closeButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 44, left: 0, bottom: 0, right: 12), size: .init(width: 80, height: 38))
         closeButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let headerCell = FullScreenHeaderCell()
            headerCell.todayCell.todayItem = self.todayItem
            headerCell.todayCell.layer.cornerRadius = 0
            headerCell.clipsToBounds = true
            headerCell.todayCell.backgroundColor = nil
            return headerCell
        } else {
            let cell = FullScreenCell()
            return cell
        }
    }
    
    @objc fileprivate func handleDismiss(button: UIButton) {
        
        button.isHidden = true
        dismissHandler?()
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // for the first row it's ok, for the rest let tableview handle automatically
        if indexPath.row == 0 {
            return TodayController.cellSize
        } else {
            return UITableView.automaticDimension
        }
    }
    
}
