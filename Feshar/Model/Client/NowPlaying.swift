//
//  NowPlaying.swift
//  Feshar
//
//  Created by Awady on 4/10/20.
//  Copyright © 2020 Awady. All rights reserved.
//

import Foundation

class NowPlaying {
    
    class func getNowPlayingMovies(completion: @escaping ([Movie], Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: Client.EndPoints.getNowPlaying.url) { (data, response, error) in
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
}
