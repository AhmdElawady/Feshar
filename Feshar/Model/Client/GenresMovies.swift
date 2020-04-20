//
//  Genres.swift
//  Feshar
//
//  Created by Awady on 4/11/20.
//  Copyright © 2020 Awady. All rights reserved.
//

import Foundation

class GenresMovies {
    
    var genres = [Genre]()
    
    class func getGenresMovies(completion: @escaping ([Genre], Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: Client.EndPoints.getGenres.url) { (data, response, error) in
            guard let data = data else {
                completion([], error)
                return
            }
            do {
                let decoder = JSONDecoder()
                let responseObject = try decoder.decode(GenreResponse.self, from: data)
                completion(responseObject.genres, nil)
            } catch {
                completion([], error)
            }
        }
        task.resume()
    }
}
