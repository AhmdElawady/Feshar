//
//  FeaturedMoviesApi.swift
//  Feshar
//
//  Created by Awady on 4/13/20.
//  Copyright © 2020 Awady. All rights reserved.
//

import Foundation


class FeaturedApi {
    
    class func getFeaturedMovie(completion: @escaping ([Movie], Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: Client.EndPoints.getMovieDescover.url) { (data, response, error) in
            guard let data = data else {
                completion([], error)
                return
            }
            do {
                let decoder = JSONDecoder()
                let responseObject = try decoder.decode(MovieResults.self, from: data)
                completion(responseObject.results, nil)
            } catch {
                completion([], error)
            }
        }
        task.resume()
    }
    
    
    class func getFeaturedTVShow(completion: @escaping ([TVShow], Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: Client.EndPoints.getTVDiscover.url) { (data, response, error) in
            guard let data = data else {
                completion([], error)
                return
            }
            do {
                let decoder = JSONDecoder()
                let responseObject = try decoder.decode(TVShowResults.self, from: data)
                completion(responseObject.results, nil)
            } catch {
                completion([], error)
            }
        }
        task.resume()
    }
}
