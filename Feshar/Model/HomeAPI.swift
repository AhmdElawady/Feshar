//
//  HomeAPI.swift
//  Feshar
//
//  Created by Awady on 4/7/20.
//  Copyright © 2020 Awady. All rights reserved.
//

import UIKit

class HomeService {
    
    static var sharedInstance = HomeService()
    var allMovies: [MovieModel]?
    
    func fetchHomeJson(completion: @escaping (Result<[MovieModel], Error>) -> ()) {
        
        guard let url = URL(string: BaseURLs.homeUrl) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {return}
            do {
                let decoder = JSONDecoder()
                let homeDataResponse = try decoder.decode(HomeModel.self, from: data)
                self.allMovies = homeDataResponse.results
                completion(.success(homeDataResponse.results))
                
            } catch let jsonError{
                completion(.failure(jsonError))
            }
        }.resume()
    }
    

    
    
    
    
    
    
    
    
    
    
    
    
    
}
