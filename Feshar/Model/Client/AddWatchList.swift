//
//  AddWatchList.swift
//  Feshar
//
//  Created by Awady on 4/11/20.
//  Copyright © 2020 Awady. All rights reserved.
//

import Foundation

class AddWatchList {
    
    class func addToWatchlist(mediaId: Int, isWatchlist: Bool, completion: @escaping ([AddWatchlistResponse], Error?) -> Void) {
        
        var request = URLRequest(url: Client.EndPoints.addToWatchList.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = AddToWatchlistPost(mediaType: "movie", mediaId: mediaId, isWatchlist: isWatchlist)
        request.httpBody = try! JSONEncoder().encode(body)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                completion([], error)
                return
            }
            do {
                let decoder = JSONDecoder()
                let responseObject = try decoder.decode(AddWatchlistResponse.self, from: data)
                completion([responseObject], nil)
            } catch {
                completion([], error)
            }
        }
        task.resume()
    }
}
