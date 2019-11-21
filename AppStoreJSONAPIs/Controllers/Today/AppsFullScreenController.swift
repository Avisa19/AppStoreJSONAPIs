//
//  AppsFullScreenController.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 21/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit


class AppsFullScreenController: UITableViewController {
    
    var dismissHandler: (() -> ())?
    
    var todayItem: TodayItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = FullScreenHeaderCell()
            cell.closeButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
            cell.todayCell.todayItem = self.todayItem
            return cell
        } else {
            let cell = FullScreenCell()
            return cell
        }
    }
    
    @objc fileprivate func handleDismiss(button: UIButton) {
        
        button.isHidden = true
        dismissHandler?()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // for the first row it's ok, for the rest let tableview handle automatically
        if indexPath.row == 0 {
            return 450
        } else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
}
