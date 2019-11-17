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
    
    func fetchTopGrossing(completion: @escaping (AppGroup?, Error?) -> ()) {
        
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/25/explicit.json"
        
        fetchAppGroup(urlString: urlString, completion: completion)
        
    }
    
    func fetchGames(completion: @escaping (AppGroup?, Error?) -> ()) {
        
        let url = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/50/explicit.json"
        
        fetchAppGroup(urlString: url, completion: completion)
    }
    
    func fetchTopFree(completion: @escaping (AppGroup?, Error?) -> ()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/25/explicit.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    // helper
    func fetchAppGroup(urlString: String, completion: @escaping (AppGroup?, Error?) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
              
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
                      
                  } catch let fetchAppErr {
                      print("Failed to fetch game data into jason:", fetchAppErr)
                      completion(nil, fetchAppErr)
                  }
                  
              }.resume() // This will fire your request.
    }
}
