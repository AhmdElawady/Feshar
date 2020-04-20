//
//  getCast.swift
//  Feshar
//
//  Created by Awady on 4/11/20.
//  Copyright © 2020 Awady. All rights reserved.
//

import Foundation

class Credit {
    
    class func getCast(movieId: Int, completion: @escaping ([Cast], Error?) -> Void) {
        Client.Auth.parameter = movieId
        let task = URLSession.shared.dataTask(with: Client.EndPoints.getCredits.url) { (data, response, error) in
            guard let data = data else {
                completion([], error)
                return
            }
            do {
                let decoder = JSONDecoder()
                let responseObject = try decoder.decode(CastResponse.self, from: data)
                completion(responseObject.cast, nil)
            } catch {
                completion([], error)
            }
        }
        task.resume()
    }
}
