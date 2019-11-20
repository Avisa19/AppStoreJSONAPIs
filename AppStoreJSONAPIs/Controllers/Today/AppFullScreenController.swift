//
//  AppFullScreenController.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 20/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

class AppFullScreenController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            return AppFullScreenHeaderCell()
        } else {
            let cell = AppFullScreenDescriptionCell()
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 450
        } else {
            // for second cell let tableview handle it automatically
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
}
