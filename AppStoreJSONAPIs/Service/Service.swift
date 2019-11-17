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
    
    func fetchApps(searchTerm: String, completion: @escaping ([Result], Error?) -> ()) {
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
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
    
    func fetchGames(completion: @escaping (AppGroup?, Error?) -> ()) {
        guard let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/50/explicit.json") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, respo, err) in
            
            if let err = err {
                print("Failed to fecth games:", err)
                completion(nil, err)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let appGroup = try JSONDecoder().decode(AppGroup.self, from: data)
                
               completion(appGroup, nil)
                
            } catch let fetchGameErr {
                print("Failed to fetch game data into jason:", fetchGameErr)
                completion(nil, fetchGameErr)
            }
            
        }.resume() // This will fire your request.
    }
}
