//
//  Service.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 15/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit


class Service {
    
    static let shared = Service() //Singletone
    
    func fetchApps(completion: @escaping ([Result], Error?) -> ()) {
        let urlString = "https://itunes.apple.com/search?term=instagram&entity=software"
        guard let url = URL(string: urlString) else { return }
        
        // fetch data from internet
        URLSession.shared.dataTask(with: url) { (data, respo, err) in
            if let err = err {
                print("Failed to fetch data from internet:", err)
                completion([], nil)
                return
            }
            
            // success
            guard let data = data else { return }
            do {
                
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                //                print(searchResult)
                //                searchResult.results.forEach({print($0.trackName)})
                
                completion(searchResult.results, nil)
                
            } catch let jsonErr {
                print("Failed to fetch json Url:", jsonErr)
                completion([], jsonErr)
            }
            
        }.resume() // fires off the request
    }
}
